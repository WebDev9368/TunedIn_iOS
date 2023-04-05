import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/discover/events/events_controller.dart';
import 'package:tunedln/modules/main/tabs/discover/events/widget/events_list_widget.dart';
import 'package:tunedln/modules/main/tabs/discover/events/widget/nearby_concert_widget.dart';
import 'package:tunedln/shared/shared.dart';
import 'package:tunedln/shared/utils/image_utils.dart';
import 'package:tunedln/shared/widgets/base_text.dart';
import 'package:tunedln/shared/widgets/common_appbar.dart';
import 'package:tunedln/shared/widgets/common_button.dart';
import '../../../../../shared/utils/math_utils.dart';
import '../widget/featured_list_widget.dart';
import '../widget/popular_event_slider.dart';
import '../widget/trending_post_widget.dart';

class EventsView extends GetView<EventsController> {
  const EventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(title: 'Events'),
      body: ListView(
        children: [
          SizedBox(height: getSize(18)),
          const PopularEventCarouselSlider(),
          SizedBox(height: getSize(24)),
          _buildNearbyConcertsView(),
          SizedBox(height: getSize(16)),
          const NearbyConcertsWidget(),
          SizedBox(height: getSize(24)),
          _buildEventsConcertsView(),
          const EventsListWidget(),
          SizedBox(height: getSize(30)),
        ],
      ),
    );
  }

  Widget _buildNearbyConcertsView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: Row(
        children: [
          SvgPicture.asset(
            getAssetsSVGImg('ic_star'),
            width: getSize(14),
            height: getSize(14),
          ),
          SizedBox(width: getSize(10)),
          const BaseText(
            text: 'Nearby Concerts',
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }

  Widget _buildEventsConcertsView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: Row(
        children: [
          SvgPicture.asset(
            getAssetsSVGImg('ic_star'),
            width: getSize(14),
            height: getSize(14),
          ),
          SizedBox(width: getSize(10)),
          const BaseText(
            text: 'Events',
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
