import 'package:tunedln/modules/main/tabs/discover/widget/tab_bar_widget.dart';
import 'package:tunedln/shared/widgets/common_appbar.dart';
import 'package:flutter/material.dart';

class DiscoverTabView extends StatelessWidget {
  const DiscoverTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '',
        leading: Container(),
        appBarHeight: 0,
      ),
      body: _buildBody(),
      //body: DiscoverTabBarPage(),
    );
  }

  Widget _buildBody() {
    return const DiscoverTabBarPage();
  }

}
