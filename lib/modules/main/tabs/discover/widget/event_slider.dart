import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/discover/discover_tab_controller.dart';
import 'package:tunedln/shared/utils/image_utils.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../shared/constants/color_constants.dart';
import '../../../../../shared/utils/math_utils.dart';

class EventCarouselSlider extends GetView<DiscoverTabController> {
  const EventCarouselSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CarouselSlider(
          items: _getImageSlider(),
          carouselController: CarouselController(),
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: false,
              height: 120,
              viewportFraction: 1.0,
              //aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                controller.sliderCurrent.value = index;
              }),
        ),
        SizedBox(height: getSize(24)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                controller.eventSliderImageList.asMap().entries.map((entry) {
              return Obx(() {
                return Container(
                  width: getSize(12),
                  height: getSize(12),
                  margin: EdgeInsets.symmetric(horizontal: getSize(4)),
                  decoration: BoxDecoration(
                    //border: Border.all(color: ColorConstants.primary, width: 1),
                    shape: BoxShape.circle,
                    color: controller.sliderCurrent.value == entry.key
                        ? ColorConstants.primary
                        : ColorConstants.primary.withOpacity(0.31),
                  ),
                );
              });
            }).toList(),
          ),
        ),
      ],
    );
  }

  List<Widget> _getImageSlider() {
    final List<Widget> imageSliders = controller.eventSliderImageList
        .map((item) => _buildImageView(item))
        .toList();

    return imageSliders;
  }

  Widget _buildImageView(String imageUrl) {
    return GestureDetector(
      onTap: (){
         Get.toNamed(Routes.events);
      },
      child: Image.asset(
        getAssetsPNGImg('event_bg_image'),
      ),
    );

    return Container(
      //height: getSize(160),
      //margin: EdgeInsets.symmetric(horizontal: getSize(20)),
      decoration: BoxDecoration(
        color: ColorConstants.grey1,
        borderRadius: BorderRadius.circular(getSize(12)),
        image: DecorationImage(
          //fit: BoxFit.cover,
          //image: CachedNetworkImageProvider(imageUrl),
          image: AssetImage(getAssetsPNGImg('event_bg_image')),
        ),
      ),
    );
  }
}
