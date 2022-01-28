import 'package:crypto_info/common/ui/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyChart extends StatelessWidget {
  const CurrencyChart({required List<FlSpot> spots, Key? key})
      : _spots = spots,
        super(key: key);

  final List<FlSpot> _spots;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.h,
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          gridData: FlGridData(show: false),
          lineTouchData: LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              dotData: FlDotData(show: false),
              barWidth: 1.4,
              colorStops: [0.0, 0.2, 0.8, 1.0],
              colors: [
                AppColors.chart.withOpacity(0),
                AppColors.chart.withOpacity(1),
                AppColors.chart.withOpacity(1),
                AppColors.chart.withOpacity(0),
              ],
              spots: _spots,
              belowBarData: BarAreaData(
                show: true,
                gradientFrom: const Offset(0, 1),
                gradientTo: const Offset(0, -1),
                colors: [
                  AppColors.chart.withOpacity(0),
                  AppColors.chart.withOpacity(0.35),
                ],
              ),
            ),
          ],
        ),
        swapAnimationDuration: const Duration(milliseconds: 250),
      ),
    );
  }
}
