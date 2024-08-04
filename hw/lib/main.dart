import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hw/firebase_options.dart';
import 'signup/sign_up_screen.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHome(),
      localizationsDelegates: const [
        Batch16String.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: Batch16String.delegate.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.light,
          background: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.limeAccent,
          brightness: Brightness.dark,
          background: Colors.black,
        ),
      ),
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) {
          switch (settings.name) {
            case 'sorry':
              return const SorryScreen();
            default:
              return const UnknownScreen();
          }
        },
      ),
    );
  }
}

class PrivateMaterialLocalizations extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == 'vi' || locale.languageCode == 'en';
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    // TODO: implement load
    return SynchronousFuture<MaterialLocalizations>(
        PrivateMaterialLocalizations() as MaterialLocalizations);
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<MaterialLocalizations> old) =>
      false;
}
class SorryScreen extends StatelessWidget {
  const SorryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sorry'),
      ),
      body: Center(
        child: Text('Sorry, something went wrong!'),
      ),
    );
  }
}
class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unknown'),
      ),
      body: Center(
        child: Text('Unknown route!'),
      ),
    );
  }
}


