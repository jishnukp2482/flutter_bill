import 'package:flutter/material.dart';
import 'package:flutter_bill/presentation/routes/app_pages.dart';
import 'package:flutter_bill/presentation/themes/app_colors.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<String> texts = [
    "Goal-Setting",
    "Dedication",
    "Workflow",
    "Efficiency",
    "Concentration",
    "Discipline",
    "Balance",
    "Time Manager",
    "Performance",
    "Focus"
  ];

  int activeTextIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )
      ..addListener(() {
        setState(() {
          double currentPosition =
              _controller.value * (MediaQuery.of(context).size.height - 180);

          for (int i = 0; i < texts.length; i++) {
            double positionThreshold = (i + 1) *
                (MediaQuery.of(context).size.height - 200) /
                texts.length;
            if (currentPosition >= positionThreshold) {
              activeTextIndex = i;
            }
          }

          if (currentPosition >= (MediaQuery.of(context).size.height - 200)) {
            activeTextIndex = texts.length - 1;
          }
        });
      })
      ..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkOrange,
        body: Stack(
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                double value = _animation.value;
                double yOffset = value * (h - 200);
                double rotationAngle = value * 3.14;

                return Positioned(
                  left: 0,
                  top: yOffset,
                  child: Transform.rotate(
                    angle: rotationAngle,
                    child: CustomPaint(
                      size: const Size(100, 100),
                      painter: StarPainter(),
                    ),
                  ),
                );
              },
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(texts.length, (index) {
                  return buildText(texts[index], w, index);
                }),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppPages.homePage);
            },
            child: Container(
                height: h * 0.08,
                decoration: BoxDecoration(
                    color: AppColors.darkOrange,
                    border: Border.all(color: AppColors.black),
                    borderRadius: BorderRadius.circular(60)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Text(
                        "Get Started",
                        style: TextStyle(
                            fontSize: w * 0.04,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      const Icon(Icons.arrow_forward_ios_outlined),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget buildText(String text, double w, int index) {
    Color textColor = AppColors.black.withOpacity(0.2);

    if (index == activeTextIndex) {
      textColor = AppColors.black;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: w * 0.123,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = AppColors.appYellow
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6863682, size.height * -0.9557429);
    path_0.lineTo(size.width * 0.4240078, size.height * -0.2883000);
    path_0.lineTo(size.width * 0.1767968, size.height * 0.0555571);
    path_0.lineTo(size.width * -0.3227677, size.height * 0.3926714);
    path_0.lineTo(size.width * 0.1818109, size.height * 0.7163143);
    path_0.lineTo(size.width * 0.4341110, size.height * 1.0601429);
    path_0.lineTo(size.width * 0.6813968, size.height * 1.7411429);
    path_0.lineTo(size.width * 0.9286292, size.height * 1.0668714);
    path_0.lineTo(size.width * 1.1909789, size.height * 0.7298286);
    path_0.lineTo(size.width * 1.6905007, size.height * 0.3859000);
    path_0.lineTo(size.width * 1.1858899, size.height * 0.0689714);
    path_0.lineTo(size.width * 0.9386682, size.height * -0.2883000);
    path_0.lineTo(size.width * 0.6863682, size.height * -0.9557429);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = AppColors.appYellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
