import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../shared/constants/color_constants.dart';
import '../../../shared/constants/string_constant.dart';
import '../../../shared/utils/focus.dart';
import '../../../shared/utils/image_utils.dart';
import '../../../shared/utils/math_utils.dart';
import '../../../shared/widgets/base_text.dart';
import '../../../shared/widgets/common_appbar.dart';
import '../../../shared/widgets/common_button.dart';
import '../../../shared/widgets/input_field.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(title: ''),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      onTap: () {
        AppFocus.unFocus();
      },
      child: Form(
        key: controller.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(24)),
          child: SingleChildScrollView(
    child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  getAssetsPNGImg('forgot_password_image'),
                  height: getSize(204),
                  width: getSize(184),
                ),
              ),
              SizedBox(height: getSize(92)),
              _buildTitleView(),
              SizedBox(height: getSize(32)),
              _buildEmailTextField(),
              SizedBox(height: getSize(50)),
              _buildResetPasswordButton(),
              SizedBox(height: getSize(15)),
              _buildContactUsView(),
            ],
          ),
        ),
      ),
      )
    );
  }

  Widget _buildTitleView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getSize(16)),
        const BaseText(
          text: 'Forgot Password',
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
        SizedBox(height: getSize(12)),
        BaseText(
          text: 'Confirm your email and we ‘ll Send the instructions',
          fontSize: 14,
          textColor: ColorConstants.grey,
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
          height: getSize(16),
          width: getSize(20),
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

  Widget _buildResetPasswordButton() {
    return CommonButton(
      onPressed: () {
        if (controller.formKey.currentState!.validate()) {
          controller.resetPassword();
        }
      },
      buttonText: 'Reset password',
    );
  }

  Widget _buildContactUsView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BaseText(
          text: 'Don’t Remember email? ',
          fontSize: 14,
          textColor: ColorConstants.grey,
        ),
        InkWell(
          onTap: () {
            EasyLoading.showToast('Contact Us');
          },
          child: BaseText(
            text: 'Contact us',
            fontWeight: FontWeight.w600,
            textColor: ColorConstants.primary,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
