import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teknoloji_kimya_servis/utils/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    SharedPreferences.getInstance().then(
      (_sharedPreferences) {
        final bool _isDark =
            _sharedPreferences.getBool(SharedPreferencesConsts.isThemeDark);
        if (_isDark != null) {
          if (_isDark) {
            theme = MyThemes.myDarkTheme;
          } else {
            theme = MyThemes.myLightTheme;
          }
        }
      },
    );
  }
  ThemeData _theme = MyThemes.myLightTheme;
  ThemeData get theme => _theme;
  set theme(ThemeData theme) {
    _theme = theme;
    notifyListeners();
  }
}

class MyThemes {
  static final myLightTheme = ThemeData(
    primaryColor: Colors.blue.shade700,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.blue.shade700),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: "Montserrat",
  );

  // static final myDarkTheme = ThemeData(
  //   scaffoldBackgroundColor: Colors.black,
  //   appBarTheme: AppBarTheme(
  //     color: Colors.black,
  //     iconTheme: IconThemeData(
  //       color: Colors.white,
  //     ),
  //   ),
  //   colorScheme: ColorScheme.light(
  //     primary: Colors.black,
  //     onPrimary: Colors.black,
  //     primaryVariant: Colors.black,
  //     secondary: Colors.red,
  //   ),
  //   cardTheme: CardTheme(
  //     color: Colors.black,
  //   ),
  //   iconTheme: IconThemeData(
  //     color: Colors.white54,
  //   ),
  //   textTheme: TextTheme(
  //     headline6: TextStyle(
  //       color: Colors.white,
  //       fontSize: 20.0,
  //     ),
  //     headline5: TextStyle(
  //       color: Colors.white,
  //       fontSize: 20.0,
  //     ),
  //     headline4: TextStyle(
  //       color: Colors.white,
  //       fontSize: 20.0,
  //     ),
  //     headline3: TextStyle(
  //       color: Colors.white,
  //       fontSize: 20.0,
  //     ),
  //     headline2: TextStyle(
  //       color: Colors.white,
  //       fontSize: 20.0,
  //     ),
  //     subtitle1: TextStyle(
  //       color: Colors.white70,
  //       fontSize: 18.0,
  //     ),
  //     subtitle2: TextStyle(
  //       color: Colors.white70,
  //       fontSize: 18.0,
  //     ),
  //   ),
  //   fontFamily: "Montserrat",
  // );
  static final myDarkTheme = ThemeData.dark().copyWith(
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Montserrat',
          displayColor: Colors.white,
          bodyColor: Colors.white,
          decorationColor: Colors.white,
        ),
  );
}
