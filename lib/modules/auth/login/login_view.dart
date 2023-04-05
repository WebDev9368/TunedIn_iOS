import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/auth/login/login_controller.dart';
import 'package:tunedln/shared/shared.dart';
import 'package:tunedln/shared/widgets/base_text.dart';
import 'package:tunedln/shared/widgets/common_appbar.dart';
import 'package:tunedln/shared/widgets/common_button.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/utils/image_utils.dart';
import '../../../shared/utils/math_utils.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(title: '',showAppBarShadow: false),
      body: GestureDetector(
        onTap: () {
          AppFocus.unFocus();
        },
        child: Obx(() {
          return Form(
            key: controller.signInFormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(24)),
              child: SingleChildScrollView(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleView(),
                  SizedBox(height: getSize(50)),
                  _buildEmailTextField(),
                  SizedBox(height: getSize(32)),
                  _buildPasswordTextField(),
                  SizedBox(height: getSize(18)),
                  _buildForgotPasswordView(),
                  SizedBox(height: getSize(60)),
                  _buildSignInButton(),
                  SizedBox(height: getSize(27)),
                  _buildSignUpRow(),
                  SizedBox(height: getSize(24)),
                ],
              ),
            ),
          ));
        }),
      ),
    );
  }

  Widget _buildTitleView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getSize(12)),
        const BaseText(
          text: 'Welcome Back!',
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: getSize(8)),
        BaseText(
          text: 'Sign in to your continue account',
          fontSize: 16,
          textColor: ColorConstants.textColorSecondary,
        ),
      ],
    );
  }

  Widget _buildEmailTextField() {
    return InputTextField(
      hintText: StringConstant.hintEmail,
      onFieldSubmitted: (v) => controller.emailController.text = controller.emailController.text.toLowerCase(),
      textCapitalization: TextCapitalization.none,
      textInputType: TextInputType.emailAddress,
      prefixIcon: SizedBox(
        width: getSize(50),
        child: SvgPicture.asset(
          getAssetsSVGImg('ic_email'),
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      validator: (string) {
        if (string!.isEmpty) {
          return StringConstant.emailEmpty;
        } else if(string.length == 1) {
          controller.loadUserEmailPassword();
        } else if (!GetUtils.isEmail(string.removeAllWhitespace)) {
          return StringConstant.emailValidError;
        }
        return null;
      },
      controller: controller.emailController,
    );
  }

  Widget _buildPasswordTextField() {
    return InputTextField(
      hintText: StringConstant.hintPassword,
      textCapitalization: TextCapitalization.sentences,
      textInputType: TextInputType.name,
      prefixIcon: SizedBox(
        width: getSize(50),
        child: SvgPicture.asset(
          getAssetsSVGImg('ic_password'),
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      validator: (string) {
        if (string!.isEmpty) {
          return StringConstant.passwordEmpty;
        }
        return null;
      },
      controller: controller.passwordController,
      isSecure: controller.isSecurePassword.value,
      suffixIcon: IconButton(
        //padding: const EdgeInsets.all(0),
        onPressed: () {
          controller.isSecurePassword.toggle();
        },
        //color: ColorConstants.grey1,
        icon: SvgPicture.asset(
          getAssetsSVGImg(controller.isSecurePassword.value
              ? 'ic_password_hide'
              : 'ic_password_show'),
          height: getSize(24),
          width: getSize(24),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildRememberPasswordView(),
        InkWell(
          onTap: () {
            Get.toNamed(Routes.forgotPassword);
          },
          child: BaseText(
            text: 'Forgot password?',
            textColor: ColorConstants.textColorSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );

    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.forgotPassword);
        },
        child: BaseText(
          text: 'Forgot password?',
          textColor: ColorConstants.textColorSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return CommonButton(
      onPressed: () {
        if (controller.signInFormKey.currentState!.validate()) {
          controller.signIn();
        }
      },
      buttonText: 'Sign In',
    );
  }

  Widget _buildSignUpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BaseText(
          text: 'Don’t Have an Account? ',
          fontSize: 14,
          textColor: ColorConstants.textColorSecondary,
          fontWeight: FontWeight.w100,
        ),
        InkWell(
          onTap: () {
            Get.toNamed(Routes.signUp);
          },
          child: BaseText(
            text: 'Sign Up',
            fontWeight: FontWeight.w600,
            textColor: ColorConstants.primary,
            fontSize: 14,
          ),
        )
      ],
    );
  }

  Widget _buildRememberPasswordView() {
    return Row(
      children: [
        _buildCheckBox(),
        SizedBox(width: getSize(16)),
        BaseText(
          text: 'Remember Me',
          fontSize: 14,
          textColor: ColorConstants.textColorSecondary,
        ),
      ],
    );
  }

  Widget _buildCheckBox() {
    return
      InkWell(
      onTap: () {
        controller.isCheckboxChecked.toggle();
      },
      child: controller.isCheckboxChecked.value
          ? Stack(
              children: [
                SvgPicture.asset(
                  getAssetsSVGImg('ic_uncheck'),
                  // color: ColorConstants.primary,
                  height: getSize(24),
                  width: getSize(24),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.all(getSize(5.0)),
                    child: SvgPicture.asset(
                      getAssetsSVGImg('tick'),
                      color: ColorConstants.primary,
                    ),
                  ),
                ),
              ],
            )
          : SvgPicture.asset(
              getAssetsSVGImg('ic_uncheck'),
              height: getSize(24),
              width: getSize(24),
            ),
    );
  }
}
