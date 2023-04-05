import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api/dio_client.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/utils/focus.dart';

class LoginController extends GetxController{
  final signInFormKey = GlobalKey<FormState>();
  Rx<String> title = 'Sign In'.obs;
  Rx<bool> isSecurePassword= true.obs;
  Rx<bool> isCheckboxChecked= false.obs;

  final DioClient _client = DioClient();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Future<void> onInit() async {
    loadUserEmailPassword();
    super.onInit();
  }

  void rememberMe() {
    SharedPreferences.getInstance().then(
          (prefs) {
        prefs.setBool("remember_me", isCheckboxChecked.value);
        if (isCheckboxChecked.value == false) {
          prefs.setString('email', "");
          prefs.setString('password', "");
        } else {
          prefs.setString('email', emailController.text);
          prefs.setString('password', passwordController.text);
        }
      },
    );
  }

  void loadUserEmailPassword() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email") ?? "";
      var password = prefs.getString("password") ?? "";
      var rememberMe = prefs.getBool("remember_me") ?? false;
      isCheckboxChecked.value = rememberMe;
      if(emailController.text.isNotEmpty &&
          emailController.text.substring(0,1) == email.substring(0,1)){
        prefs.setString('email', "");
        prefs.setString('password', "");
        prefs.setBool("remember_me", false);
        emailController.text = email;
        passwordController.text = password;
      }
    } catch (e) { print(e); }
  }
  void signIn() async{
    AppFocus.unFocus();
    String email = emailController.text.removeAllWhitespace;
    String password = passwordController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String,dynamic> dataMap = {
      'email':email,
      'password' :password,
    };
    EasyLoading.show(status: 'loading...');
    _client.login(
        body: dataMap,
        onSuccess: (dynamic appleToken, dynamic spotifyToken) {
          print("c$appleToken");
          print("x$spotifyToken");
          EasyLoading.dismiss();
          rememberMe();
            EasyLoading.showToast('Sign In successfully.');
            Get.offAllNamed(Routes.connect);
        },
        onError: (dynamic errorCode) {
          EasyLoading.dismiss();
          EasyLoading.showToast('Sign In unsuccessfully.');
        });

  }
}