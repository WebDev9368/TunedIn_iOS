import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/standard_indicator.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:flutter_custom_tab_bar/transform/scale_transform.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tunedln/modules/main/tabs/discover/widget/popular_widget.dart';
import 'package:tunedln/modules/main/tabs/discover/widget/recommend_widget.dart';
import 'package:tunedln/modules/main/tabs/discover/widget/similar_profile_widget.dart';
import '../../../../../shared/constants/color_constants.dart';
import '../../../../../shared/utils/image_utils.dart';
import '../../../../../shared/utils/math_utils.dart';
import '../../../../../shared/widgets/base_text.dart';

class DiscoverTabBarPage extends StatefulWidget {
  const DiscoverTabBarPage({Key? key}) : super(key: key);

  @override
  _DiscoverTabBarPageState createState() => _DiscoverTabBarPageState();
}

class _DiscoverTabBarPageState extends State<DiscoverTabBarPage> {
  final List<String> pageList = ['Recommend', 'Popular', 'Similar Profiles'];
  final PageController pageController = PageController();

  final CustomTabBarController _tabBarController = CustomTabBarController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getSize(10)),
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(24)),
              child: CustomTabBar(
                tabBarController: _tabBarController,
                height: getSize(40),
                itemCount: pageList.length,
                builder: getTabBarChild,
                indicator: StandardIndicator(
                    width: getSize(20),
                    height: getSize(5),
                    color: ColorConstants.primary,
                    radius: BorderRadius.circular(getSize(8))),
                pageController: pageController,
              ),
            ),
            Positioned(
              right: 24,
              top: -5,
              child: IconButton(
                iconSize: getSize(18),
                onPressed: () {
                  EasyLoading.showToast('Search');
                },
                icon: SvgPicture.asset(getAssetsSVGImg('ic_search')),
              ),
            ),
          ],
        ),
        Expanded(
          child: PageView.builder(
            controller: pageController,
            itemCount: pageList.length,
            itemBuilder: (context, index) {
              return getView(index);
            },
          ),
        )
      ],
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
                  text: pageList[index],
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

  Widget getView(int index) {
    if (index == 0) {
      return const RecommendWidget();
    } else if (index == 1) {
      return const PopularWidget();
    } else if (index == 2) {
      return const SimilarProfileWidget();
    } else {
      return const BaseText(text: '');
    }
  }
}
