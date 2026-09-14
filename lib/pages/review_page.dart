import 'package:flutter/material.dart';
import 'package:latihan_soal_tka_sd/core/widgets/app_background.dart';
import 'package:latihan_soal_tka_sd/models/question_models.dart';
import 'package:latihan_soal_tka_sd/widgets/rich_text_viewer.dart';

class ReviewPage extends StatelessWidget {
  final List<Question> questions;
  final Map<String, dynamic> userAnswers;

  const ReviewPage({
    super.key,
    required this.questions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembahasan Soal')),
      body: AppBackground(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return _buildReviewItem(context, questions[index], index + 1);
          },
        ),
      ),
    );
  }

  Widget _buildReviewItem(BuildContext context, Question question, int number) {
    final answer = userAnswers[question.id];
    bool isCorrect = false;

    if (question is MultipleChoiceQuestion) {
      isCorrect = answer == question.correctOptionId;
    } else if (question is ComplexMultipleChoiceQuestion) {
      final Map<String, bool> userAnsMap = Map<String, bool>.from(answer ?? {});
      isCorrect = true;
      question.correctAnswers.forEach((key, value) {
        if (userAnsMap[key] != value) isCorrect = false;
      });
    } else if (question is MultiSelectQuestion) {
      final List<String> userAnsList = List<String>.from(answer ?? []);
      isCorrect = userAnsList.length == question.correctOptionIds.length &&
          userAnsList.every((id) => question.correctOptionIds.contains(id));
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardBg = isCorrect
        ? (isDark ? Colors.green.withOpacity(0.15) : Colors.green.shade50)
        : (isDark ? Colors.red.withOpacity(0.15) : Colors.red.shade50);
    final Color borderColor = isCorrect ? Colors.green : Colors.red;

    return Card(
      margin: const EdgeInsets.only(bottom: 24.0),
      color: cardBg,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Soal No. $number',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                ),
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: borderColor,
                ),
              ],
            ),
            const Divider(),
            RichTextViewer(
              content: question.questionContent,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            _buildAnswerReview(context, question, answer, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerReview(BuildContext context, Question question, dynamic userAnswer, bool isDark) {
    if (question is MultipleChoiceQuestion) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: question.options.map((option) {
          final isCorrectOption = option.id == question.correctOptionId;
          final isUserSelected = option.id == userAnswer;

          Color? bgColor;
          if (isCorrectOption) {
            bgColor = isDark ? Colors.green.withOpacity(0.3) : Colors.green.shade100;
          } else if (isUserSelected) {
            bgColor = isDark ? Colors.red.withOpacity(0.3) : Colors.red.shade100;
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
              border: isCorrectOption || isUserSelected
                  ? Border.all(color: isCorrectOption ? Colors.green : Colors.red)
                  : null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: RichTextViewer(
                    content: option.content,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                if (isCorrectOption) const Icon(Icons.check, color: Colors.green, size: 20),
                if (isUserSelected && !isCorrectOption) const Icon(Icons.close, color: Colors.red, size: 20),
              ],
            ),
          );
        }).toList(),
      );
    }

    if (question is ComplexMultipleChoiceQuestion) {
      final Map<String, bool> userAnsMap = Map<String, bool>.from(userAnswer ?? {});
      return Column(
        children: question.statements.map((statement) {
          final correctVal = question.correctAnswers[statement.id];
          final userVal = userAnsMap[statement.id];
          final isWrong = userVal != null && userVal != correctVal;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: RichTextViewer(
                    content: statement.content,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Kunci: ${correctVal! ? 'Benar' : 'Salah'}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.greenAccent : Colors.green.shade700,
                  ),
                ),
                if (isWrong) ...[
                  const SizedBox(width: 8),
                  Text(
                    "(Anda: ${userVal ? 'Benar' : 'Salah'})",
                    style: TextStyle(
                      color: isDark ? Colors.redAccent : Colors.red.shade700,
                    ),
                  ),
                ]
              ],
            ),
          );
        }).toList(),
      );
    }

    if (question is MultiSelectQuestion) {
      final List<String> userAnsList = List<String>.from(userAnswer ?? []);
      return Column(
        children: question.options.map((option) {
          final isCorrect = question.correctOptionIds.contains(option.id);
          final isSelected = userAnsList.contains(option.id);

          Color? bgColor;
          if (isCorrect) {
            bgColor = isDark ? Colors.green.withOpacity(0.3) : Colors.green.shade100;
          } else if (isSelected) {
            bgColor = isDark ? Colors.red.withOpacity(0.3) : Colors.red.shade100;
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
              border: isCorrect || isSelected
                  ? Border.all(color: isCorrect ? Colors.green : Colors.red)
                  : null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: RichTextViewer(
                    content: option.content,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                if (isCorrect) const Icon(Icons.check, color: Colors.green, size: 20),
                if (isSelected && !isCorrect) const Icon(Icons.close, color: Colors.red, size: 20),
              ],
            ),
          );
        }).toList(),
      );
    }

    return const SizedBox();
  }
}
