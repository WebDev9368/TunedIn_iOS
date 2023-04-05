import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Obx(() {
        return IndexedStack(
            index: controller.pageIndex.value,
            children: List<Widget>.generate(
              controller.pageList.length,
              (int index) {
                return Navigator(
                  onGenerateRoute: (RouteSettings settings) {
                    return controller.onGenerateRoute(
                        settings, controller.pageList[index]);
                  },
                );
              },
            ),
          );
        }),
        bottomNavigationBar: const BottomNavigationWidget(),
     );
  }
}
