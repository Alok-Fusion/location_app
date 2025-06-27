import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslationService {
  static final GoogleTranslator _translator = GoogleTranslator();
  static final Map<String, String> _memoryCache = {};

  static Future<String> translate(BuildContext context, String text) async {
    final locale = Localizations.localeOf(context);
    final langCode = locale.languageCode;

    if (langCode == 'en') return text;

    final cacheKey = '${langCode}_$text';

    if (_memoryCache.containsKey(cacheKey)) {
      return _memoryCache[cacheKey]!;
    }

    try {
      final translation = await _translator.translate(text, to: langCode);
      final translatedText = translation.text;

      _memoryCache[cacheKey] = translatedText;
      return translatedText;
    } catch (e) {
      debugPrint('Translation failed: $e');
      return text;
    }
  }
}
