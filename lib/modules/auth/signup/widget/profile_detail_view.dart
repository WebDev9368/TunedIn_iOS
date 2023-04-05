
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/auth/signup/sign_up_controller.dart';
import 'package:tunedln/shared/dialog/image_chooser_dialog.dart';

import '../../../../shared/constants/color_constants.dart';
import '../../../../shared/constants/string_constant.dart';
import '../../../../shared/utils/focus.dart';
import '../../../../shared/utils/image_utils.dart';
import '../../../../shared/utils/math_utils.dart';
import '../../../../shared/widgets/base_text.dart';
import '../../../../shared/widgets/common_button.dart';
import '../../../../shared/widgets/input_field.dart';

class ProfileDetailView extends GetView<SignUpController> {
  const ProfileDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return GestureDetector(
      onTap: () {
        AppFocus.unFocus();
      },
      child: Form(
          key: controller.profileDetailFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(24)),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleView(),
                SizedBox(height: getSize(24)),
                _buildProfileView(profileUrl: ''),
                SizedBox(height: getSize(24)),
                _buildFirstNameTextField(),
                SizedBox(height: getSize(24)),
                _buildLastNameTextField(),
                SizedBox(height: getSize(24)),
                _buildAboutYouTextField(),
                SizedBox(height: getSize(50)),
                _buildContinueButton(),
                SizedBox(height: getSize(24)),
                _buildSignInRow(),
                SizedBox(height: getSize(24)),
              ],
            ),
          ),
      )
    );
  }

  Widget _buildTitleView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BaseText(
          text: 'Create your Profile',
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

  Widget _buildProfileView({required String? profileUrl}) {
    return InkWell(
    onTap:() async {
      return ImageChooserDialog().showImageChooserDialog(
          takePhotoCallback: () {
            controller.imagesNew.toggle();
            controller.imgFromCamera();
          },
          selectPhotoCallback: () {
            controller.imagesNew.toggle();
            controller.imgFromGallery(); });
    },
    child:
    Obx(() {
        return Column(
      children: [
        Center(
          child: Container(
            width: getSize(126),
            height: getSize(126),
            decoration: BoxDecoration(
              color: ColorConstants.lightGrey,
              shape: BoxShape.circle,
              //image:// DecorationImage(
                //image: AssetImage(getAssetsPNGImg('profile')),
                //fit: BoxFit.cover,
              //),
               image: controller.imagesNew.value
                   ? DecorationImage(
                       fit: BoxFit.cover,
                       image: FileImage(File(controller.images!.path.toString())),
                     )
                   : DecorationImage(
                       image: AssetImage(getAssetsPNGImg('profile')),
                       fit: BoxFit.cover,
                     ),
            ),
          ),
        ),
        SizedBox(height: getSize(12)),
        const BaseText(
          text: 'Upload a Profile Picture',
          fontSize: 14,
          //fontWeight: FontWeight.w400,
        ),
      ],
    );}));
  }

  Widget _buildFirstNameTextField() {
    return InputTextField(
      hintText: StringConstant.hintFirstName,
      textCapitalization: TextCapitalization.sentences,
      prefixIcon: SizedBox(
        width: getSize(50),
        child: SvgPicture.asset(
          getAssetsSVGImg('ic_person'),
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      validator: (string) {
        if (string!.isEmpty) {
          return StringConstant.firstNameEmpty;
        }
        return null;
      },
      controller: controller.firstNameController,
    );
  }

  Widget _buildLastNameTextField() {
    return InputTextField(
      hintText: StringConstant.hintLastName,
      textCapitalization: TextCapitalization.sentences,
      prefixIcon: SizedBox(
        width: getSize(50),
        child: SvgPicture.asset(
          getAssetsSVGImg('ic_person'),
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      validator: (string) {
        if (string!.isEmpty) {
          return StringConstant.lastNameEmpty;
        }
        return null;
      },
      controller: controller.lastNameController,
    );
  }

  Widget _buildAboutYouTextField() {
    return InputTextField(
      hintText: StringConstant.hintAboutYou,
      textCapitalization: TextCapitalization.sentences,
      textInputType: TextInputType.multiline,
      maxLines: 5,
      minLines: 5,
      prefixIcon: SizedBox(
        width: getSize(50),
        child: SvgPicture.asset(
          getAssetsSVGImg('ic_person'),
          height: getSize(24),
          width: getSize(24),
        ),
      ),
      validator: (string) {
        if (string!.isEmpty) {
          return StringConstant.aboutYouEmpty;
        }
        return null;
      },
      controller: controller.aboutYouController,
    );
  }

  Widget _buildContinueButton() {
    return CommonButton(
      onPressed: () {
        if (controller.profileDetailFormKey.currentState!.validate()) {
          controller.signUp();
        }
      },
      buttonText: 'Sign Up',
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
  Widget _buildPhotoRow()  {
    return  ImageChooserDialog().showImageChooserDialog(
        takePhotoCallback: () {
        controller.imagesNew.toggle();
        controller.imgFromCamera();
    },
        selectPhotoCallback: () {
          controller.imagesNew.toggle();
          controller.imgFromGallery(); });
  }
}
