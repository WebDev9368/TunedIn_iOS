import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../utils/math_utils.dart';
import 'base_text.dart';

class CommonOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final String text;
  final FontWeight? fontWeight;
  final double borderRadius;
  final Color? borderColor;
  final double? fontSize;
  final Color? textColor;
  const CommonOutlineButton({
    Key? key,
    required this.onPressed,
    this.width,
    this.height,
    required this.text,
    this.fontWeight,
    this.fontSize = 16,
    this.textColor,
    this.borderRadius = 16,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        fixedSize: Size.fromHeight(height ?? getSize(50)),
        //padding: EdgeInsets.zero,
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
        side: BorderSide(
          color: borderColor ?? ColorConstants.primary,
        ),
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius.all(
            SmoothRadius(
              cornerRadius: getSize(borderRadius),
              cornerSmoothing: 1,
            ),
          ),
        ),
      ),
      child: FittedBox(
        child: BaseText(
          text: text,
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: fontSize ?? 16,
          textColor: textColor ?? ColorConstants.primary,
        ),
      ),
    );
  }
}
