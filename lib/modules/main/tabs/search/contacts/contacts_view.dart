import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/search/contacts/contacts_controller.dart';
import 'package:tunedln/shared/widgets/common_appbar.dart';
import '../../../../../shared/constants/color_constants.dart';
import '../../../../../shared/utils/image_utils.dart';
import '../../../../../shared/utils/math_utils.dart';
import '../../../../../shared/widgets/base_text.dart';
import '../../../../../shared/widgets/input_field.dart';

class ContactsView extends GetView<ContactsController> {
  const ContactsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: const BaseAppBar(title: 'Contacts',),
     body: _buildBody(),
   );
  }

  Widget _buildBody(){
    return Column(
      children: [
        _buildSearchTextField(),
        _buildContactsListView(),
      ],
    );
  }

  Widget _buildSearchTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(24)),
      child: Row(
        children: [
          Expanded(
            child: InputTextField(
              controller: TextEditingController(),
              hintText: 'Search here',
              fillColor: const Color(0xFFFBFBFB),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: getSize(16), right: getSize(12)),
                child: SvgPicture.asset(getAssetsSVGImg('ic_search')),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.only(left: getSize(16), right: getSize(12)),
                child: SvgPicture.asset(getAssetsSVGImg('ic_cancel')),
              ),
            ),
          ),
          SizedBox(width: getSize(12)),
          const BaseText(
            text: 'Cancel',
            fontSize: 15,
          ),
        ],
      ),
    );
  }

  Widget _buildContactsListView() {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: getSize(24)),
        itemCount: controller.contactList.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(index);
        },
      ),
    );
  }

  Widget _buildListItem(int index) {
    ContactModel contactModel = controller.contactList[index];
    return Padding(
      padding: EdgeInsets.only(top: getSize(10)),
      child: ListTile(
        leading: _buildLeadingView(contactModel.profileImage),
        title: _buildTitleView(contactModel.name),
        subtitle: _buildSubtitleView(contactModel.detail),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildLeadingView(String userProfile) {
    return Container(
      width: getSize(52),
      height: getSize(52),
      decoration: BoxDecoration(
        color: ColorConstants.grey1,
        shape: BoxShape.circle,
        image: userProfile != null
            ? DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(userProfile),
        )
            : DecorationImage(
          image: AssetImage(getAssetsPNGImg('profile_placeholder')),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitleView(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: BaseText(
        text: name,
        fontSize: 15,
        maxLines: 1,
      ),
    );
  }

  Widget _buildSubtitleView(String detail) {
    return   BaseText(
      text: detail,
      maxLines: 1,
      fontSize: 12,
      textColor: ColorConstants.textColorSecondary,
    );
  }


}
