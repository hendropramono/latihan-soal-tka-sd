import 'package:flutter/material.dart';
import 'package:latihan_soal_tka_sd/core/widgets/app_background.dart';
import 'package:latihan_soal_tka_sd/models/question_models.dart';
import 'package:latihan_soal_tka_sd/pages/review_page.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final List<Question> questions;
  final Map<String, dynamic> userAnswers;

  const ResultPage({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.questions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = totalQuestions > 0 ? (score / totalQuestions) * 100 : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Latihan'),
        automaticallyImplyLeading: false,
      ),
      body: AppBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Latihan Selesai!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 32),
                Text(
                  'Skor Anda:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '${percentage.toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '$score dari $totalQuestions poin benar',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewPage(
                          questions: questions,
                          userAnswers: userAnswers,
                        ),
                      ),
                    );
                  },
                  child: const Text('Lihat Pembahasan'),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text('Kembali ke Halaman Utama'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
