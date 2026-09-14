import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latihan_soal_tka_sd/core/widgets/app_background.dart';
import 'package:latihan_soal_tka_sd/models/question_models.dart';
import 'package:latihan_soal_tka_sd/pages/result_page.dart';
import 'package:latihan_soal_tka_sd/widgets/rich_text_viewer.dart';

class QuestionPage extends StatefulWidget {
  final String packageId;
  final String packageTitle;

  const QuestionPage({super.key, required this.packageId, required this.packageTitle});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late final Future<List<Question>> _loadQuestionsFuture;
  final Map<String, dynamic> _selectedAnswers = {};

  @override
  void initState() {
    super.initState();
    _loadQuestionsFuture = _loadQuestions();
  }

  Future<List<Question>> _loadQuestions() async {
    try {
      final packageDoc = await FirebaseFirestore.instance
          .collection('question_packages')
          .doc(widget.packageId)
          .get();

      if (!packageDoc.exists) {
        throw Exception('Paket soal tidak ditemukan (ID: ${widget.packageId})');
      }

      final questionIds = List<String>.from(packageDoc.data()!['questionIds'] ?? []);

      if (questionIds.isEmpty) {
        return [];
      }

      final questionsSnapshot = await FirebaseFirestore.instance
          .collection('questions')
          .where(FieldPath.documentId, whereIn: questionIds)
          .get();

      // Map hasil fetch dan urutkan kembali sesuai urutan di questionIds
      final questionMap = {
        for (var doc in questionsSnapshot.docs)
          doc.id: _parseQuestion(doc.id, doc.data())
      };

      return questionIds
          .where((id) => questionMap.containsKey(id))
          .map((id) => questionMap[id]!)
          .toList();
    } catch (e) {
      throw Exception('Gagal memuat soal: $e');
    }
  }

  Question _parseQuestion(String id, Map<String, dynamic> data) {
    // Injeksi ID ke data agar factory fromJson bisa bekerja dengan benar
    data['id'] = id;
    
    final typeStr = data['type'] as String?;
    if (typeStr == QuestionType.multipleChoice.name) {
      return MultipleChoiceQuestion.fromJson(data);
    } else if (typeStr == QuestionType.complexMultipleChoice.name) {
      return ComplexMultipleChoiceQuestion.fromJson(data);
    } else if (typeStr == QuestionType.multiSelect.name) {
      return MultiSelectQuestion.fromJson(data);
    } else {
      throw UnimplementedError('Tipe soal tidak dikenal: $typeStr');
    }
  }

  void _submit(List<Question> questions) {
    int score = 0;
    int totalPoints = 0;

    for (var question in questions) {
      totalPoints += question.points;
      final answer = _selectedAnswers[question.id];

      if (question is MultipleChoiceQuestion) {
        if (answer == question.correctOptionId) {
          score += question.points;
        }
      } else if (question is ComplexMultipleChoiceQuestion) {
        final Map<String, bool> userAnswers = Map<String, bool>.from(answer ?? {});
        bool allCorrect = true;
        question.correctAnswers.forEach((key, value) {
          if (userAnswers[key] != value) {
            allCorrect = false;
          }
        });
        if (allCorrect) score += question.points;
      } else if (question is MultiSelectQuestion) {
        final List<String> userAnswers = List<String>.from(answer ?? []);
        if (userAnswers.length == question.correctOptionIds.length &&
            userAnswers.every((id) => question.correctOptionIds.contains(id))) {
          score += question.points;
        }
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          score: score,
          totalQuestions: totalPoints,
          questions: questions,
          userAnswers: Map<String, dynamic>.from(_selectedAnswers),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.packageTitle)),
      body: AppBackground(
        child: FutureBuilder<List<Question>>(
          future: _loadQuestionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(snapshot.error.toString()),
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada soal ditemukan.'));
            }

            final questions = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: questions.length + 1,
              itemBuilder: (context, index) {
                if (index == questions.length) {
                  return _buildSubmitButton(questions);
                }
                return _buildQuestionItem(questions[index], index + 1);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuestionItem(Question question, int questionNumber) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Soal No. $questionNumber',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${question.points} Poin',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            if (question.instructionText != null) ...[
              const SizedBox(height: 8),
              Text(
                question.instructionText!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
              ),
            ],
            const Divider(height: 24),
            if (question.imageUrl != null) ...[
              Image.network(
                question.imageUrl!,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 50),
              ),
              const SizedBox(height: 16),
            ],
            RichTextViewer(
              content: question.questionContent,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            _buildAnswerArea(question),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerArea(Question question) {
    if (question is MultipleChoiceQuestion) {
      return _buildMultipleChoiceOptions(question);
    } else if (question is ComplexMultipleChoiceQuestion) {
      return _buildComplexMultipleChoiceOptions(question);
    } else if (question is MultiSelectQuestion) {
      return _buildMultiSelectOptions(question);
    }
    return const SizedBox();
  }

  Widget _buildMultipleChoiceOptions(MultipleChoiceQuestion question) {
    return Column(
      children: question.options.map((option) {
        return RadioListTile<String>(
          contentPadding: EdgeInsets.zero,
          title: RichTextViewer(
            content: option.content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          value: option.id,
          groupValue: _selectedAnswers[question.id],
          onChanged: (String? value) {
            setState(() {
              _selectedAnswers[question.id] = value;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildComplexMultipleChoiceOptions(ComplexMultipleChoiceQuestion question) {
    final Map<String, bool> currentAnswers = Map<String, bool>.from(_selectedAnswers[question.id] ?? {});

    return Column(
      children: question.statements.map((statement) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: RichTextViewer(
                  content: statement.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(width: 8),
              ToggleButtons(
                isSelected: [
                  currentAnswers[statement.id] == true,
                  currentAnswers[statement.id] == false,
                ],
                onPressed: (index) {
                  setState(() {
                    currentAnswers[statement.id] = index == 0;
                    _selectedAnswers[question.id] = currentAnswers;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                constraints: const BoxConstraints(minHeight: 32, minWidth: 60),
                children: const [
                  Text("Benar"),
                  Text("Salah"),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMultiSelectOptions(MultiSelectQuestion question) {
    final List<String> currentAnswers = List<String>.from(_selectedAnswers[question.id] ?? []);

    return Column(
      children: question.options.map((option) {
        return CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: RichTextViewer(
            content: option.content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          value: currentAnswers.contains(option.id),
          onChanged: (bool? checked) {
            setState(() {
              if (checked == true) {
                currentAnswers.add(option.id);
              } else {
                currentAnswers.remove(option.id);
              }
              _selectedAnswers[question.id] = currentAnswers;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildSubmitButton(List<Question> questions) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          textStyle: Theme.of(context).textTheme.titleMedium,
        ),
        onPressed: () => _submit(questions),
        child: const Text('Selesaikan Latihan'),
      ),
    );
  }
}
