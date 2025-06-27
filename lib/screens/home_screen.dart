import 'package:flutter/material.dart';
import 'package:flutter_application_2/translated_text.dart';
import 'package:flutter_application_2/screens/about_screen.dart';
import 'package:flutter_application_2/screens/settings_screen.dart';

import 'package:provider/provider.dart';
import '../locale_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currency = Provider.of<LocaleProvider>(context).currencySymbol;

    return Scaffold(
      appBar: AppBar(title: const TranslatedText('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TranslatedText('Welcome to the app!',
                style: TextStyle(fontSize: 24)),
            Text('Example price: $currency 100'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AboutScreen()));
              },
              child: const TranslatedText('Go to About'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()));
              },
              child: const TranslatedText('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
