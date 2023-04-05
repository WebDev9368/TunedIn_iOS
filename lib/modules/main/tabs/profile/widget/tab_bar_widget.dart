import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/standard_indicator.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:flutter_custom_tab_bar/transform/scale_transform.dart';
import 'package:tunedln/modules/main/tabs/profile/widget/songs_cover_widget.dart';

import '../../../../../shared/constants/color_constants.dart';
import '../../../../../shared/utils/math_utils.dart';
import '../../../../../shared/widgets/base_text.dart';

class StandardTabBarPage extends StatefulWidget {
  const StandardTabBarPage({Key? key}) : super(key: key);

  @override
  _StandardTabBarPageState createState() => _StandardTabBarPageState();
}

class _StandardTabBarPageState extends State<StandardTabBarPage> {
  final int pageCount = 2;
  final PageController pageController = PageController();

  final CustomTabBarController _tabBarController = CustomTabBarController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CustomTabBar(
            tabBarController: _tabBarController,
            height: getSize(40),
            itemCount: pageCount,
            builder: getTabBarChild,
            indicator: StandardIndicator(
              width: getSize(20),
              height: getSize(5),
              color: ColorConstants.primary,
            ),
            pageController: pageController,
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: pageCount,
              itemBuilder: (context, index) {
                return index == 0
                    ? const SongsCoverWidget()
                    : const Center(
                        child: BaseText(text: 'Playlists View'),
                      );
                //return PageItem(index);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getTabBarChild(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(left: index != 0 ? getSize(17) : 0),
      child: TabBarItem(
        index: index,
        transform: ScaleTransform(
          // maxScale: 1.3,
          transform: ColorsTransform(
            normalColor: ColorConstants.textColorSecondary,
            highlightColor: Colors.black,
            builder: (context, color) {
              return Container(
                alignment: Alignment.center,
                // constraints: const BoxConstraints(minWidth: 70),
                child: BaseText(
                  text: index == 0 ? 'Song Covers' : 'Playlists',
                  fontSize: 15,
                  fontWeight: _tabBarController.currentIndex == index
                      ? FontWeight.w700
                      : FontWeight.w400,
                  textColor: _tabBarController.currentIndex == index
                      ? Colors.black
                      : ColorConstants.textColorSecondary,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
