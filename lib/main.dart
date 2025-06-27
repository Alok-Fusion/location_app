import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'locale_provider.dart';
import 'startup_loader.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context).locale;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: const [
        Locale('af'),
        Locale('am'),
        Locale('ar'),
        Locale('as'),
        Locale('az'),
        Locale('be'),
        Locale('bg'),
        Locale('bn'),
        Locale('bo'),
        Locale('bs'),
        Locale('ca'),
        Locale('cs'),
        Locale('da'),
        Locale('de'),
        Locale('dv'),
        Locale('el'),
        Locale('en'),
        Locale('es'),
        Locale('et'),
        Locale('eu'),
        Locale('fa'),
        Locale('fi'),
        Locale('fil'),
        Locale('fr'),
        Locale('ga'),
        Locale('gl'),
        Locale('gu'),
        Locale('he'),
        Locale('hi'),
        Locale('hr'),
        Locale('hu'),
        Locale('hy'),
        Locale('id'),
        Locale('is'),
        Locale('it'),
        Locale('ja'),
        Locale('ka'),
        Locale('kk'),
        Locale('km'),
        Locale('kn'),
        Locale('ko'),
        Locale('ku'),
        Locale('ky'),
        Locale('lo'),
        Locale('lt'),
        Locale('lv'),
        Locale('mk'),
        Locale('ml'),
        Locale('mn'),
        Locale('mr'),
        Locale('ms'),
        Locale('mt'),
        Locale('nb'),
        Locale('ne'),
        Locale('nl'),
        Locale('no'),
        Locale('or'),
        Locale('pa'),
        Locale('pl'),
        Locale('ps'),
        Locale('pt'),
        Locale('ro'),
        Locale('ru'),
        Locale('sd'),
        Locale('si'),
        Locale('sk'),
        Locale('sl'),
        Locale('sq'),
        Locale('sr'),
        Locale('sv'),
        Locale('sw'),
        Locale('ta'),
        Locale('te'),
        Locale('th'),
        Locale('tl'),
        Locale('tr'),
        Locale('uk'),
        Locale('ur'),
        Locale('uz'),
        Locale('vi'),
        Locale('zh'),
        Locale('zu'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const StartupLoader(),
    );
  }
}
