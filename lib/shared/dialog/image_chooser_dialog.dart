import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../constants/string_constant.dart';
import '../utils/focus.dart';
import '../widgets/base_text.dart';

class ImageChooserDialog {
  showImageChooserDialog({
    required VoidCallback takePhotoCallback,
    required VoidCallback selectPhotoCallback,
  }) {
    return showCupertinoModalPopup<void>(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoActionSheet(
        // title: const BaseText(
        //   text: StringConstant.selectImage,
        //   textAlign: TextAlign.center,
        // ),
        // message: const Text('Message'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: takePhotoCallback,
            child: const BaseText(
              text: StringConstant.takePhoto,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: selectPhotoCallback,
            child: const BaseText(
              text: StringConstant.galleryPhoto,
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const BaseText(
            text: StringConstant.buttonCancel,
            fontSize: 18,
          ),
          onPressed: () {
            Get.back();
            AppFocus.unFocus();
          },
        ),
      ),
    );
  }
}
