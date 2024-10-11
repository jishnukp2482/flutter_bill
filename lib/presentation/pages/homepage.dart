import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bill/presentation/routes/app_pages.dart';
import 'package:flutter_bill/presentation/themes/app_assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bill/presentation/themes/app_colors.dart';
import 'package:flutter_bill/presentation/widgets/home/graph_card.dart';
import 'package:flutter_bill/presentation/widgets/home/scorecard.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController textController;
  late Animation<double> textAnimation;
  late AnimationController profileController;
  late Animation<double> profileScale;
  String welcometextToDisplay = "";
  String welcomeoriginalText = "Welcome back";
  String nametextToDisplay = "";
  String nameoriginalText = "Celestle";
  int welcomeIndex = 0;
  int nameIndex = 0;
  Timer? welcomeTimer;
  Timer? nameTimer;
  bool isVisible = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isVisible = true;
      });
      textController.forward();
    });
    textController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    textAnimation = CurvedAnimation(
      parent: textController,
      curve: Curves.easeOut,
    );
    profileController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    profileScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: profileController,
        curve: Curves.easeOut,
      ),
    );
    profileController.forward();
    startWelcomeAnimation();
    startnameAnimation();
  }

  @override
  void dispose() {
    textController.dispose();
    profileController.dispose();
    super.dispose();
  }

  void startWelcomeAnimation() {
    welcomeTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (welcomeIndex < welcomeoriginalText.length) {
        setState(() {
          welcometextToDisplay += welcomeoriginalText[welcomeIndex];
          welcomeIndex++;
        });
      } else {
        welcomeTimer?.cancel();
      }
    });
  }

  void startnameAnimation() {
    nameTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (nameIndex < nameoriginalText.length) {
        setState(() {
          nametextToDisplay += nameoriginalText[nameIndex];
          nameIndex++;
        });
      } else {
        nameTimer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundcolor,
        leading: Padding(
          padding: EdgeInsets.only(left: w * 0.02, top: h * 0.01),
          child: ScaleTransition(
            scale: profileScale,
            child: CircleAvatar(
              backgroundColor: AppColors.backgroundcolor,
              radius: w * 0.05,
              backgroundImage: const CachedNetworkImageProvider(
                AppAssets.profileimg,
              ),
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: h * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(welcometextToDisplay.length, (index) {
                  double opacity = (welcomeIndex > index) ? 1.0 : 0.0;

                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 100),
                    opacity: opacity,
                    child: Text(
                      welcometextToDisplay[index],
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: w * 0.03,
                      ),
                    ),
                  );
                }),
              ),
              Row(
                children: List.generate(nametextToDisplay.length, (index) {
                  double opacity = (nameIndex > index) ? 1.0 : 0.0;

                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 100),
                    opacity: opacity,
                    child: Text(
                      nametextToDisplay[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        fontSize: w * 0.05,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: w * 0.02, top: h * 0.01),
            child: ScaleTransition(
              scale: profileScale,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.compare_arrows,
                    color: AppColors.black,
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: w * 0.02, top: h * 0.01),
            child: ScaleTransition(
              scale: profileScale,
              child: IconButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppPages.billingPage);
                  },
                  icon: const Icon(
                    Icons.receipt,
                    color: AppColors.black,
                  )),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              left: 0,
              right: 0,
              bottom: isVisible ? h * 0.35 : -h * 0.35,
              child: const GraphCard()),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeOut,
            left: 0,
            right: 0,
            bottom: isVisible ? h * 0.145 : -h * 0.3,
            child: const ScoreCard(),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOut,
            left: w * 0.02,
            right: w * 0.02,
            bottom: isVisible ? h * 0.055 : -h * 0.3,
            child: Container(
              height: h * 0.09,
              decoration: const BoxDecoration(
                color: AppColors.darkOrange,
                borderRadius: BorderRadius.all(Radius.circular(60)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: textAnimation,
                    child: Text(
                      "Start Focus Session",
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  ScaleTransition(
                    scale: textAnimation,
                    child: Text(
                      "Last session: 2 hours ago",
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: w * 0.03,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
