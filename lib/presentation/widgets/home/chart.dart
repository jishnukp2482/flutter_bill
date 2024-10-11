import 'package:flutter/material.dart';
import 'package:flutter_bill/presentation/themes/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DahBoardChart extends StatelessWidget {
  const DahBoardChart({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: h * 0.2,
      child: SfCartesianChart(
          primaryXAxis: const CategoryAxis(),
          primaryYAxis: const NumericAxis(isVisible: false),
          series: <CartesianSeries>[
            SplineAreaSeries<TimeData, String>(
                gradient: LinearGradient(
                  colors: [
                    AppColors.green,
                    AppColors.white.withOpacity(0.5),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                dataSource: <TimeData>[
                  TimeData('8AM', 6),
                  TimeData('10AM', 4),
                  TimeData('12PM', 8),
                  TimeData('2PM', 4),
                  TimeData('4PM', 7),
                  TimeData('6PM', 5),
                  TimeData('8PM', 6),
                ],
                xValueMapper: (TimeData sales, _) => sales.xtime,
                yValueMapper: (TimeData sales, _) => sales.ytime)
          ]),
    );
  }
}

class TimeData {
  TimeData(this.xtime, this.ytime);
  final String xtime;
  final num ytime;
}
