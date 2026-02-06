import 'package:vink_sim/core/config/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vink_sim/vink_sim.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables based on build mode
  await Environment.load();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void _changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vink SIM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
      ),
      locale: _locale,
      localizationsDelegates: const [
        SimLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: SimLocalizations.supportedLocales,
      home: FeatureRoot(
        config: FeatureConfig(
          isShellMode: false,
          onLocaleChanged: _changeLocale,
        ),
      ),
    );
  }
}
