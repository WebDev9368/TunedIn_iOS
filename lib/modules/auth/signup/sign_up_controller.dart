
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tunedln/routes/app_pages.dart';
import 'package:tunedln/shared/dialog/error_toast.dart';
import '../../../api/dio_client.dart';
import '../../../shared/utils/focus.dart';

class SignUpController extends GetxController{
  final basicDetailFormKey = GlobalKey<FormState>();
  final profileDetailFormKey = GlobalKey<FormState>();
  final DioClient _client = DioClient();
  String? url;
  XFile? images;
  XFile? image;
  Rx<bool> load = true.obs;
  Rx<bool> imagesNew = false.obs;
  Rx<bool> isSecurePassword = true.obs;
  Rx<bool> isSecureConfirmPassword = true.obs;
  Rx<bool> isCheckboxChecked= false.obs;

  RxInt currentView = 0.obs;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController aboutYouController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void signUp() async{
    AppFocus.unFocus();

    Map<String,dynamic> dataMap = {
      'firstName':firstNameController.text,
      'lastName':lastNameController.text,
      'aboutYou':aboutYouController.text,
      'email':emailController.text.removeAllWhitespace,
      'password':passwordController.text,
      'photo': url
    };

    printInfo(info: 'signUp Data ===> $dataMap');

    EasyLoading.show(status: 'loading...');
    _client.registration(
      email: emailController.text,
        body: dataMap,
        onSuccess: (dynamic code, dynamic c) {
          EasyLoading.dismiss();
          EasyLoading.showToast('Sign Up successfully.');
          Get.offAllNamed(Routes.connect);
        },
        onError: (dynamic errorCode) {
          EasyLoading.dismiss();
          if(errorCode!= null) {
            Get.offAllNamed(Routes.login);
            ErrorToast().show(title: errorCode.toString());
          }else {
            EasyLoading.showToast('Sign Up unsuccessful.');
          }
        });
  }

  imgFromGallery() async {
    images = await ImagePicker().pickImage(source: ImageSource.gallery);
    EasyLoading.show(status: 'loading...');
    imagesNew.value = true;
    Map<String,dynamic> dataMap = {
      'type':'image',
    'files': images
    };
    _client.uploadImage(
        body: dataMap,
        onSuccess: (dynamic url) {
          EasyLoading.dismiss();
          this.url = url;
        },
        onError: (dynamic errorCode) {
          EasyLoading.dismiss();
          if(errorCode!= null) {
            ErrorToast().show(title: errorCode.toString());
        }});
  }

  imgFromCamera() async {
    images =  await ImagePicker().pickImage(source: ImageSource.camera);

    EasyLoading.show(status: 'loading...');
    imagesNew.value = true;
    Map<String,dynamic> dataMap = {
      'type':'image',
      'files': images
    };
    _client.uploadImage(
        body: dataMap,
        onSuccess: (dynamic url) {
          EasyLoading.dismiss();
          this.url = url;
        },
        onError: (dynamic errorCode) {
          EasyLoading.dismiss();
          if(errorCode!= null) {
            ErrorToast().show(title: errorCode.toString());
          }});
  }
}