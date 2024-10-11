import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/presentation/themes/app_colors.dart';
import 'package:flutter_bill/presentation/widgets/home/chart.dart';
import 'package:intl/intl.dart';

class GraphCard extends StatefulWidget {
  const GraphCard({super.key});

  @override
  State<GraphCard> createState() => _GraphCardState();
}

String todaytextToDisplay = "";
String todayoriginalText = "Today";
String lasttextToDisplay = "";
String lastoriginalText = "Last hour";
String phonetextToDisplay = "";
String phoneoriginalText = "Phone pickups";
String currentTime = "";
String countUpTime = "00:00";
Timer? timer;
Timer? todayTimer;
Timer? lastTimer;
Timer? phoneTimer;
int countUpMinutes = 0;
int todayIndex = 0;
int lastIndex = 0;
int phoneIndex = 0;

class _GraphCardState extends State<GraphCard> {
  @override
  void initState() {
    super.initState();
    updateTime();
    startIncrementalCountdown();
    startTodayTextAnimation();
    startlastTextAnimation();
    startphoneTextAnimation();
  }

  void startTodayTextAnimation() {
    todayTimer = Timer.periodic(const Duration(milliseconds: 250), (timer) {
      if (todayIndex < todayoriginalText.length) {
        setState(() {
          todaytextToDisplay += todayoriginalText[todayIndex];
          todayIndex++;
        });
      } else {
        todayTimer?.cancel();
      }
    });
  }

  void startlastTextAnimation() {
    lastTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (lastIndex < lastoriginalText.length) {
        setState(() {
          lasttextToDisplay += lastoriginalText[lastIndex];
          lastIndex++;
        });
      } else {
        lastTimer?.cancel();
      }
    });
  }

  void startphoneTextAnimation() {
    phoneTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (phoneIndex < phoneoriginalText.length) {
        setState(() {
          phonetextToDisplay += phoneoriginalText[phoneIndex];
          phoneIndex++;
        });
      } else {
        phoneTimer?.cancel();
      }
    });
  }

  void updateTime() {
    final now = DateTime.now();
    currentTime = DateFormat('hh:mm a').format(now.toLocal());
    setState(() {});
  }

  void startIncrementalCountdown() {
    final now = DateTime.now();
    final istTime = now.toLocal();
    final totalCurrentMinutes = istTime.hour * 60 + istTime.minute;

    timer = Timer.periodic(const Duration(microseconds: 500), (timer) {
      if (countUpMinutes < totalCurrentMinutes) {
        countUpMinutes++;
        final String countUp = formatTime(countUpMinutes);
        setState(() {
          countUpTime = countUp;
        });
      } else {
        timer.cancel();
      }

      currentTime = DateFormat('hh:mm a').format(DateTime.now().toLocal());
    });
  }

  String formatTime(int totalMinutes) {
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    return DateFormat('hh:mm')
        .format(DateTime(0, 0, 0, hours, minutes).toLocal());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(w * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SCREEN TIME",
                  style: TextStyle(color: AppColors.black, fontSize: w * 0.04),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.black,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            w * 0.02, h * 0.007, w * 0.02, h * 0.007),
                        child: Text(
                          "Thus,june 20",
                          style: TextStyle(
                            fontSize: w * 0.03,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          // color: AppColors.backgroundcolor,
                          border: Border.all(color: AppColors.black),
                          shape: BoxShape.circle),
                      child: Padding(
                        padding: EdgeInsets.all(w * 0.015),
                        child: const Icon(
                          Icons.calendar_month,
                          color: AppColors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BuildTimeColumn(
                  time: countUpTime,
                  title: Row(
                    children: List.generate(todaytextToDisplay.length, (index) {
                      double opacity = (todayIndex > index) ? 1.0 : 0.0;

                      return AnimatedOpacity(
                        duration: const Duration(milliseconds: 100),
                        opacity: opacity,
                        child: Text(
                          todaytextToDisplay[index],
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: w * 0.03,
                              fontWeight: FontWeight.w400),
                        ),
                      );
                    }),
                  ),
                  fontsize: w * 0.1,
                ),
                SizedBox(
                  width: w * 0.14,
                ),
                Padding(
                  padding: EdgeInsets.only(top: h * 0.025),
                  child: BuildTimeColumn(
                    time: "0:12",
                    title: Row(
                      children:
                          List.generate(lasttextToDisplay.length, (index) {
                        double opacity = (lastIndex > index) ? 1.0 : 0.0;

                        return AnimatedOpacity(
                          duration: const Duration(milliseconds: 100),
                          opacity: opacity,
                          child: Text(
                            lasttextToDisplay[index],
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.w400),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                SizedBox(
                  width: w * 0.14,
                ),
                Padding(
                  padding: EdgeInsets.only(top: h * 0.025),
                  child: BuildTimeColumn(
                    time: "23",
                    title: Row(
                      children:
                          List.generate(phonetextToDisplay.length, (index) {
                        double opacity = (phoneIndex > index) ? 1.0 : 0.0;

                        return AnimatedOpacity(
                          duration: const Duration(milliseconds: 100),
                          opacity: opacity,
                          child: Text(
                            phonetextToDisplay[index],
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.w400),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.05,
            ),
            const DahBoardChart(),
          ],
        ),
      ),
    );
  }
}

class BuildTimeColumn extends StatelessWidget {
  const BuildTimeColumn(
      {super.key, required this.time, required this.title, this.fontsize});
  final String time;
  final Widget title;
  final double? fontsize;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: TextStyle(
              color: AppColors.black,
              fontSize: fontsize ?? w * 0.065,
              fontWeight: FontWeight.w600),
        ),
        title,
      ],
    );
  }
}
