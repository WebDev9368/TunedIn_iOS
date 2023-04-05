import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/discover/events/events_controller.dart';
import 'package:tunedln/shared/utils/image_utils.dart';
import 'package:tunedln/shared/widgets/base_text.dart';
import '../../../../../../shared/constants/color_constants.dart';
import '../../../../../../shared/utils/math_utils.dart';
import '../../../../../../shared/widgets/common_button.dart';

class ConcertsDetailView extends GetView<EventsController> {
  const ConcertsDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              Container(
                height: getSize(375),
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(getAssetsPNGImg('concerts_detail_image')),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _buildAppBar(),
            ],
          ),
          SizedBox(height: getSize(10)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(24)),
            child: const BaseText(
              text: 'Starboy',
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: getSize(10)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(24)),
            child: const BaseText(
              text: 'The Weeknd, Daft Punk',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: getSize(10)),
          Row(
            children: [
              SizedBox(width: getSize(18)),
              SvgPicture.asset(getAssetsSVGImg('ic_song'),color: ColorConstants.textColorSecondary),
              SizedBox(width: getSize(10)),
              BaseText(
                text: 'Yesterday Once More',
                textColor: ColorConstants.textColorSecondary,
              ),
              const Spacer(),
              SvgPicture.asset(getAssetsSVGImg('ic_arrow_forward')),
              SizedBox(width: getSize(24)),
            ],
          ),
          SizedBox(height: getSize(2)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(24)),
            child: Divider(color: Colors.black.withOpacity(0.25),),
          ),
          SizedBox(height: getSize(10)),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(24)),
            child: BaseText(
              text:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textColor: ColorConstants.textColorSecondary,
              maxLines: 100,
            ),
          ),
          SizedBox(height: getSize(50)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(24)),
            child: CommonButton(
              onPressed: () {},
              buttonText: 'Listen this Concert',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Positioned(
      top: getSize(60),
      child: SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Container(
                height: getSize(45),
                width: getSize(45),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(getSize(12))),
                child: SvgPicture.asset(
                  getAssetsSVGImg('ic_arrow_back'),
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Container(
                height: getSize(45),
                width: getSize(45),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(getSize(12))),
                child: SvgPicture.asset(getAssetsSVGImg('ic_more_circle')),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
