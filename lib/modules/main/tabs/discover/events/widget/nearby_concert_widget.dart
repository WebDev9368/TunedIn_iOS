import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/shared/utils/math_utils.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../shared/utils/image_utils.dart';
import '../../../../../../shared/widgets/base_text.dart';

class NearbyConcertsWidget extends StatelessWidget {
  const NearbyConcertsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getSize(120),
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(index);
        },
      ),
    );
  }

  Widget _buildListItem(int index) {
    return Container(
      width: getSize(123),
      margin: EdgeInsets.only(
        left: index == 0 ? getSize(24) : 0,
        right: getSize(24),
      ),
      child: GestureDetector(
        onTap: (){
          Get.toNamed(Routes.concertsDetails);
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(getSize(16)),
              child: Image.asset(
                getAssetsPNGImg('singer_image'),
                height: getSize(123),
                width: getSize(123),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: getSize(7),
              top: getSize(7),
              child: Container(
                height: getSize(16),
                width: getSize(42),
                decoration: BoxDecoration(
                  color: const Color(0xFFA6CFD5).withOpacity(0.33),
                  borderRadius: BorderRadius.circular(getSize(21)),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      getAssetsSVGImg('ic_fire'),
                      width: getSize(10),
                      height: getSize(10),
                    ),
                    const BaseText(
                      text: 'Top 1',
                      fontSize: 12,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              right: getSize(10),
              top: getSize(7),
              child: const BaseText(
                text: '2K',
                fontSize: 12,
                textColor: Color(0xFFC5C5D1),
              ),
            ),

            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(getSize(16)),
                  bottomRight: Radius.circular(getSize(16)),
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.35),
                  height: getSize(24),
                  width: getSize(123),
                  padding: EdgeInsets.only(
                    left: getSize(10),
                    right: getSize(10),
                  ),
                  child: const BaseText(
                    text: 'good day',
                    textColor: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
