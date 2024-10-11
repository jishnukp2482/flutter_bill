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

    Paint paintFill0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4942083, size.height * -1.0906857);
    path_0.lineTo(size.width * 0.5045083, size.height * -0.7990286);
    path_0.lineTo(size.width * 0.5240917, size.height * -0.5506286);
    path_0.lineTo(size.width * 0.5815917, size.height * -0.2862429);
    path_0.lineTo(size.width * 0.6454583, size.height * -0.0166714);
    path_0.lineTo(size.width * 0.7974250, size.height * 0.2414857);
    path_0.lineTo(size.width * 0.9740500, size.height * 0.2561714);
    path_0.lineTo(size.width * 1.1411083, size.height * 0.2547000);
    path_0.lineTo(size.width * 1.2924750, size.height * 0.2751000);
    path_0.lineTo(size.width * 1.4342583, size.height * 0.2522000);
    path_0.lineTo(size.width * 1.2831917, size.height * 0.3400000);
    path_0.lineTo(size.width * 1.1320000, size.height * 0.3791143);
    path_0.lineTo(size.width * 0.9746250, size.height * 0.4453571);
    path_0.lineTo(size.width * 0.8172167, size.height * 0.5438286);
    path_0.lineTo(size.width * 0.6542083, size.height * 0.8101714);
    path_0.lineTo(size.width * 0.5918000, size.height * 1.0593000);
    path_0.lineTo(size.width * 0.5327167, size.height * 1.3243857);
    path_0.lineTo(size.width * 0.5050417, size.height * 1.5949571);
    path_0.lineTo(size.width * 0.5027500, size.height * 1.8758714);
    path_0.lineTo(size.width * 0.4735833, size.height * 1.5952143);
    path_0.lineTo(size.width * 0.3751417, size.height * 1.3366429);
    path_0.lineTo(size.width * 0.3617000, size.height * 1.0773571);
    path_0.lineTo(size.width * 0.3609750, size.height * 0.8071429);
    path_0.lineTo(size.width * 0.1899583, size.height * 0.5384714);
    path_0.lineTo(size.width * 0.0102833, size.height * 0.5344714);
    path_0.lineTo(size.width * -0.1377750, size.height * 0.5574143);
    path_0.lineTo(size.width * -0.3049667, size.height * 0.5209857);
    path_0.lineTo(size.width * -0.4563083, size.height * 0.5222286);
    path_0.lineTo(size.width * -0.3022083, size.height * 0.3859714);
    path_0.lineTo(size.width * -0.1354333, size.height * 0.2925143);
    path_0.lineTo(size.width * 0.0315500, size.height * 0.2749143);
    path_0.lineTo(size.width * 0.1733667, size.height * 0.2414857);
    path_0.lineTo(size.width * 0.3018083, size.height * -0.0137571);
    path_0.lineTo(size.width * 0.3388917, size.height * -0.2787429);
    path_0.lineTo(size.width * 0.4295083, size.height * -0.5606286);
    path_0.lineTo(size.width * 0.4634667, size.height * -0.8095143);
    path_0.lineTo(size.width * 0.4942083, size.height * -1.0906857);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
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
