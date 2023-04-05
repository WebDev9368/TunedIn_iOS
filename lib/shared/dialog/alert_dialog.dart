import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/string_constant.dart';
import '../utils/focus.dart';
import '../widgets/base_text.dart';

class CustomAlertDialog {
  show({
    required VoidCallback confirmCallback,
    required BuildContext context,
    required String title,
    required String content,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: CupertinoAlertDialog(
              title: BaseText(
                text: title,
                fontWeight: FontWeight.w600,
                fontSize: 17,
                textAlign: TextAlign.center,
              ),
              content: BaseText(
                text: content,
                fontSize: 13,
                textAlign: TextAlign.center,
              ),
              actions: [
                CupertinoDialogAction(
                  onPressed: confirmCallback,
                  child: const BaseText(
                    text: StringConstant.confirm,
                    textColor: Colors.blueAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Get.back();
                    AppFocus.unFocus();
                  },
                  child: const BaseText(
                    text: StringConstant.cancel,
                    textColor: Colors.blueAccent,
                  ),
                ),
                Container(),
              ],
            ),
          );
        });
  }
}
