import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../app/app_colors.dart';
import '../utility/preference_utils.dart';

class CommonPieChartWithTitle extends StatelessWidget {
  final Map<String, double> dataMap;
  final List<Color> colorList;
  final double chartRadius;
  final double chartLegendSpacing;
  final String title;

  const CommonPieChartWithTitle({
    super.key,
    required this.dataMap,
    required this.colorList,
    required this.chartRadius,
    required this.chartLegendSpacing,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 195,
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 34,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.purpleSwatch,
              // Change to your preferred color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorWhite,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: PieChart(
                  animationDuration: const Duration(milliseconds: 800),
                  dataMap: dataMap,
                  chartType: ChartType.disc,
                  chartRadius: chartRadius,
                  colorList: colorList,
                  initialAngleInDegree: 0,
                  chartLegendSpacing: chartLegendSpacing,
                  ringStrokeWidth: 32,
                  legendOptions: LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: PreferenceUtils.getIsTheme()
                            ? AppColors.colorBlack
                            : AppColors.colorBlack),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: false,
                    showChartValues: true,
                    showChartValuesInPercentage: false,
                    showChartValuesOutside: false,
                    decimalPlaces: 0,
                    chartValueStyle: TextStyle(
                      inherit: false,
                      fontSize: 15,
                      color: PreferenceUtils.getIsTheme()
                          ? AppColors.colorWhite
                          : AppColors.colorWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
