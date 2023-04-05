import 'package:flutter/material.dart';
import 'package:tunedln/modules/main/tabs/chat/widget/stacked_widgets.dart';
import 'package:tunedln/shared/utils/image_utils.dart';
import '../../../../../shared/utils/math_utils.dart';
import '../../../../../shared/widgets/base_text.dart';

class GroupsChatsWidget extends StatelessWidget {
  const GroupsChatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildGroupsView(),
        SizedBox(width: getSize(20)),
        _buildChatsView(),
      ],
    );
  }

  Widget _buildGroupsView() {
    return Container(
      //height: getSize(150),
      width: getSize(140),
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(18),
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(getSize(16)),
      ),
      child: Column(
        children: [
          const BaseText(
            text: 'Groups',
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: getSize(6)),
          const BaseText(
            text: '8563 Singer Online',
            fontSize: 12,
          ),
          SizedBox(height: getSize(40)),
          buildStackedImages(),
        ],
      ),
    );
  }

  Widget buildStackedImages({
    TextDirection direction = TextDirection.ltr,
  }) {
    const double size = 30;
    const double xShift = 10;
    final urlImages = [
      'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    ];

    final items = urlImages.map((urlImage) => _buildImage(urlImage)).toList();
    items.add(_buildMoreView());

    return StackedWidgets(
      direction: direction,
      items: items,
      size: size,
      xShift: xShift,
    );
  }

  Widget _buildImage(String urlImage) {
    const double borderSize = 1;

    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(borderSize),
        color: Colors.white,
        child: ClipOval(
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildMoreView(){
    const double borderSize = 1;

    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(borderSize),
        color: const Color(0xFFC5C5D1),
        child: ClipOval(
          child: Image.asset(getAssetsPNGImg('more_bg')),
        ),
      ),
    );
  }

  Widget _buildChatsView() {
    return Container(
      //height: getSize(150),
      width: getSize(140),
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(18),
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(getSize(16)),
      ),
      child: Column(
        children: [
          const BaseText(
            text: 'Chat',
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: getSize(6)),
          const BaseText(
            text: 'Random match',
            fontSize: 12,
          ),
          SizedBox(height: getSize(40)),
          buildStackedImages(),
        ],
      ),
    );
  }
}
