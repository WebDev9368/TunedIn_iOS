import 'package:flutter/material.dart';

import '../../../../../../shared/constants/color_constants.dart';
import '../../../../../../shared/utils/math_utils.dart';
import '../../../../../../shared/widgets/base_text.dart';

class ChatDateSeparatorView extends StatelessWidget {
  final String date;

  const ChatDateSeparatorView({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          //alignment: Alignment.center,
          margin: EdgeInsets.only(top: getSize(10),),
          padding: EdgeInsets.symmetric(
            horizontal: getSize(12),
            vertical: getSize(4),
          ),
          decoration: BoxDecoration(
            color: ColorConstants.primary,
            borderRadius: BorderRadius.circular(getSize(12)),
          ),
          child: BaseText(
            text: date,
            textColor: Colors.white,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
