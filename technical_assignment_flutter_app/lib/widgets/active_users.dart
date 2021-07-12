import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';

Widget acticeUsers(BuildContext context, List<Employee> empList) {
  double countOfActiveUsers = 0;
  Map<String, double> dataMap = {};
  double calculateActiveUser() {
    for (int i = 0; i < empList.length; i++) {
      if (empList[i].isActive) {
        countOfActiveUsers++;
      }
    }
    dataMap = {
      'Inactive Users': empList.length.toDouble() - countOfActiveUsers,
      'Active Users': countOfActiveUsers,
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
            child: Text('Total Actice Users : ${calculateActiveUser()}')),
        Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            child: Text('Total Users are : ${empList.length}')),
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
