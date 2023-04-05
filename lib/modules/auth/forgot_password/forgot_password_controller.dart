import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../api/dio_client.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/utils/focus.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rx<String> title = 'Forgot password'.obs;
  final DioClient _client = DioClient();
  final TextEditingController emailController = TextEditingController();

  void resetPassword() async {
    AppFocus.unFocus();
    emailController.text = emailController.text.toLowerCase();
    String email = emailController.text;

    Map<String, dynamic> dataMap = {
      'action':'reset_password',
      'email': email
    };

    print(dataMap);
    _client.resetPassword(
        body: dataMap,
        onSuccess: (dynamic code) {
          EasyLoading.dismiss();
          EasyLoading.showToast('Reset password link sent to your mail.');
          Get.back();
        },
        onError: (dynamic errorCode) {
          EasyLoading.dismiss();
          Fluttertoast.showToast(
              msg: errorCode.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          //Get.back();
        });
  }
}
