import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latihan_soal_tka_sd/core/widgets/app_background.dart';
import 'package:latihan_soal_tka_sd/models/paket_soal_app_model.dart';
import 'package:latihan_soal_tka_sd/pages/question_page.dart';

class QuestionPackageListPage extends StatelessWidget {
  final String subject;

  const QuestionPackageListPage({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection('/apps/T7chmLCxDNhyxt4r2EAQ/app_question_packages')
        .where('tag', arrayContains:  subject)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(subject),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('Belum ada paket soal'));
            }

            final docs = snapshot.data!.docs;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final doc = docs[index];
                final paketSoal = PaketSoalApp.fromJson(doc.data() as Map<String, dynamic>);

                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: ListTile(
                    title: Text(paketSoal.title),
                    subtitle: Text('Dibuat: ${paketSoal.createdAt.toDate().toLocal().toString().split(' ')[0]}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionPage(
                            packageId: paketSoal.packageId, // Menggunakan ID dokumen sebagai packageId
                            packageTitle: paketSoal.title,
                          ),
                        ),
                      );
                    },
                  ), 
                );
              },
            );
          },
        ),
      ),
    );
  }
}
