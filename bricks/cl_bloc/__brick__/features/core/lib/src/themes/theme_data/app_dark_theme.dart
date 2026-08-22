import 'package:core/src/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: DarkThemeColor.primaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: DarkThemeColor.primaryColorDark,
    foregroundColor: DarkThemeColor.textColor,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      color: DarkThemeColor.textColor,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
    elevation: 0,
    centerTitle: false,
    iconTheme: const IconThemeData(
      color: DarkThemeColor.textColor,
    ),
    actionsIconTheme: const IconThemeData(
      color: DarkThemeColor.textColor,
    ),
  ),
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: DarkThemeColor.textColor,
    displayColor: DarkThemeColor.textColor,
  ),
  primaryColorLight: DarkThemeColor.primaryColorLight,
  primaryColorDark: DarkThemeColor.primaryColorDark,
  canvasColor: DarkThemeColor.backgroundColor,
  scaffoldBackgroundColor: DarkThemeColor.backgroundColor,
  cardColor: DarkThemeColor.cardColor,
  dividerColor: DarkThemeColor.disableColor,
  highlightColor: DarkThemeColor.highlightColor,
  splashColor: DarkThemeColor.splashColor,
  disabledColor: DarkThemeColor.disableColor,
  indicatorColor: DarkThemeColor.primaryColor,
  hintColor: DarkThemeColor.textColor.withValues(alpha: 0.5),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: DarkThemeColor.primaryColorDark,
    foregroundColor: DarkThemeColor.textColor,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: DarkThemeColor.primaryColorDark,
    selectionColor: DarkThemeColor.primaryColorDark.withValues(alpha: 0.5),
  ),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    minWidth: 88,
    height: 36,
    padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
    alignedDropdown: false,
    buttonColor: DarkThemeColor.appColor,
    disabledColor: DarkThemeColor.disableColor,
    highlightColor: DarkThemeColor.highlightColor,
    splashColor: DarkThemeColor.splashColor,
    focusColor: DarkThemeColor.focusColor,
    hoverColor: DarkThemeColor.hoverColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: DarkThemeColor.textColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: DarkThemeColor.textColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: DarkThemeColor.textColor.withValues(alpha: 0.5),
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: DarkThemeColor.errorColor,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: 2,
    isDense: false,
    contentPadding:
        EdgeInsets.only(top: 12.h, bottom: 12.h, left: 16.w, right: 16.w),
    isCollapsed: false,
    filled: true,
    fillColor: DarkThemeColor.cardColor,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: DarkThemeColor.errorColor,
        width: 1.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: DarkThemeColor.primaryColor,
        width: 1.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: DarkThemeColor.errorColor,
        width: 1.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: DarkThemeColor.disableColor,
        width: 1.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: DarkThemeColor.borderColor,
        width: 1.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: DarkThemeColor.borderColor,
        width: 1.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    ),
  ),
  iconTheme: const IconThemeData(
    color: DarkThemeColor.textColor,
    opacity: 1,
    size: 24,
  ),
  primaryIconTheme: const IconThemeData(
    color: DarkThemeColor.textColor,
    opacity: 1,
    size: 24,
  ),
  // ── Tab bar — fixed: now uses DarkThemeColor throughout ──────────────────
  tabBarTheme: TabBarThemeData(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: DarkThemeColor.textColor,
    unselectedLabelColor: DarkThemeColor.secondaryColor.withValues(alpha: 0.5),
    dividerHeight: 0,
    overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
    splashFactory: NoSplash.splashFactory,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(11.r),
      color: DarkThemeColor.primaryColor,
    ),
    labelStyle: GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
  ),
  dialogTheme: const DialogThemeData(
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: DarkThemeColor.secondaryColor,
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor:
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return DarkThemeColor.appColor;
      }
      return null;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor:
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return DarkThemeColor.appColor;
      }
      return null;
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor:
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return DarkThemeColor.appColor;
      }
      return null;
    }),
    trackColor:
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return DarkThemeColor.appColor;
      }
      return null;
    }),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: DarkThemeColor.primaryColor,
    brightness: Brightness.dark,
  ).copyWith(error: DarkThemeColor.errorColor),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: DarkThemeColor.cardColor,
    elevation: 16,
    unselectedLabelStyle: GoogleFonts.poppins(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      color: DarkThemeColor.secondaryColor,
    ),
    selectedLabelStyle: GoogleFonts.poppins(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      color: DarkThemeColor.primaryColor,
    ),
    type: BottomNavigationBarType.fixed,
  ),
);
