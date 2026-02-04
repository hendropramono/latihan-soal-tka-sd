import 'package:cloud_firestore/cloud_firestore.dart';

class PaketSoal {
  final String id;
  final String title;
  final List<String> questionIds;
  final Timestamp createdAt;

  PaketSoal({
    required this.id,
    required this.title,
    required this.questionIds,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'questionIds': questionIds,
      'createdAt': createdAt,
    };
  }

  factory PaketSoal.fromJson(Map<String, dynamic> json) {
    return PaketSoal(
      id: json['id'],
      title: json['title'],
      questionIds: List<String>.from(json['questionIds']),
      createdAt: json['createdAt'] as Timestamp,
    );
  }
}
