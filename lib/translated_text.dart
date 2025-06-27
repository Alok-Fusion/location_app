import 'package:flutter/material.dart';
import 'translation_service.dart';

class TranslatedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const TranslatedText(this.text, {super.key, this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: TranslationService.translate(context, text),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else if (snapshot.hasError) {
          return Text(text, style: style, textAlign: textAlign);
        } else {
          return Text(snapshot.data ?? text, style: style, textAlign: textAlign);
        }
      },
    );
  }
}
