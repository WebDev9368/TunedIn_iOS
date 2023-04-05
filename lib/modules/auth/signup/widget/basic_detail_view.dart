import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/auth/signup/sign_up_controller.dart';
import '../../../../shared/constants/color_constants.dart';
import '../../../../shared/constants/string_constant.dart';
import '../../../../shared/utils/focus.dart';
import '../../../../shared/utils/image_utils.dart';
import '../../../../shared/utils/math_utils.dart';
import '../../../../shared/widgets/base_text.dart';
import '../../../../shared/widgets/common_button.dart';
import '../../../../shared/widgets/input_field.dart';

class BasicDetailView extends GetView<SignUpController> {
  const BasicDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFocus.unFocus();
      },
      child: Obx(() {
        return Form(
          key: controller.basicDetailFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(24)),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleView(),
                SizedBox(height: getSize(32)),
                _buildEmailTextField(),
                SizedBox(height: getSize(23)),
                _buildPasswordTextField(),
                SizedBox(height: getSize(23)),
                _buildConfirmPasswordTextField(),
                SizedBox(height: getSize(23)),
                _buildTermsAndConditionView(),
                SizedBox(height: getSize(50)),
                _buildContinueButton(),
                SizedBox(height: getSize(24)),
                _buildSignInRow(),
                SizedBox(height: getSize(24)),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTitleView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BaseText(
          text: 'Create your account',
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: getSize(10)),
        BaseText(
          text: 'Enter all the mentioned details to Sign Up',
          textColor: ColorConstants.textColorSecondary,
          //fontWeight: FontWeight.w400,
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
      hintText: StringConstant.hintCreatePassword,
      textCapitalization: TextCapitalization.sentences,
      textInputType: TextInputType.visiblePassword,
      prefixIcon: SizedBox(
        width: getSize(50),
        child: SvgPicture.asset(
          getAssetsSVGImg('ic_password'),
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      validator: (string) {
        if (string!.isEmpty || string.length < 6) {
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

  Widget _buildConfirmPasswordTextField() {
    return InputTextField(
      hintText: StringConstant.hintConfirmPassword,
      textCapitalization: TextCapitalization.sentences,
      prefixIcon: SizedBox(
        width: getSize(50),
        child: SvgPicture.asset(
          getAssetsSVGImg('ic_password'),
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      validator: (string) {
        if (string == null || string.isEmpty) {
          return StringConstant.confirmPasswordEmpty;
        } else if (string != controller.passwordController.text) {
          return StringConstant.confirmPasswordShouldSame;
        }
        return null;
      },
      controller: controller.confirmPasswordController,
      isSecure: controller.isSecureConfirmPassword.value,
      suffixIcon: IconButton(
        //padding: const EdgeInsets.all(0),
        onPressed: () {
          controller.isSecureConfirmPassword.toggle();
        },

        icon: SvgPicture.asset(
          getAssetsSVGImg(
            controller.isSecureConfirmPassword.value
                ? 'ic_password_hide'
                : 'ic_password_show',
          ),
          height: getSize(24),
          width: getSize(24),
        ),
      ),
    );
  }

  Widget _buildTermsAndConditionView() {
    return Row(
      children: [
        _buildCheckBox(),
        SizedBox(width: getSize(12)),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'I agree with the company\'s ',
                  style: TextStyle(
                    color: ColorConstants.textColorSecondary,
                    fontFamily: StringConstant.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'privacy policy',
                  style: TextStyle(
                    color: ColorConstants.primary,
                    fontFamily: StringConstant.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      EasyLoading.showToast('Open Privacy Policy screen');
                      printInfo(info: 'Open Privacy Policy Screen...');
                    },
                ),
                TextSpan(
                  text: ' and ',
                  style: TextStyle(
                    color: ColorConstants.textColorSecondary,
                    fontFamily: StringConstant.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'terms of service',
                  style: TextStyle(
                    color: ColorConstants.primary,
                    fontFamily: StringConstant.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      printInfo(info: 'Open T&C Screen...');
                      EasyLoading.showToast('Open T&C Screen.');
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return CommonButton(
      onPressed: () {
        if (controller.basicDetailFormKey.currentState!.validate()) {
          if (controller.isCheckboxChecked.value) {
            controller.currentView.value = 1;
          } else {
            EasyLoading.showToast('Please accept Terms and Privacy policy.');
          }
        }
      },
      buttonText: 'Continue',
    );
  }

  Widget _buildSignInRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BaseText(
          text: 'Already Have an Account? ',
          fontWeight: FontWeight.w200,
          textColor: ColorConstants.textColorSecondary,
          fontSize: 14,
        ),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: BaseText(
            text: 'Sign In',
            fontWeight: FontWeight.w600,
            textColor: ColorConstants.primary,
            fontSize: 14,
          ),
        )
      ],
    );
  }

  Widget _buildCheckBox() {
    return InkWell(
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
