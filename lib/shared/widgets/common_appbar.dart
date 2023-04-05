import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/shared/utils/image_utils.dart';
import '../constants/color_constants.dart';
import '../utils/focus.dart';
import '../utils/math_utils.dart';
import 'base_text.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.white;
  final Color? leadingBackgroundColor;
  final Widget? leading;
  final String title;
  final bool showAppBarShadow;
  final List<Widget>? actions;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Function()? onPressedBack;
  final double appBarHeight;

  /// you can add more fields that meet your needs

  const BaseAppBar({
    Key? key,
    required this.title,
    this.leadingBackgroundColor,
    this.leading,
    this.actions,
    this.systemOverlayStyle,
    this.onPressedBack,
    this.showAppBarShadow = false,
    this.appBarHeight = 60.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: showAppBarShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 0.0),
                  blurRadius: 2.0,
                ),
              ]
            : [],
      ),
      child: AppBar(
        leading: leading ?? _buildLeadingView(),
        automaticallyImplyLeading: false,
       // leadingWidth: getSize(80),
        systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle.dark,
        title: BaseText(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          maxLines: 1,
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: actions,
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  Widget _buildLeadingView() {
    return IconButton(
      onPressed: onPressedBack ??
          () {
            Get.back();
            AppFocus.unFocus();
          },
      icon: Container(
        height: getSize(45),
        width: getSize(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: leadingBackgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(getSize(12))
            // shape: SmoothRectangleBorder(
            //   borderRadius: SmoothBorderRadius.all(
            //     SmoothRadius(
            //       cornerRadius: getSize(12),
            //       cornerSmoothing: 1,
            //     ),
            //   ),
            // ),
            ),
        child: SvgPicture.asset(getAssetsSVGImg('ic_arrow_back')),
      ),
    );
  }
}

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.transparent;
  final Color? leadingBackgroundColor;
  final Widget? leading;
  final Widget title;
  final List<Widget>? actions;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Function()? onPressedBack;

  /// you can add more fields that meet your needs

  const CommonAppBar({
    Key? key,
    required this.title,
    this.leadingBackgroundColor,
    this.leading,
    this.actions,
    this.systemOverlayStyle,
    this.onPressedBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ?? _buildLeadingView(),
      automaticallyImplyLeading: false,
      leadingWidth: getSize(80),
      systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle.dark,
      title: title,
      backgroundColor: backgroundColor,
      elevation: 0,
      actions: actions,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);

  Widget _buildLeadingView() {
    return IconButton(
      onPressed: onPressedBack ??
          () {
            Get.back();
            AppFocus.unFocus();
          },
      icon: Container(
        height: getSize(45),
        width: getSize(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: leadingBackgroundColor ?? ColorConstants.white,
            borderRadius: BorderRadius.circular(getSize(12))
            // shape: SmoothRectangleBorder(
            //   borderRadius: SmoothBorderRadius.all(
            //     SmoothRadius(
            //       cornerRadius: getSize(12),
            //       cornerSmoothing: 1,
            //     ),
            //   ),
            // ),
            ),
        child: SvgPicture.asset(
          getAssetsSVGImg('arrow_left'),
        ),
      ),
    );
  }
}
