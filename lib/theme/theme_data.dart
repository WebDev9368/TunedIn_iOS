import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/constants/color_constants.dart';
import '../shared/utils/math_utils.dart';
import '../shared/widgets/common_input_shadow.dart';

class ThemeConfig {
  static ThemeData createTheme({required Brightness brightness}) {
    // print("primaryColor : ${Theme.of(Get.context!).primaryColor}");
    return ThemeData(
      // brightness: brightness,

      scaffoldBackgroundColor: ColorConstants.white,
      primaryColor: ColorConstants.primary,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        //  contentPadding: EdgeInsets.zero,
        border: getBorder(),
        errorBorder: getErrorBorder(),
        enabledBorder: getEnableBorder(),
        disabledBorder: getDisableBorder(),
        focusedErrorBorder: getFocusErrorBorder(),
        focusedBorder: getFocusBorder(),
      ),

      textSelectionTheme: const TextSelectionThemeData(
        selectionHandleColor: Colors.transparent,
      ),
    );
  }

  static DecoratedInputBorder getBorder() {
    return DecoratedInputBorder(
      child: OutlineInputBorder(
        borderRadius: SmoothBorderRadius.all(
          SmoothRadius(cornerRadius: getSize(14), cornerSmoothing: 1),
        ),
        borderSide: BorderSide(color: ColorConstants.grey1),
      ),
      shadow: BoxShadow(
        offset: const Offset(15, 20),
        blurRadius: 45,
        color: ColorConstants.shadowColor.withOpacity(0.25),
      ),
    );
  }

  static DecoratedInputBorder getErrorBorder() {
    return DecoratedInputBorder(
      child: OutlineInputBorder(
        borderRadius: SmoothBorderRadius.all(
          SmoothRadius(cornerRadius: getSize(14), cornerSmoothing: 1),
        ),
        borderSide: BorderSide(color: ColorConstants.redErrorColor),
      ),
      shadow: BoxShadow(
        offset: const Offset(15, 20),
        blurRadius: 45,
        color: ColorConstants.shadowColor.withOpacity(0.25),
      ),
    );
  }

  static DecoratedInputBorder getEnableBorder() {
    return DecoratedInputBorder(
      child: OutlineInputBorder(
        borderRadius: SmoothBorderRadius.all(
          SmoothRadius(cornerRadius: getSize(14), cornerSmoothing: 1),
        ),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      shadow: BoxShadow(
        offset: const Offset(15, 20),
        blurRadius: 45,
        color: ColorConstants.shadowColor.withOpacity(0.25),
      ),
    );
  }

  static DecoratedInputBorder getDisableBorder() {
    return DecoratedInputBorder(
      child: OutlineInputBorder(
        borderRadius: SmoothBorderRadius.all(
          SmoothRadius(cornerRadius: getSize(14), cornerSmoothing: 1),
        ),
        borderSide: BorderSide(color: ColorConstants.grey1),
      ),
      shadow: BoxShadow(
        offset: Offset(15, 20),
        blurRadius: 45,
        color: ColorConstants.shadowColor.withOpacity(0.25),
      ),
    );
  }

  static DecoratedInputBorder getFocusErrorBorder() {
    return DecoratedInputBorder(
      child: OutlineInputBorder(
        borderRadius: SmoothBorderRadius.all(
          SmoothRadius(cornerRadius: getSize(12), cornerSmoothing: 1),
        ),
        borderSide: BorderSide(color: ColorConstants.redErrorColor),
      ),
      shadow: BoxShadow(
        offset: const Offset(15, 20),
        blurRadius: 45,
        color: ColorConstants.shadowColor.withOpacity(0.25),
      ),
    );
  }

  static DecoratedInputBorder getFocusBorder() {
    return DecoratedInputBorder(
      child: OutlineInputBorder(
        borderRadius: SmoothBorderRadius.all(
          SmoothRadius(cornerRadius: getSize(14), cornerSmoothing: 1),
        ),
        borderSide: BorderSide(color: ColorConstants.primary),
      ),
      shadow: BoxShadow(
        offset: Offset(15, 20),
        blurRadius: 45,
        color: ColorConstants.shadowColor.withOpacity(0.25),
      ),
    );
  }

  static ThemeData get lightTheme => createTheme(brightness: Brightness.light);

  static ThemeData get darkTheme => createTheme(brightness: Brightness.dark);
}
