import 'package:core/src/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: LightThemeColor.primaryColor,
  primaryColorLight: LightThemeColor.primaryColorLight,
  primaryColorDark: LightThemeColor.primaryColor,
  canvasColor: LightThemeColor.backgroundColor,
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: LightThemeColor.primaryTextColor,
    displayColor: LightThemeColor.primaryTextColor,
  ),
  scaffoldBackgroundColor: Colors.white,
  cardColor: LightThemeColor.cardColor,
  dividerColor: LightThemeColor.disableColor,
  highlightColor: LightThemeColor.highlightColor,
  splashColor: LightThemeColor.splashColor,
  appBarTheme: AppBarTheme(
    backgroundColor: LightThemeColor.primaryColorLight.withValues(alpha: 0.2),
    foregroundColor: LightThemeColor.cardColor,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: LightThemeColor.secondaryTextColor,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ),
    elevation: 0,
    centerTitle: false,
    titleSpacing: 0.w,
    toolbarHeight: 64.h,
  ),
  disabledColor: LightThemeColor.secondaryColor,
  indicatorColor: LightThemeColor.primaryColor,
  hintColor: LightThemeColor.textColor.withValues(alpha: 0.5),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: LightThemeColor.primaryColor,
    foregroundColor: LightThemeColor.cardColor,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: LightThemeColor.primaryColor,
    selectionColor: LightThemeColor.primaryColor.withValues(alpha: 0.5),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: LightThemeColor.textColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: LightThemeColor.textColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: LightThemeColor.secondaryColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: LightThemeColor.errorColor,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: 2,
    isDense: false,
    contentPadding:
        EdgeInsets.only(top: 12.h, bottom: 12.h, left: 16.w, right: 16.w),
    isCollapsed: false,
    prefixStyle: TextStyle(
      color: LightThemeColor.decorationColor,
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: LightThemeColor.decorationColor,
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixIconColor: LightThemeColor.hintColor.withValues(alpha: 0.4),
    counterStyle: TextStyle(
      color: LightThemeColor.decorationColor,
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: false,
    fillColor: LightThemeColor.cardColor,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: LightThemeColor.errorColor,
        width: 1.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: LightThemeColor.primaryColor,
        width: 1.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: LightThemeColor.errorColor,
        width: 1.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: LightThemeColor.decorationColor,
        width: 1.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: LightThemeColor.decorationColor,
        width: 1.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: LightThemeColor.decorationColor,
        width: 1.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    ),
  ),
  iconTheme: const IconThemeData(
    color: LightThemeColor.textColor,
    opacity: 1,
    size: 24,
  ),
  primaryIconTheme: const IconThemeData(
    color: LightThemeColor.backgroundColor,
    opacity: 1,
    size: 24,
  ),
  tabBarTheme: TabBarThemeData(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: LightThemeColor.cardColor,
    unselectedLabelColor: LightThemeColor.secondaryColor.withValues(alpha: 0.5),
    dividerHeight: 0,
    overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
    splashFactory: NoSplash.splashFactory,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(11.r),
      color: LightThemeColor.primaryColor,
    ),
    labelStyle: GoogleFonts.poppins(
      fontSize: 14.sp,
      color: LightThemeColor.cardColor,
      fontWeight: FontWeight.w500,
      backgroundColor: Colors.transparent,
    ),
    unselectedLabelStyle: GoogleFonts.poppins(
      fontSize: 14.sp,
      color: LightThemeColor.secondaryColor.withValues(alpha: 0.5),
      fontWeight: FontWeight.w500,
      backgroundColor: Colors.transparent,
    ),
  ),
  dialogTheme: const DialogThemeData(
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: LightThemeColor.secondaryColor,
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
        return LightThemeColor.primaryColor;
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
        return LightThemeColor.primaryColor;
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
        return LightThemeColor.primaryColor;
      }
      return null;
    }),
    trackColor:
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return LightThemeColor.primaryColor;
      }
      return null;
    }),
  ),
  bottomAppBarTheme:
      const BottomAppBarThemeData(color: LightThemeColor.backgroundColor),
  colorScheme: ColorScheme.fromSeed(
    seedColor: LightThemeColor.primaryColor,
    brightness: Brightness.light,
  ).copyWith(
    error: LightThemeColor.errorColor,
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    menuStyle: const MenuStyle(
      backgroundColor: WidgetStatePropertyAll(LightThemeColor.cardColor),
    ),
    textStyle: GoogleFonts.poppins(
      fontSize: 14.sp,
      color: LightThemeColor.secondaryColor,
      fontWeight: FontWeight.w400,
      backgroundColor: Colors.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: LightThemeColor.textColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ),
      helperStyle: TextStyle(
        color: LightThemeColor.textColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ),
      hintStyle: TextStyle(
        color: LightThemeColor.secondaryColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      errorStyle: TextStyle(
        color: LightThemeColor.errorColor,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ),
      errorMaxLines: 2,
      isDense: false,
      contentPadding:
          EdgeInsets.only(top: 12.h, bottom: 12.h, left: 16.w, right: 16.w),
      isCollapsed: false,
      prefixStyle: TextStyle(
        color: LightThemeColor.decorationColor,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      suffixStyle: TextStyle(
        color: LightThemeColor.decorationColor,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      suffixIconColor: LightThemeColor.secondaryColor,
      counterStyle: TextStyle(
        color: LightThemeColor.decorationColor,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      filled: false,
      fillColor: LightThemeColor.cardColor,
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: LightThemeColor.errorColor,
          width: 1.w,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: LightThemeColor.decorationColor,
          width: 1.w,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: LightThemeColor.errorColor,
          width: 1.w,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: LightThemeColor.decorationColor,
          width: 1.w,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: LightThemeColor.decorationColor,
          width: 1.w,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: LightThemeColor.decorationColor,
          width: 1.w,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
      ),
      outlineBorder: BorderSide(
        color: LightThemeColor.decorationColor,
        width: 1.w,
        style: BorderStyle.solid,
      ),
      activeIndicatorBorder: BorderSide(
        color: LightThemeColor.decorationColor,
        width: 1.w,
        style: BorderStyle.solid,
      ),
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.r),
        topRight: Radius.zero,
        bottomLeft: Radius.circular(10.r),
        bottomRight: Radius.circular(10.r),
      ),
    ),
    color: LightThemeColor.cardColor,
    position: PopupMenuPosition.under,
    surfaceTintColor: LightThemeColor.cardColor,
    shadowColor: Colors.black.withValues(alpha: 0.25),
    labelTextStyle: WidgetStatePropertyAll(
      GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: LightThemeColor.primaryTextColor,
      ),
    ),
    textStyle: GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: LightThemeColor.primaryTextColor,
    ),
  ),
  menuTheme: MenuThemeData(
    style: MenuStyle(
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: 11.h,
          horizontal: 18.w,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.zero,
            bottomLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
          ),
        ),
      ),
      backgroundColor:
          const WidgetStatePropertyAll(LightThemeColor.cardColor),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: LightThemeColor.cardColor,
    elevation: 16,
    unselectedLabelStyle: GoogleFonts.poppins(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      color: LightThemeColor.secondaryColor,
    ),
    selectedLabelStyle: GoogleFonts.poppins(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      color: LightThemeColor.primaryColor,
    ),
    type: BottomNavigationBarType.fixed,
  ),
);
