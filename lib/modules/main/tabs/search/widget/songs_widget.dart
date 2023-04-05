import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tunedln/modules/main/tabs/search/bottom_sheet/song_bottomsheet.dart';
import 'package:tunedln/modules/main/tabs/search/model/song_model.dart';
import 'package:tunedln/modules/main/tabs/search/search_tab_controller.dart';
import 'package:tunedln/shared/widgets/common_button.dart';
import '../../../../../shared/constants/color_constants.dart';
import '../../../../../shared/constants/string_constant.dart';
import '../../../../../shared/utils/focus.dart';
import '../../../../../shared/utils/image_utils.dart';
import '../../../../../shared/utils/math_utils.dart';
import '../../../../../shared/widgets/base_text.dart';
import '../bottom_sheet/add_to_playlist_bottomsheet.dart';

class SongsWidget extends GetView<SearchTabController> {
  const SongsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
      AppFocus.unFocus();
    },
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(24)),
      child: SmartRefresher(
          enablePullUp: true,
          controller: controller.songRefreshController,
          onRefresh: () async {
            Timer(const Duration(seconds: 3),
                () => controller.songRefreshController.refreshCompleted());
          },
          onLoading: () async {
            Timer(const Duration(seconds: 3),
                () => controller.songRefreshController.loadComplete());
          },
          child: Obx(
            () =>
                controller.songList.isEmpty ? _buildNoData() : _buildListView(),
          ),
        ),
      ));
  }

  Widget _buildNoData() {
    return const Center(
      child: BaseText(
        text: StringConstant.noResult,
      ),
    );
  }

  Widget _buildListView() {
    return  ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      //padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      itemCount: controller.songList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildListItem(index);
      },
    );
  }

  Widget _buildListItem(int index) {
    SongModel songModel = controller.songList[index];
    return Padding(
      padding: EdgeInsets.only(top: getSize(10)),
      child: ListTile(
        leading: _buildLeadingView(songModel.image, songModel.from ??''),
        title: _buildTitleView(songModel.name),
        subtitle: _buildSubtitleView(songModel.artists//, songModel.totalSing
        ),
        contentPadding: EdgeInsets.zero,
        //trailing: _buildPlayButton(),
        //trailing: _buildMenuButton(),
        trailing: SizedBox(

          height: getSize(148),
          width: getSize(108),
         // child: Expanded(
          child:
            Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(children:[
              _buildPlayButton(),
                _buildAddButton(songModel),
             ]),
        Flexible(
          child:_buildMenuButton(songModel)),
             // _buildAddButton(),
            ],
          ),

        ),
      ),
   // )
    );
  }

  Widget _buildLeadingView(String image, String from) {
    return image != "null"?
    SizedBox(
        width: getSize(92),
        height: getSize(66),child:
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
    BaseText(
    text: from,
    fontSize: 12,
    maxLines: 1,
    ),
      SizedBox(
        width: getSize(66),
        height: getSize(66),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(image, fit: BoxFit.cover),
    ))]))
    :Container(
      width: getSize(66),
      height: getSize(66),
      decoration: BoxDecoration(
        color: ColorConstants.grey1,
        borderRadius: BorderRadius.circular(getSize(10)),
        image: DecorationImage(
          image: AssetImage(
            getAssetsPNGImg(image),
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitleView(String songName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: BaseText(
        text: songName,
        fontSize: 15,
        maxLines: 1,
      ),
    );
  }

  Widget _buildSubtitleView(String albumName//, int totalSing
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: albumName,
          maxLines: 1,
          fontSize: 12,
          textColor: ColorConstants.textColorSecondary,
        ),
        SizedBox(height: getSize(10)),
        Row(
          children: [
            SvgPicture.asset(
              getAssetsSVGImg('ic_sing'),
              height: getSize(10),
              width: getSize(10),
            ),
            SizedBox(width: getSize(5)),
           /* BaseText(
              text: '$totalSing',
              maxLines: 1,
              fontSize: 12,
              textColor: ColorConstants.textColorSecondary,
            ),*/
          ],
        ),
      ],
    );
  }

  Widget _buildPlayButton() {
    return BaseButton(
      width: getSize(70),
      height: getSize(34),
      borderRadius: 17,
      onPressed: () {
        EasyLoading.showToast('Play Song');
      },
      childWidget: const BaseText(
        text: 'Play',
        fontSize: 15,
        textColor: Colors.white,
      ),
    );
  }

  Widget _buildAddButton(SongModel song) {
    return InkWell(
      onTap: () {

        controller.callPlayListApi();
        controller.callPlayListSpotifyApi();
        PlaylistsBottomSheetWidget().getBottomSheet(song);
      },
      child:SizedBox(
        width: getSize(22),
    height: getSize(22),
    child:Image.asset(getAssetsPNGImg('add_to_playlist')),));
  }

  Widget _buildMenuButton(SongModel songModel) {
    return IconButton(
      onPressed: () {

        controller.callPlayListApi();
        controller.callPlayListSpotifyApi();
        SongBottomSheetWidget().getBottomSheet(songModel);
      },
      icon: SvgPicture.asset(
        getAssetsSVGImg('ic_menu'),
      ),
    );
  }
}
