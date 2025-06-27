import 'package:flutter/material.dart';
import 'package:flutter_application_2/translated_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TranslatedText('About')),
      body: const Center(
        child: TranslatedText(
          'This is the about page. It tells you more about the app.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
