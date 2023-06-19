

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NoInternetConnectionDialog extends StatelessWidget {
  const NoInternetConnectionDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: Get.width * 0.9,
                constraints: BoxConstraints(minHeight: Get.height * 0.25),
                color: Colors.white,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: constraints.minHeight * 0.05),
                              Text("Uh Oh!",
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.grey[850],
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w500))),
                              SizedBox(height: constraints.minHeight * 0.05),
                              Text(
                                  "Please make sure you have an active internet connection.",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      textStyle: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 15.0,
                                              height: 1.5,
                                              fontWeight: FontWeight.w400)))),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: Get.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(width: 15.0),
                                    Expanded(
                                      child: SizedBox(
                                        height: 55.0,
                                        child: ElevatedButton(
                                            onPressed: () => Get.back(),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.yellow),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)))),
                                            child: Text(
                                              "Got it",
                                              style: GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white)),
                                            )),
                                      ),
                                    ),
                                    const SizedBox(width: 15.0),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Text("Tap anywhere to dismiss",
                style:
                    GoogleFonts.montserrat(color: Colors.white, fontSize: 11))
          ],
        ),
      ),
    );
  }
}
