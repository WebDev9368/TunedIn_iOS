import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/post_song/post_song_controller.dart';
import 'package:tunedln/modules/main/tabs/post_song/widget/song_album_widget.dart';
import 'package:tunedln/shared/shared.dart';
import 'package:tunedln/shared/utils/image_utils.dart';
import 'package:tunedln/shared/widgets/base_text.dart';
import 'package:tunedln/shared/widgets/common_appbar.dart';
import 'package:tunedln/shared/widgets/common_button.dart';
import '../../../../shared/utils/math_utils.dart';

class PostSongView extends GetView<PostSongController> {
  const PostSongView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: const BaseAppBar(
        title: 'Post Songs',
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getSize(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BaseText(
              text: 'New Post',
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: getSize(6)),
            const BaseText(
              text: 'Select the Option to Explore more .',
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
            SizedBox(height: getSize(16)),
            const SongAlbumWidget(),
            SizedBox(height: getSize(30)),
            Obx(() {
              return controller.currentView.value == 0
                  ? _buildSongView()
                  : _buildUploadAlbumView();
            }),
            SizedBox(height: getSize(30)),
            _buildLabelText('Post Description'),
            SizedBox(height: getSize(14)),
            _buildPostDescriptionTextField(),
            SizedBox(height: getSize(50)),
            _buildPostButton(),
            SizedBox(height: getSize(40)),
          ],
        ),
      ),
    );
  }

  Widget _buildSongView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabelText('Upload Song'),
        SizedBox(height: getSize(14)),
        _buildUploadSongButton(),
      ],
    );
  }

  Widget _buildUploadSongButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(getSize(10)),
      child: Material(
        color: ColorConstants.grey2,
        child: InkWell(
            borderRadius: BorderRadius.circular(getSize(10)),
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              height: getSize(51),
              width: Get.width,
              padding: EdgeInsets.symmetric(
                horizontal: getSize(12),
                vertical: getSize(15),
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(getSize(10)),
              ),
              child: const BaseText(
                text: 'Upload',
                fontSize: 14,
              ),
            )),
      ),
    );
  }

  Widget _buildSelectCoverButton() {
    return DottedBorder(
      dashPattern: const [10, 10, 10, 10],
      color: Colors.black.withOpacity(0.3),
      borderType: BorderType.RRect,
      radius: Radius.circular(getSize(12)),
      padding: EdgeInsets.all(getSize(6)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(getSize(10)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              borderRadius: BorderRadius.circular(getSize(10)),
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                height: getSize(88),
                width: Get.width,
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(12),
                  vertical: getSize(15),
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(getSize(10)),
                ),
                child: Image.asset(getAssetsPNGImg('select_cover')),
              )),
        ),
      ),
    );
  }

  Widget _buildUploadPlaylistButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(getSize(10)),
      child: Material(
        color: ColorConstants.grey2,
        child: InkWell(
            borderRadius: BorderRadius.circular(getSize(10)),
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              height: getSize(51),
              width: Get.width,
              padding: EdgeInsets.symmetric(
                horizontal: getSize(12),
                vertical: getSize(15),
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(getSize(10)),
              ),
              child: const BaseText(
                text: 'Upload Playlist',
                fontSize: 14,
              ),
            )),
      ),
    );
  }

  Widget _buildLabelText(String label) {
    return BaseText(
      text: label,
      fontWeight: FontWeight.w600,
      fontSize: 15,
    );
  }

  Widget _buildUploadAlbumView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabelText('Album Name'),
        SizedBox(height: getSize(14)),
        _buildAlbumNameTextField(),
        SizedBox(height: getSize(30)),
        _buildLabelText('Select Cover'),
        SizedBox(height: getSize(14)),
        _buildSelectCoverButton(),
        SizedBox(height: getSize(30)),
        _buildLabelText('Upload Playlist'),
        SizedBox(height: getSize(14)),
        _buildUploadPlaylistButton(),
      ],
    );
  }

  Widget _buildAlbumNameTextField() {
    return InputTextField(
      fillColor: ColorConstants.grey2,
      controller: TextEditingController(),
      hintText: 'Enter name of new album',
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: getSize(16), right: getSize(12)),
        child: SvgPicture.asset(getAssetsSVGImg('ic_album1')),
      ),
    );
  }

  Widget _buildPostDescriptionTextField() {
    return InputTextField(
      fillColor: ColorConstants.grey2,
      controller: TextEditingController(),
      hintText: 'Write Here',
    );
  }

  Widget _buildPostButton() {
    return CommonButton(
      onPressed: () {},
      buttonText: 'Post',
    );
  }
}
