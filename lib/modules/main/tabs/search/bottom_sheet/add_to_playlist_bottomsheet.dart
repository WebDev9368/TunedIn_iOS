import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/search/model/song_model.dart';
import '../../../../../shared/constants/color_constants.dart';
import '../../../../../shared/utils/image_utils.dart';
import '../../../../../shared/utils/math_utils.dart';
import '../../../../../shared/widgets/base_text.dart';
import '../../../../../shared/widgets/common_button.dart';
import '../../../../../shared/widgets/input_field.dart';
import '../model/playlist_model.dart';
import '../search_tab_controller.dart';
import 'bottom_tab_controller.dart';

class PlaylistsBottomSheetWidget extends GetView<SearchTabController> {
  PlaylistsBottomSheetWidget({
    Key? key,
  }) : super(key: key);

  List<ListItemModel> list = [];

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  getBottomSheet(SongModel song) {
    list.add(ListItemModel('ic_play', 'Add to Spotify'));
    list.add(ListItemModel('ic_play_next', 'Add to Apple Music'));
    list.add(ListItemModel('ic_add_queue', 'Add to Apple Music & Spotify'));

    controller.track = song;
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: Get.height * 0.8,
        padding: EdgeInsets.only(
          left: getSize(24),
          right: getSize(24),
          top: getSize(16),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(getSize(44)),
            topRight: Radius.circular(getSize(44)),
          ),
        ),
        child: _buildListView(song)
    ));
  }

  Widget _buildListTile(SongModel song) {
    return Row(
      children: [
        _buildLeadingView(song.image),
        SizedBox(width: getSize(20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleView(song.name),
            SizedBox(height: getSize(10)),
            _buildSubtitleView(1, 20),
          ],
        )
      ],
    );
  }

  Widget _buildLeadingView(String image) {
    return image != "null"?
    SizedBox(
        width: getSize(66),
        height: getSize(66),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: Image.network(image, fit: BoxFit.cover),
        ))
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
  Widget _buildAppleView(SongModel song) {
      return Column(children: [
        Row(
          children: const [
            Icon(
              Icons.list,
              size: 30,
              color: Colors.blueAccent,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Add to Apple Music',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(children: [
          Expanded(
            child: InputTextField(
                controller: controller.textControllers,
                hintText: 'Enter new playlist name',
                fillColor: const Color(0xFFFBFBFB),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: getSize(12), right: getSize(12)),
                  child: SvgPicture.asset(getAssetsSVGImg('ic_add_playlist')),
                ),
                //onChanged: (v) => { controller.callPlayListApi()},
                //onFieldSubmitted: (v) => { controller.callPlayListApi()}
            ),
          ),
          SizedBox(width: getSize(12)),
          BaseButton(
              width: getSize(85),
              height: getSize(34),
              borderRadius: 17,
              onPressed: () {
                controller.createPlayListAppleApi(controller.textControllers.text);
                controller.textControllers.clear();
              },
              childWidget: const BaseText(
                text: 'Create',
                fontSize: 15))
        ],
        ),
        _buildPlayListView(song)
      ]);
  }

  Widget _buildSpotifyView(SongModel song) {
    return  Column(children: [
      Row(
        children: const [
          Icon(
            Icons.list,
            size: 30,
            color: Colors.blueAccent,
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              'Add to Spotify',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      Row(children: [
        Expanded(
          child: InputTextField(
              controller: controller.textControllerSpotify,
              hintText: 'Enter new playlist name',
              fillColor: const Color(0xFFFBFBFB),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: getSize(12), right: getSize(12)),
                child: SvgPicture.asset(getAssetsSVGImg('ic_add_playlist')),
              ),
             // onChanged: (v) => { controller.callPlayListSpotifyApi()},
              //onFieldSubmitted: (v) => { controller.callPlayListSpotifyApi()}
          ),
        ),
          SizedBox(width: getSize(12)),
        BaseButton(
            width: getSize(85),
            height: getSize(34),
            borderRadius: 17,
            onPressed: () {
              controller.createPlayListSpotifyApi(controller.textControllerSpotify.text);
              controller.textControllerSpotify.clear();
            },
            childWidget: const BaseText(
              text: 'Create',
              fontSize: 15,
            )),
      ],
      ),
      _buildPlayListsView(song)
    ]);
    // });
  }


  Widget _buildTitleView(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: BaseText(
        text: name,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        maxLines: 1,
      ),
    );
  }

  Widget _buildSubtitleView(int album, int song) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: '$album Album',
          maxLines: 1,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          textColor: ColorConstants.textColorSecondary,
        ),
        SizedBox(width: getSize(10)),
        const VerticalDivider(
          thickness: 4,
          width: 1,
          color: Colors.red,
        ),
        BaseText(
          text: '$song Song',
          maxLines: 1,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          textColor: ColorConstants.textColorSecondary,
        ),
      ],
    );
  }

  Widget _buildListView(SongModel song) {
    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: getSize(10)),
    child:ListView(
      physics: const BouncingScrollPhysics(),
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(

            height: getSize(5),
            width: getSize(50),
            decoration: BoxDecoration(
              color: ColorConstants.grey1,
              borderRadius: BorderRadius.circular(getSize(2)),
            ),
          ),
        ),
        SizedBox(height: getSize(14)),
        _buildListTile(song),
        SizedBox(height: getSize(14)),
        const Divider(),
        _buildAppleView(song),
        SizedBox(height: getSize(32)),
        _buildSpotifyView(song),
      ],
    ));
  }

  Widget _buildPlayListView(SongModel song) {
    return Obx(() =>controller.isApple.isFalse?
      ListView.builder(
      itemCount: controller.playlist.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        Playlists listItemModel = controller.playlist[index];
        return ListTile(
          onTap: (){
            //EasyLoading.showToast(listItemModel.name);
            controller.addToPlayListAppleApi(listItemModel.id, song);
          },
          leading: SizedBox(height: 20,
              child:SvgPicture.asset(getAssetsSVGImg("ic_music"))),
          title: BaseText(text: listItemModel.name),
        );
      },
    ): Platform.isIOS
    ? const CupertinoActivityIndicator(animating: true)
        : CircularProgressIndicator(color: ColorConstants.primary));
  }
  Widget _buildPlayListsView(SongModel song) {
    return Obx(() =>controller.isSpotify.isFalse?
      ListView.builder(
      itemCount: controller.playlistSpotify.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        Playlists listItemModel = controller.playlistSpotify[index];
        return ListTile(
          onTap: (){
          //  EasyLoading.showToast(listItemModel.name);
            controller.addToPlayListSpotifyApi(listItemModel.id, song);
          },
          leading: SizedBox(height: 20,
              child:SvgPicture.asset(getAssetsSVGImg("ic_music"))),
          title: BaseText(text: listItemModel.name),
        );
      },
    ): Platform.isIOS
    ? const CupertinoActivityIndicator(animating: true)
        : CircularProgressIndicator(color: ColorConstants.primary));
  }
}

class ListItemModel {
  final String icon;
  final String title;

  ListItemModel(this.icon, this.title);
}
