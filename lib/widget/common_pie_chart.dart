import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../app/app_colors.dart';

class CommonPieChart extends StatelessWidget {
  final Map<String, double> dataMap;
  final List<dynamic> machineStatusList;

  const CommonPieChart(
      {super.key, required this.dataMap, required this.machineStatusList});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true, // You can set this dynamically if needed
      child: dataMap.isNotEmpty // Ensure dataMap is not empty
          ? PieChart(
              animationDuration: const Duration(milliseconds: 800),
              dataMap: dataMap,
              chartType: ChartType.disc,
              chartRadius: 120,
              colorList: const [
                Colors.blue,
                Colors.green,
                Colors.orange,
                Colors.red,
                Colors.amber,
              ],
              initialAngleInDegree: 0,
              chartLegendSpacing: 10,
              ringStrokeWidth: 24,
              legendOptions: const LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                decimalPlaces: 0,
                chartValueStyle: TextStyle(
                  fontSize: 15,
                  color: AppColors.colorBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : const SizedBox(
              height: 120,
              child: Center(
                child: Text(
                  'No chart available...', // Display message if dataMap is empty
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
    );
  }
}
