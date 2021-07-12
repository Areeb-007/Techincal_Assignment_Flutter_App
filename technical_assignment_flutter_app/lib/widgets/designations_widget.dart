// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';

Widget designations(BuildContext context, List<Employee> empList) {
  double countOfASE = 0;
  double countOfSE = 0;
  double countOfSSE = 0;
  double countOfIntern = 0;
  double countOfActiveUsers = 0;
  Map<String, double> dataMap = {};
  double calculateActiveUser() {
    for (int i = 0; i < empList.length; i++) {
      if (empList[i].designation == 'ASE') {
        countOfASE++;
      } else if (empList[i].designation == 'SE') {
        countOfSE++;
      } else if (empList[i].designation == 'SSE') {
        countOfSSE++;
      } else if (empList[i].designation == 'Intern') {
        countOfIntern++;
      }
      countOfActiveUsers++;
    }
    dataMap = {
      'ASE': countOfASE,
      'SE': countOfSE,
      'SSE': countOfSSE,
      'Inter': countOfIntern
    };
    return countOfActiveUsers;
  }

  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  return Container(
      child: Center(
          child: SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            child: Text('Total Employees : ${calculateActiveUser()}')),
        PieChart(
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width / 3.2,
          colorList: colorList,
          initialAngleInDegree: 0,
          chartType: ChartType.ring,
          ringStrokeWidth: 32,
          legendOptions: LegendOptions(
            legendShape: BoxShape.circle,
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: true,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            showChartValuesInPercentage: false,
            showChartValuesOutside: false,
            decimalPlaces: 1,
          ),
        )
      ],
    ),
  )));
}
