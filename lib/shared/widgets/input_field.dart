import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:tunedln/shared/shared.dart';
import '../utils/math_utils.dart';

class InputTextField extends StatelessWidget {
  final bool? enable;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final Color? textColor;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final int? errorMaxLines;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final EdgeInsets? contentPadding;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final String? errorText;
  final bool isSecure;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final Color? fillColor;

  const InputTextField({
    Key? key,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.validator,
    this.textColor,
    required this.controller,
    this.textInputType,
    this.errorMaxLines,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.contentPadding,
    this.onTap,
    this.textInputAction,
    this.errorText,
    this.isSecure = false,
    this.enable = true,
    this.onChanged,
    this.inputFormatters,
    this.prefixText,
    this.focusNode,
    this.onFieldSubmitted,
    this.textCapitalization,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(Get.context!).copyWith(
        textScaleFactor: 1.0,
      ),
      child: TextFormField(
        inputFormatters: inputFormatters,
        enabled: enable,
        initialValue: initialValue,
        controller: controller,
        onTap: onTap,
        cursorColor: ColorConstants.primary,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: textInputType ?? TextInputType.text,
        maxLines: maxLines,
        maxLength: maxLength,
        focusNode: focusNode,
        minLines: minLines,
        obscureText: isSecure,
        obscuringCharacter: '●',
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: textInputAction ?? TextInputAction.next,
        onChanged: onChanged,
        style: TextStyle(
          debugLabel: labelText,
          fontFamily: StringConstant.fontFamily,
          letterSpacing: 0.5,
          color: ColorConstants.textColorPrimary,
          fontSize: getFontSize(14),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          isDense: true,
          filled: true,
          labelText: labelText,
          errorText: errorText,
          focusColor: ColorConstants.white,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                vertical: getSize(18),
                horizontal: getSize(12),
              ),
          hintText: hintText,
          fillColor: fillColor ?? ColorConstants.buttonShadowColor,
          errorMaxLines: errorMaxLines ?? 2,
          errorStyle: TextStyle(
            fontSize: getFontSize(14),
            fontWeight: FontWeight.normal,
            fontFamily: StringConstant.fontFamily,
            letterSpacing: 0.5,
            color: ColorConstants.redErrorColor,
          ),
          labelStyle: TextStyle(
            fontSize: getFontSize(14),
            fontWeight: FontWeight.normal,
            fontFamily: StringConstant.fontFamily,
            letterSpacing: 0.5,
            color: textColor ?? ColorConstants.black,
          ),
          hintStyle: TextStyle(
            fontSize: getFontSize(14),
            fontFamily: StringConstant.fontFamily,
            letterSpacing: 0.5,
            color: ColorConstants.grey,
            fontWeight: FontWeight.w300
          ),
          suffixIcon: suffixIcon,
          suffixIconConstraints: suffixIconConstraints ??
              BoxConstraints(
                maxHeight: getSize(50),
                minWidth: getSize(80),
              ),
          prefixIcon: prefixIcon,
          prefixIconConstraints: BoxConstraints(
            maxHeight: getSize(50),
            maxWidth: getSize(100),
          ),
        ),
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
      ),
    );
  }

}
