import 'package:tunedln/shared/widgets/base_text.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color_constants.dart';
import '../utils/math_utils.dart';

class CommonButton extends StatelessWidget {
  final double borderRadius;
  final double? width;
  final double height;
  final Gradient? gradient;
  final VoidCallback? onPressed;
  final String buttonText;
  final List<BoxShadow>? shadows;
  final Color? textColor;
  final Color? backgroundColor;
  final BorderSide? borderSide;

  const CommonButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.borderRadius = 29,
    this.width,
    this.height = 58.0,
    this.shadows,
    this.gradient,
    this.textColor,
    this.backgroundColor,
    this.borderSide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width,
      height: getSize(height),
      //alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: backgroundColor ?? ColorConstants.primary,
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius.all(
            SmoothRadius(
              cornerRadius: getSize(borderRadius),
              cornerSmoothing: 1,
            ),
          ),
        ),
        shadows: shadows ??
            [
              BoxShadow(
                offset: const Offset(4, 8),
                blurRadius: 24,
                color: ColorConstants.buttonShadowColor,
              ),
            ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: borderSide,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              getSize(borderRadius),
            ),
          ),
        ),
        child: BaseText(
          text: buttonText,
          textColor:  textColor ??Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class BaseButton extends StatelessWidget {
  final double borderRadius;
  final double? width;
  final double height;
  final Gradient? gradient;
  final VoidCallback? onPressed;
  final Widget childWidget;
  final List<BoxShadow>? shadows;
  final Color? backgroundColor;
  final BorderSide? borderSide;

  const BaseButton({
    Key? key,
    required this.onPressed,
    required this.childWidget,
    this.borderRadius = 29,
    this.width,
    this.height = 58.0,
    this.shadows,
    this.gradient,
    this.backgroundColor,
    this.borderSide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width,
      height: getSize(height),
      //alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: backgroundColor ?? ColorConstants.primary,
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius.all(
            SmoothRadius(
              cornerRadius: getSize(borderRadius),
              cornerSmoothing: 1,
            ),
          ),
        ),
        shadows: shadows ??
            [
              BoxShadow(
                offset: const Offset(4, 8),
                blurRadius: 24,
                color: ColorConstants.buttonShadowColor,
              ),
            ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: borderSide,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              getSize(borderRadius),
            ),
          ),
        ),
        child: childWidget,
      ),
    );
  }
}
