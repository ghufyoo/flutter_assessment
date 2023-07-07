import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


extension LoopList<T> on List {
  T loop(int index) => this[index % length];
}

class ImageView extends StatefulWidget {
  ImageView(
      {Key? key,
      required this.imgList,
      required this.index,
      required this.projectName})
      : pageController = PageController(initialPage: index);
  final PageController pageController;
  List<File> imgList;
  final int index;
  final String projectName;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late int index = widget.index;
  int count = 0;
  final PhotoViewController _photoViewController = PhotoViewController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.projectName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400))),
              Text("${index + 1}/${widget.imgList.length}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400))),
            ],
          ),
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
                shadows: [
                  Shadow(
                      color: Colors.grey, offset: Offset(1, 1), blurRadius: 2)
                ],
              )),
        ),
        body: Stack(
          children: [
            PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                pageController: widget.pageController,
                itemCount: 100,
                gaplessPlayback: true,
                allowImplicitScrolling: true,
                wantKeepAlive: true,
                loadingBuilder: (context, event) {
                  if (event == null) {
                    return Container(
                      color: Colors.black,
                      child: const Center(
                        child: CupertinoActivityIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }

                  final value = event.cumulativeBytesLoaded /
                      (event.expectedTotalBytes ?? event.cumulativeBytesLoaded);

                  final percentage = (100 * value).floor();
                  return Center(
                    child: Text("$percentage%"),
                  );
                },
                builder: (context, index) {
                  final img = widget.imgList[index % widget.imgList.length];
                  return PhotoViewGalleryPageOptions(
                      gestureDetectorBehavior: HitTestBehavior.opaque,
                      disableGestures: false,
                      imageProvider: FileImage(img),
                      // controller: _photoViewController,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.contained * 4,
                      heroAttributes: PhotoViewHeroAttributes(tag: index));
                },
                onPageChanged: (indexx) {
                  setState(() {
                    index = indexx % widget.imgList.length;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
