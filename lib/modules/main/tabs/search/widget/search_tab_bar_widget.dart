import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/standard_indicator.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:flutter_custom_tab_bar/transform/scale_transform.dart';
import 'package:tunedln/modules/main/tabs/search/widget/playlist_widget.dart';
import 'package:tunedln/modules/main/tabs/search/widget/songs_widget.dart';
import '../../../../../shared/constants/color_constants.dart';
import '../../../../../shared/utils/math_utils.dart';
import '../../../../../shared/widgets/base_text.dart';
import 'friends_widget.dart';

class SearchTabBarPage extends StatefulWidget {
  const SearchTabBarPage({Key? key}) : super(key: key);

  @override
  _SearchTabBarPageState createState() => _SearchTabBarPageState();
}

class _SearchTabBarPageState extends State<SearchTabBarPage> {
  final int pageCount = 3;
  final PageController pageController = PageController();

  final CustomTabBarController _tabBarController = CustomTabBarController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Expanded(child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(24)),
            child: CustomTabBar(
              tabBarController: _tabBarController,
              height: getSize(40),
              itemCount: pageCount,
              builder: getTabBarChild,
              indicator: StandardIndicator(
                width: getSize(20),
                height: getSize(5),
                radius: BorderRadius.circular(getSize(8)),
                color: ColorConstants.primary,
              ),
              pageController: pageController,
            ),
          ),
              Expanded(

         child:PageView.builder(
              controller: pageController,
              itemCount: pageCount,
              itemBuilder: (context, index) {
                return getView(index);
                //return PageItem(index);
              },
            ),
    )],
    ));
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
                  text: getTitle(index),
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

  String getTitle(int index) {
    if (index == 0) {
      return 'Songs';
    } else if (index == 1) {
      return 'Playlist';
    } else if (index == 2) {
      return 'Finds Friend';
    } else {
      return '';
    }
  }

  Widget getView(int index){
    if (index == 0) {
      return const SongsWidget();
    } else if (index == 1) {
      return const PLayListWidget();
    } else if (index == 2) {
      return const FriendsWidget();
    } else {
      return const BaseText(text: '');
    }
  }
}
