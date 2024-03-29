import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences _prefs;

abstract class FlutterAppTheme {
  static Future initialize() async => _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
      ? ThemeMode.system
      : darkMode
          ? ThemeMode.dark
          : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) {
    print(ThemeMode.system);
    mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);
  }

  static FlutterAppTheme of(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
      ? DarkModeTheme()
      : LightModeTheme();

  Color primaryColor;
  Color secondaryColor;
  Color tertiaryColor;
  Color alternate;
  Color primaryBackground;
  Color secondaryBackground;
  Color primaryText;
  Color tabBarText;
  Color secondaryText;
  Color ButtonPrimaryColor;
  Color AppBarPrimaryColor;
  Color BottomNavigationBarColor;
  Color whiteColor;
  Color blackColor;
  Color lightGrey;
  Color Grey;
  Color lightRed;
  Color lightBlue;
  Color Orange;
  Color LightOrange;
  Color Green;
  Color lightCreen;
  Color BackgroundContainer;
  Color TransparentColor;
  Color primaryBtnText;
  Color lineColor;
  Color TextColor;
  Color LightDarkTextColor;
  Color MenuItemColorDrawer;

  TextStyle get title1 => GoogleFonts.getFont(
        'Poppins',
        color: primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24,
  );
  TextStyle get title2 => GoogleFonts.getFont(
        'Poppins',
        color: secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 22,
  );
  TextStyle get title3 => GoogleFonts.getFont(
        'Poppins',
        color: primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20,
  );
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Poppins',
        color: primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 18,
  );
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Poppins',
        color: secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16,
  );
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Poppins',
        color: primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 14,
  );
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Poppins',
        color: secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 14,
  );
}

class LightModeTheme extends FlutterAppTheme {
  Color primaryColor = const Color(0xFF9457FB);
  Color secondaryColor = const Color(0x369457FB);
  Color tertiaryColor = const Color(0xFF009FFF);
  Color TextColor = const Color(0xFF101213);
  Color LightDarkTextColor = Colors.black54;
  Color MenuItemColorDrawer = Color(0xFF616A6B);
  Color tabBarText = Color(0x988B97A2);
  // colors
  Color whiteColor = const Color(0xFFFFFFFF);
  Color blackColor = Colors.black;
  Color Grey = const Color(0xff95A1AC);
  Color lightGrey = Colors.grey[100];
  Color alternate = const Color(0xFFFF5963);
  Color lightRed = Colors.red[50];
  Color LightBlue = Colors.blue[50];
  Color Orange = const Color.fromARGB(255, 214, 116, 36);
  Color LightOrange = Color.fromARGB(214, 241, 228, 200);
  Color Green = Colors.green;
  Color LightGreen = Colors.green[50];

  // appbar and buttomNav
  Color AppBarPrimaryColor = const Color(0xFF101213);
  Color BottomNavigationBarColor = const Color(0xFF101213);
  Color primaryBackground = const Color(0xFFF1F4F8);
  Color secondaryBackground = const Color(0xFFFFFFFF);
  Color primaryText = const Color(0xFF101213);
  Color secondaryText = const Color(0xFF57636C);
  Color ButtonPrimaryColor = const Color(0xFF101213);
  Color primaryBtnText = Color(0xFFFFFFFF);
  Color lineColor = Color(0xFFE0E3E7);
  Color BackgroundContainer = const Color(0xFFF3F8FF);
  Color TransparentColor = Colors.transparent;
}

class DarkModeTheme extends FlutterAppTheme {
  Color LightDarkTextColor = Colors.white;
  Color primaryColor = const Color(0xFF9457FB);
  Color secondaryColor = const Color(0xFF39D2C0);
  Color tertiaryColor = const Color(0xFFEE8B60);
  Color alternate = const Color(0xFFFF5963);
  Color primaryBackground = const Color(0xFF1A1F24);
  Color secondaryBackground = const Color(0xFF101213);
  Color primaryText = const Color(0xFFFFFFFF);
  Color tabBarText = const Color(0xFFFFFFFF);
  Color secondaryText = const Color(0xFFFFFFFF);
  Color ButtonPrimaryColor = const Color(0xFFFFFFFF);
  Color primaryBtnText = Color(0xFFFFFFFF);
  Color lineColor = Color(0xFFFFFFFF);
  Color MenuItemColorDrawer = Colors.white;
  Color TransparentColor = Color.fromARGB(0, 250, 152, 152);
  Color lightGrey = Colors.grey[100];
  Color lightRed = Colors.red[50];
  Color LightBlue = Colors.blue[50];
  Color Orange = const Color.fromARGB(255, 214, 116, 36);
  Color LightOrange = Color.fromARGB(214, 241, 228, 200);
  Color Green = Colors.green;
  Color LightGreen = Colors.green[50];
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String fontFamily,
    Color color,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    bool useGoogleFonts = true,
    TextDecoration decoration,
    double lineHeight,
  }) => useGoogleFonts ? 
    GoogleFonts.getFont(
      fontFamily,
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      decoration: decoration,
      height: lineHeight,
    )
  : copyWith(
      fontFamily: fontFamily,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      height: lineHeight,
    );
}
