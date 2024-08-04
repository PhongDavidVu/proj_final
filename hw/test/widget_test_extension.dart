
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw/generated/l10n.dart';
import 'package:hw/main.dart';
import 'package:hw/signup/sign_up_screen.dart';

extension WidgetWrapper on WidgetTester {
  Future<void> wrapAndPump(Widget widget, {RouteFactory? routeFactory}) {
   return pumpWidget( MaterialApp(
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
    ));
  }
}
extension ImageAssetFinder on CommonFinders {
  Finder findImageWithAsset(String asset) {
    return find.byWidgetPredicate((widget) {
      if (widget is! Image) {
        return false;
      }

      final Image image = widget;
      if (image.image is! AssetImage) {
        return false;
      }

      final AssetImage assetImage = image.image as AssetImage;
      return assetImage.assetName == asset;
    });
  }
}
