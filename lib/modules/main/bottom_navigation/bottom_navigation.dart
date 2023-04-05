import 'package:cached_network_image/cached_network_image.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:tunedln/modules/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/shared/constants/constants.dart';
import '../../../shared/utils/image_utils.dart';
import '../../../shared/utils/math_utils.dart';

class BottomNavigationWidget extends GetView<MainController> {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
     return Container(
       height: getSize(100),
//
       decoration: BoxDecoration(
         boxShadow: [
           BoxShadow(
             color: ColorConstants.textColorPrimary.withOpacity(0.12),
             spreadRadius: 0,
             blurRadius: 32,
           ),
         ],
       ),

       child: BottomNavigationBar(
         type: BottomNavigationBarType.fixed,
         // Fixed
         //backgroundColor: Colors.red,
         //backgroundColor: ColorConstants.cardColor,
         // <-- This works for fixed
         showSelectedLabels: true,
         showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
           BottomNavigationBarItem(
             icon: _getIcon(0),
             label: 'Discover',
           ),
           BottomNavigationBarItem(
             icon: _getIcon(1),
             label: 'Search',
           ),
            BottomNavigationBarItem(
              icon: _getIcon(2),
              label: 'Add',
            ),
           BottomNavigationBarItem(
             icon: _getIcon(3),
             label: 'Chat',
           ),
           BottomNavigationBarItem(
             icon: _getIcon(4),
             label: 'Profile',
           ),
         ],
         currentIndex: controller.currentTabIndex.value,
         onTap: (int index) {
           controller.switchTab(index);
         },
       ),
     );
   });
 }
      /*return Container(
          height: getSize(150),
          child: ConvexAppBar(
        color: ColorConstants.tabUnselectedTextColor,
        backgroundColor: Colors.white,
        activeColor: ColorConstants.primary,
        elevation: 0.5,
        style: TabStyle.fixedCircle,
        top: -40,
        curveSize: 100,
        items: [
          TabItem(
            icon: _getIcon(0),
            title: 'Discover',
            fontFamily: StringConstant.fontFamily,
          ),
          TabItem(
            icon: _getIcon(1),
            title: 'Search',
            fontFamily: StringConstant.fontFamily,
          ),
          TabItem(
            icon: Padding(
              padding: EdgeInsets.all(getSize(20)),
              child: SvgPicture.asset(
                getAssetsSVGImg('ic_tab_add'),
                width: getSize(10),
                height: getSize(10),
                //color: selected ? ColorConstants.primary : null,
              ),
            ),
            title: 'Add',
            fontFamily: StringConstant.fontFamily,
          ),
          TabItem(
            icon: _getIcon(3),
            title: 'Chat',
            fontFamily: StringConstant.fontFamily,
          ),
          TabItem(
            icon: _getIcon(4),
            title: 'Profile',
            fontFamily: StringConstant.fontFamily,
          ),
        ],
        onTap: (int index) => controller.switchTab(index),
      ));
    });
  }
*/
  Widget _getIcon(int index) {
    bool selected = controller.currentTabIndex.value == index;

    String icon = '';

    switch (index) {
      case 0:
        icon = 'ic_tab_discover';
        break;

      case 1:
        icon = 'ic_tab_search';
        break;
      case 2:
        icon = 'ic_tab_add';
        break;
      case 3:
        icon = 'ic_tab_chat';
        break;

      case 4:
        icon = 'ic_tab_profile';
        break;
    }

    return SvgPicture.asset(
      getAssetsSVGImg(icon),
      width: getSize(24),
      height: getSize(24),
      color: selected ? ColorConstants.primary : null,
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Obx(() {
//     return Container(
//       height: getSize(100),
//
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: ColorConstants.textColorPrimary.withOpacity(0.12),
//             spreadRadius: 0,
//             blurRadius: 32,
//           ),
//         ],
//       ),
//
//       child: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         // Fixed
//         //backgroundColor: Colors.red,
//         //backgroundColor: ColorConstants.cardColor,
//         // <-- This works for fixed
//         showSelectedLabels: true,
//         showUnselectedLabels: true,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: _getIcon(0),
//             label: 'Discover',
//           ),
//           BottomNavigationBarItem(
//             icon: _getIcon(1),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: _getIcon(2),
//             label: 'Chat',
//           ),
//           BottomNavigationBarItem(
//             icon: _getIcon(3),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: controller.currentTabIndex.value,
//         onTap: (int index) {
//           controller.switchTab(index);
//         },
//       ),
//     );
//   });
// }
//
// Widget _getIcon(int index) {
//   bool selected = controller.currentTabIndex.value == index;
//
//   String icon = '';
//
//   switch (index) {
//     case 0:
//       icon = 'ic_tab_discover';
//       break;
//
//     case 1:
//       icon = 'ic_tab_search';
//       break;
//
//     case 2:
//       icon = 'ic_tab_chat';
//       break;
//
//     case 3:
//       icon = 'ic_tab_profile';
//       break;
//
//   }
//
//   return SvgPicture.asset(
//     getAssetsSVGImg(icon),
//     width: getSize(24),
//     height: getSize(24),
//     color: selected ? ColorConstants.primary : null,
//   );
// }
}
