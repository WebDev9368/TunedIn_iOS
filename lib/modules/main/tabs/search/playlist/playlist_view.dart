import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/search/playlist/playlist_controller.dart';
import 'package:tunedln/shared/shared.dart';
import 'package:tunedln/shared/utils/image_utils.dart';
import 'package:tunedln/shared/widgets/base_text.dart';
import 'package:tunedln/shared/widgets/common_button.dart';
import '../../../../../shared/utils/math_utils.dart';

class PlayListView extends GetView<PlayListController> {
  const PlayListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: getSize(300),
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(getAssetsPNGImg('playlist_image')),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
              SizedBox(height: getSize(140)),
              const Align(
                alignment: Alignment.center,
                child: BaseText(
                  text: 'An Evening With\nSilk Sonic',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: getSize(10)),
              Align(
                alignment: Alignment.center,
                child: BaseText(
                  text: 'Bruno mars, Anderson .Paak',
                  textAlign: TextAlign.center,
                  textColor: ColorConstants.textColorSecondary,
                ),
              ),
              SizedBox(height: getSize(10)),
              Align(
                alignment: Alignment.center,
                child: BaseText(
                  text: '2021',
                  textAlign: TextAlign.center,
                  textColor: ColorConstants.textColorSecondary,
                ),
              ),
              SizedBox(height: getSize(20)),
              _buildPlayShuffleButton(),
              SizedBox(height: getSize(35)),
              _buildFavouriteInfoShareView(),
              SizedBox(height: getSize(27)),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: getSize(24)),
                title: const BaseText(text: 'Leave the Door Open'),
                subtitle: const BaseText(text: 'Bruno mars, Anderson .Paak'),
                trailing:  IconButton(
                  onPressed: () {},
                  icon: Container(
                    height: getSize(45),
                    width: getSize(45),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(getSize(12))),
                    child: SvgPicture.asset(getAssetsSVGImg('ic_menu')),
                  ),
                ),
              )
            ],
          ),
          _buildAppBar(),
          Positioned(
            top: getSize(180),
            left: 0,
            right: 0,
            child: Image.asset(
              getAssetsPNGImg('playlist_image'),
              height: getSize(240),
              width: getSize(240),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Positioned(
      top: getSize(60),
      child: SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Container(
                height: getSize(45),
                width: getSize(45),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(getSize(12))),
                child: SvgPicture.asset(getAssetsSVGImg('ic_arrow_back')),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Container(
                height: getSize(45),
                width: getSize(45),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(getSize(12))),
                child: SvgPicture.asset(getAssetsSVGImg('ic_menu')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayShuffleButton() {
    return Row(
      children: [
        SizedBox(width: getSize(20)),
        Expanded(
          child: BaseButton(
            height: getSize(46),
            borderRadius: 8,
            onPressed: () {
              EasyLoading.showToast('Play Song');
            },
            childWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.play_arrow),
                SizedBox(width: getSize(10)),
                const BaseText(
                  text: 'Play',
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ),
        SizedBox(width: getSize(20)),
        Expanded(
          child: BaseButton(
            height: getSize(46),
            borderRadius: 8,
            backgroundColor: ColorConstants.grey1,
            onPressed: () {
              EasyLoading.showToast('Shuffle Song');
            },
            childWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(getAssetsSVGImg('ic_shuffle')),
                SizedBox(width: getSize(10)),
                const BaseText(
                  text: 'Shuffle',
                )
              ],
            ),
          ),
        ),
        SizedBox(width: getSize(20)),
      ],
    );
  }

  Widget _buildFavouriteInfoShareView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(24)),
      child: Row(
        children: [
          _buildCommonView('ic_favourite', 'Favorite'),
          SizedBox(width: getSize(32)),
          _buildCommonView('ic_info', 'Album Info'),
          SizedBox(width: getSize(32)),
          _buildCommonView('ic_share_song', 'Share'),
        ],
      ),
    );
  }

  Widget _buildCommonView(String icon, String title) {
    return Column(
      children: [
        Image.asset(
          getAssetsPNGImg(icon),
          width: getSize(18),
          height: getSize(18),
        ),
        SizedBox(height: getSize(10)),
        BaseText(text: title),
      ],
    );
  }
}
