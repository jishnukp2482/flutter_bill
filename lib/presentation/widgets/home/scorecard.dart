import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bill/entities/socialmedia_modal.dart';
import 'package:flutter_bill/presentation/themes/app_assets.dart';
import 'package:flutter_bill/presentation/themes/app_colors.dart';

class ScoreCard extends StatefulWidget {
  const ScoreCard({super.key});

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> with TickerProviderStateMixin {
  late AnimationController starcontroller;
  String focustextToDisplay = "";
  String focusoriginalText = "FOCUS SCORE";
  String goodtextToDisplay = "";
  String goodoriginalText = "Good";
  String messageTextToDisplay1 = "";
  String messageTextToDisplay2 = "";
  String messageOriginalText1 = "Way to go!, Your screen time this week";
  String messageOriginalText2 = "is 7% less than last week";
  int messageTextIndex1 = 0;
  int messageTextIndex2 = 0;

  int focusIndex = 0;
  int goodIndex = 0;
  Timer? focusTimer;
  Timer? goodTimer;
  Timer? messageTimer1;
  Timer? messageTimer2;
  late AnimationController iconController;
  late Animation<double> iconScale;
  @override
  void initState() {
    super.initState();
    starcontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    iconController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: iconController,
        curve: Curves.easeOut,
      ),
    );

    starcontroller.forward();
    iconController.forward();
    startWritingAnimation();
    startGoodTextAnimation();
    startMessageAnimation1();
    startMessageAnimation2();
  }

  @override
  void dispose() {
    starcontroller.dispose();
    focusTimer?.cancel();
    super.dispose();
  }

  void startWritingAnimation() {
    focusTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (focusIndex < focusoriginalText.length) {
        setState(() {
          focustextToDisplay += focusoriginalText[focusIndex];
          focusIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void startGoodTextAnimation() {
    goodTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (goodIndex < goodoriginalText.length) {
        setState(() {
          goodtextToDisplay += goodoriginalText[goodIndex];
          goodIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void startMessageAnimation1() {
    messageTimer1 = Timer.periodic(const Duration(microseconds: 300), (timer) {
      if (messageTextIndex1 < messageOriginalText1.length) {
        setState(() {
          messageTextToDisplay1 += messageOriginalText1[messageTextIndex1];
          messageTextIndex1++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void startMessageAnimation2() {
    messageTimer2 = Timer.periodic(const Duration(microseconds: 300), (timer) {
      if (messageTextIndex2 < messageOriginalText2.length) {
        setState(() {
          messageTextToDisplay2 += messageOriginalText2[messageTextIndex2];
          messageTextIndex2++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Card(
      elevation: 0,
      color: AppColors.appYellow,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(w * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(focustextToDisplay.length, (index) {
                double opacity = (focusIndex > index) ? 1.0 : 0.0;

                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: opacity,
                  child: Text(
                    focustextToDisplay[index],
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: w * 0.04,
                    ),
                  ),
                );
              }),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "8.5",
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: w * 0.08,
                              fontWeight: FontWeight.bold),
                        ),
                        RotationTransition(
                          turns: Tween(begin: 0.0, end: 1.0)
                              .animate(starcontroller),
                          child: Container(
                            height: h * 0.04,
                            width: w * 0.1,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(AppAssets.star),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children:
                          List.generate(goodtextToDisplay.length, (index) {
                        double opacity = (goodIndex > index) ? 1.0 : 0.0;

                        return AnimatedOpacity(
                          duration: const Duration(milliseconds: 100),
                          opacity: opacity,
                          child: Text(
                            goodtextToDisplay[index],
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: w * 0.03,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     ScaleTransition(
                  scale: iconScale,
                 child:    SocialMeidaMenu(),
                     ),
                    Text(
                      "Most Used",
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: w * 0.03,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ScaleTransition(
                  scale: iconScale,
                  child: Icon(
                    Icons.screen_share_outlined,
                    color: AppColors.black,
                    size: w * 0.07,
                  ),
                ),
                SizedBox(
                  width: w * 0.25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:
                          List.generate(messageTextToDisplay1.length, (index) {
                        double opacity =
                            (messageTextIndex1 > index) ? 1.0 : 0.0;

                        return AnimatedOpacity(
                          duration: const Duration(milliseconds: 100),
                          opacity: opacity,
                          child: Text(
                            messageTextToDisplay1[index],
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }),
                    ),
                    Row(
                      children:
                          List.generate(messageTextToDisplay2.length, (index) {
                        double opacity =
                            (messageTextIndex2 > index) ? 1.0 : 0.0;

                        return AnimatedOpacity(
                          duration: const Duration(milliseconds: 100),
                          opacity: opacity,
                          child: Text(
                            messageTextToDisplay2[index],
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SocialMeidaMenu extends StatelessWidget {
  SocialMeidaMenu({super.key});
  final socialMediaDataList = <SocilaMediaModal>[
    SocilaMediaModal(id: 0, imge: AppAssets.clickup),
    SocilaMediaModal(id: 1, imge: AppAssets.wtsp),
    SocilaMediaModal(id: 2, imge: AppAssets.inst),
    SocilaMediaModal(id: 3, imge: AppAssets.basket),
    SocilaMediaModal(id: 4, imge: AppAssets.yt),
  ];
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SizedBox(
        height: h * 0.055,
        width: w * 0.38,
        child: Stack(
          children: List.generate(socialMediaDataList.length, (index) {
            return Positioned(
              left: index * (w * 0.07),
              top: h * 0.005,
              child:
                  SocialMediaView(socilaMediaModal: socialMediaDataList[index]),
            );
          }),
        ));
  }
}

class SocialMediaView extends StatelessWidget {
  const SocialMediaView({super.key, required this.socilaMediaModal});
  final SocilaMediaModal socilaMediaModal;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
        height: h * 0.05,
        width: w * 0.1,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
          image: DecorationImage(
              image: AssetImage(socilaMediaModal.imge), fit: BoxFit.cover),
        ));
  }
}
