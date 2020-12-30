
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:salonic/Custom_Widgets/Localization/app_localization.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/View/Splash_Screen/splash_screen.dart';

void main() {
  runApp(
    new MyApp(),

  );
}

class MyApp extends StatefulWidget{

  static void setLocale (BuildContext context,Locale locale){
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }

}
class _MyAppState extends State<MyApp>{

  Locale _locale;
  void setLocale(Locale locale){
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: SplashScreen(),
      supportedLocales: [
        Locale('ar','EG'),
        Locale('en','US'),
      ],
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: _locale, // use to change language programtically through app
      localeResolutionCallback: (locale,supportedLocales){
        for( var supportedLocale in supportedLocales){
          if(supportedLocale.languageCode==locale.languageCode && supportedLocale.countryCode == locale.countryCode){
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
    );
  }

}