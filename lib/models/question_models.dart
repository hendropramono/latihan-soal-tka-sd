import 'rich_text_content.dart';

// Enum untuk tipe soal, bisa diperluas nanti
enum QuestionType {
  multipleChoice,
}

/// Kelas dasar untuk semua soal. Saat ini hanya sebagai fondasi.
abstract class Question {
  final String id;
  final QuestionType type;
  final List<RichTextContent> questionContent;
  final String? instructionText;
  final int points;

  Question({
    required this.id,
    required this.type,
    required this.questionContent,
    this.instructionText,
    required this.points,
  });

  Map<String, dynamic> toJson();
}

/// Model untuk satu opsi jawaban dalam soal pilihan ganda.
class Option {
  final String id;
  final List<RichTextContent> content;

  Option({required this.id, required this.content});

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content.map((c) => c.toJson()).toList(),
      };

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      content: (json['content'] as List)
          .map((c) => RichTextContent.fromJson(c))
          .toList(),
    );
  }
}

/// Model untuk Soal Pilihan Ganda.
class MultipleChoiceQuestion extends Question {
  final List<Option> options;
  final String correctOptionId;

  MultipleChoiceQuestion({
    required super.id,
    required super.questionContent,
    required this.options,
    required this.correctOptionId,
    super.instructionText,
    super.points = 1,
  }) : super(type: QuestionType.multipleChoice);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'questionContent': questionContent.map((c) => c.toJson()).toList(),
      'options': options.map((o) => o.toJson()).toList(),
      'correctOptionId': correctOptionId,
      'instructionText': instructionText,
      'points': points,
      // Tambahkan timestamp untuk pengurutan atau audit
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  factory MultipleChoiceQuestion.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceQuestion(
      id: json['id'],
      questionContent: (json['questionContent'] as List)
          .map((c) => RichTextContent.fromJson(c))
          .toList(),
      options: (json['options'] as List)
          .map((o) => Option.fromJson(o))
          .toList(),
      correctOptionId: json['correctOptionId'],
      instructionText: json['instructionText'],
      points: json['points'] ?? 1,
    );
  }
}
