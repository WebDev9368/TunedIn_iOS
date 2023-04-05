import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:tunedln/modules/main/tabs/search/search_tab_controller.dart';
import 'package:tunedln/modules/main/tabs/search/widget/search_tab_bar_widget.dart';
import '../../../../shared/utils/image_utils.dart';
import '../../../../shared/utils/math_utils.dart';
import '../../../../shared/widgets/base_text.dart';
import '../../../../shared/widgets/input_field.dart';

class SearchTabView extends GetView<SearchTabController>{
  const SearchTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        SizedBox(height: getSize(20)),
        _buildSearchTextField(),
        SizedBox(height: getSize(16)),
        const SearchTabBarPage(),
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
              controller: controller.textController,
              hintText: 'Search here',
              fillColor: const Color(0xFFFBFBFB),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: getSize(16), right: getSize(12)),
                child: SvgPicture.asset(getAssetsSVGImg('ic_search')),
              ),
              suffixIcon: InkWell(
                  onTap: () => controller.textController.text = '',
                  child:Padding(
                padding: EdgeInsets.only(left: getSize(16), right: getSize(12)),
                child: SvgPicture.asset(getAssetsSVGImg('ic_cancel')),
              )),
              onChanged: (v) => { controller.callChatListApi() },
              onFieldSubmitted: (v) => { controller.callChatListApi() }
            ),
          ),
          SizedBox(width: getSize(12)),
          InkWell(
            onTap: () => controller.textController.text = '',
          child:const BaseText(
            text: 'Cancel',
            fontSize: 15,
          )),
        ],
      ),
    );
  }
}
