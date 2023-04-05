import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../../shared/constants/color_constants.dart';
import '../../../../../../shared/utils/image_utils.dart';
import '../../../../../../shared/utils/math_utils.dart';
import '../../../../../../shared/widgets/base_text.dart';
import '../../discover_tab_controller.dart';

class EventsListWidget extends GetView<DiscoverTabController> {
  const EventsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: getSize(20)),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(index);
        },
      ),
    );
  }


  Widget _buildListItem(int index) {
    return Padding(
      padding: EdgeInsets.only(
        top: getSize(10),
        bottom: index == controller.friendList.length - 1 ? getSize(50) : 0,
      ),
      child: Column(
        children: [
          SizedBox(height: getSize(18)),
          _buildFeedView(),
        ],
      ),
    );
  }

  Widget _buildFeedView() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorConstants.lightGrey,
            borderRadius: BorderRadius.circular(getSize(16)),
          ),
          width: Get.width,
          height: getSize(192),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(getSize(16)),
            child: Image.asset(
              getAssetsPNGImg('event_image'),
              fit: BoxFit.cover,
              width: Get.width,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(getSize(16)),
            topRight: Radius.circular(getSize(16)),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.35),
            height: getSize(40),
            child: Row(
              children: [
                SizedBox(width: getSize(18)),
                SvgPicture.asset(getAssetsSVGImg('ic_song')),
                SizedBox(width: getSize(10)),
                const BaseText(
                  text: 'Yesterday Once More',
                  textColor: Colors.white,
                ),
                const Spacer(),
                SvgPicture.asset(getAssetsSVGImg('ic_arrow_forward')),
                SizedBox(width: getSize(24)),
              ],
            ),
          ),
        ),
        Positioned.fill(
          bottom: -140,
          child: Row(
            children: [
              SizedBox(width: getSize(18)),
              SvgPicture.asset(getAssetsSVGImg('ic_listen')),
              SizedBox(width: getSize(10)),
              const BaseText(
                text: '68.6k',
                textColor: Colors.white,
                fontSize: 12,
              ),
              const Spacer(),
              const BaseText(
                text: '10 : 00',
                textColor: Colors.white,
                fontSize: 12,
              ),
              SizedBox(width: getSize(10)),
              SvgPicture.asset(
                getAssetsSVGImg('ic_play_fill'),
                height: getSize(24),
                width: getSize(24),
              ),
              SizedBox(width: getSize(24)),
            ],
          ),
        ),
      ],
    );
  }

}