import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/search/model/song_model.dart';
import '../../../../../shared/constants/color_constants.dart';
import '../../../../../shared/utils/image_utils.dart';
import '../../../../../shared/utils/math_utils.dart';
import '../../../../../shared/widgets/base_text.dart';
import 'add_to_playlist_bottomsheet.dart';
import 'bottom_tab_controller.dart';

class SongBottomSheetWidget extends  GetView<BottomTabController> {
  SongBottomSheetWidget({
    Key? key,
  }) : super(key: key);

  List<ListItemModel> list = [];

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  getBottomSheet(SongModel song) {
    list.add(ListItemModel('ic_play', 'Play'));
    list.add(ListItemModel('ic_play_next', 'Play Next'));
    list.add(ListItemModel('ic_add_queue', 'Add to Playing Queue'));
    list.add(ListItemModel('ic_add_playlist', 'Add to Playlist'));
    list.add(ListItemModel('ic_share', 'Share'));

    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: Get.height * 0.6,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            // SizedBox(height: getSize(14)),
            _buildListView(song),
          ],
        ),
      ),
    );
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
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        ListItemModel listItemModel = list[index];
        return ListTile(
          onTap: (){
            if(index == 3) {
              PlaylistsBottomSheetWidget().getBottomSheet(song);
             }else{
              EasyLoading.showToast(listItemModel.title);

            }
          },
          leading: SvgPicture.asset(getAssetsSVGImg(listItemModel.icon)),
          title: BaseText(text: listItemModel.title),
        );
      },
    );
  }
}



class ListItemModel {
  final String icon;
  final String title;

  ListItemModel(this.icon, this.title);
}
