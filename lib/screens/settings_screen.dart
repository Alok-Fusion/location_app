import 'package:flutter/material.dart';
import 'package:flutter_application_2/translated_text.dart';
import 'package:provider/provider.dart';
import '../locale_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const TranslatedText('Settings')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const TranslatedText('Change Language:'),
          Wrap(
            spacing: 10,
            children: [
              _langButton(context, provider, 'en', 'English'),
              _langButton(context, provider, 'fr', 'Français'),
              _langButton(context, provider, 'es', 'Español'),
              _langButton(context, provider, 'de', 'Deutsch'),
              _langButton(context, provider, 'hi', 'हिन्दी'),
              _langButton(context, provider, 'ja', '日本語'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _langButton(BuildContext context, LocaleProvider provider, String code,
      String label) {
    return ElevatedButton(
      onPressed: () => provider.setLocale(code),
      child: Text(label),
    );
  }
}
