import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:latihan_soal_tka_sd/core/config/app_theme.dart';
import 'package:latihan_soal_tka_sd/core/widgets/app_background.dart';
import 'package:latihan_soal_tka_sd/pages/question_package_list_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = ThemeData.light().textTheme;
    final materialTheme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Latihan Soal TKA SD',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Latihan Soal TKA SD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Firebase is connected!'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo_besar.png', // Pastikan file ini ada
                  height: 150,
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(              widget.title,
                    style: Theme.of(context).textTheme.headlineSmall,),
                ),
                const SizedBox(height: 56),
                Card(
                  elevation: 4.0,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  clipBehavior: Clip.antiAlias, // Ensures content is clipped to the shape
                  child: InkWell(
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuestionPackageListPage(subject: 'Matematika'),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 150,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -20,
                            right: -20,
                            child: Icon(
                              Icons.calculate_outlined,
                              size: 120,
                              color: Theme.of(context).colorScheme.onSecondaryContainer.withOpacity(0.05),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Matematika',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSecondaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 4.0,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuestionPackageListPage(subject: 'Bahasa Indonesia'),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 150,
                      child: Stack(
                        children: [
                          Positioned(
                            top: -20,
                            left: -20,
                            child: Icon(
                              Icons.menu_book_outlined,
                              size: 120,
                              color: Theme.of(context).colorScheme.onSecondaryContainer.withOpacity(0.05),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Bahasa Indonesia',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSecondaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
