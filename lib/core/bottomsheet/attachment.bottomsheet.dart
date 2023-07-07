import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AttachmentBottomsheet extends StatelessWidget {
  const AttachmentBottomsheet(
      {super.key, required this.needFromFile, required this.multiple});
  final bool needFromFile;
  final bool multiple;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SizedBox(
        child: Wrap(
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.remove,
                  color: Colors.black26,
                  size: 30,
                )
              ],
            ),
            Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                      width: 1.0, color: Color.fromARGB(129, 179, 179, 179)),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                    onTap: () async {
                      File data = await handleImageSelection(true);
                      if (data.path == "") {
                        return Get.back(result: null);
                      }
                      Get.back(result: data);
                    },
                    title: Text(
                      'Camera',
                      style: GoogleFonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.7),
                    ),
                    trailing: Icon(
                      Icons.camera_enhance_rounded,
                      color: Colors.blueAccent.shade200,
                    )),
              ),
            ),
            Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                      width: 1.0, color: Color.fromARGB(129, 179, 179, 179)),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                    onTap: () async {
                      if (multiple) {
                        List<File> data =
                            await handleMultipleImageSelection(false);
                        if (data.isEmpty) {
                          return Get.back(result: null);
                        }
                        Get.back(result: data);
                      } else {
                        File data = await handleImageSelection(false);
                        if (data.path == "") {
                          return Get.back(result: null);
                        }
                        Get.back(result: data);
                      }
                    },
                    title: Text(
                      'Photo & Video',
                      style: GoogleFonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.7),
                    ),
                    trailing: Icon(
                      Icons.perm_media_rounded,
                      color: Colors.blueAccent.shade200,
                    )),
              ),
            ),
            needFromFile
                ? Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                            width: 1.0,
                            color: Color.fromARGB(129, 179, 179, 179)),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListTile(
                          onTap: () async {
                            File data = await handleFileSelection();
                            if (data.path == "") {
                              return Get.back(result: null);
                            }
                            Get.back(result: data);
                          },
                          title: Text(
                            'File',
                            style: GoogleFonts.lato(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.7),
                          ),
                          trailing: Icon(
                            Icons.file_copy,
                            color: Colors.blueAccent.shade200,
                          )),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Future<File> handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result == null) return File('');
    final filePath = result.files.single.path!;
    final file = File(filePath);
    return file;
  }

  Future<File> handleImageSelection(bool fromCamera) async {
    await Permission.camera.request();
    var status = await Permission.camera.status;
    if (status.isDenied) {
      Get.snackbar("Oops camera access denied",
          "Please enable the camera access in the settings.",
          borderRadius: 5,
          barBlur: 10,
          shouldIconPulse: true,
          icon: const Icon(
            Icons.warning,
            color: Colors.red,
          ),
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM);
      return File("");
    } else {
      final img = await ImagePicker().pickImage(
        imageQuality: 60,
        maxWidth: 1440,
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      );
      if (img == null) return File('');
      final result =
          await FlutterNativeImage.compressImage(img.path, quality: 70);
      final file = File(result.path);
      return file;
    }
  }

  Future<List<File>> handleMultipleImageSelection(bool fromCamera) async {
    final img = await ImagePicker().pickMultiImage(
      imageQuality: 60,
      maxWidth: 1440,
    );
    if (img.isEmpty) return [];
    List<File> result = [];
    for (var element in img) {
      result.add(
          await FlutterNativeImage.compressImage(element.path, quality: 70));
    }
    return result;
  }
}
