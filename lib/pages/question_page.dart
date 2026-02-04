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
  late final Future<List<MultipleChoiceQuestion>> _loadQuestionsFuture;
  final Map<String, String?> _selectedAnswers = {};

  @override
  void initState() {
    super.initState();
    _loadQuestionsFuture = _loadQuestions();
  }

  Future<List<MultipleChoiceQuestion>> _loadQuestions() async {
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

      // Make sure the order is correct
      final questionMap = {for (var doc in questionsSnapshot.docs) doc.id: MultipleChoiceQuestion.fromJson(doc.data())};
      return questionIds.map((id) => questionMap[id]!).toList();

    } catch (e) {
      throw Exception('Gagal memuat soal: $e');
    }
  }

  void _submit(List<MultipleChoiceQuestion> questions) {
    int score = 0;
    for (var question in questions) {
      if (_selectedAnswers[question.id] == question.correctOptionId) {
        score++;
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          score: score,
          totalQuestions: questions.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.packageTitle)),
      body: AppBackground(
        child: FutureBuilder<List<MultipleChoiceQuestion>>(
          future: _loadQuestionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(snapshot.error.toString()),
              ));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada soal di dalam paket ini.'));
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

  Widget _buildQuestionItem(MultipleChoiceQuestion question, int questionNumber) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Soal No. $questionNumber',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),
            RichTextViewer(
              content: question.questionContent,
              defaultTextStyle: Theme.of(context).textTheme.bodyLarge ?? const TextStyle(),
            ),
            const SizedBox(height: 24),
            Column(
              children: question.options.map((option) {
                return RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  title: RichTextViewer(
                    content: option.content,
                    defaultTextStyle: Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(List<MultipleChoiceQuestion> questions) {
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
