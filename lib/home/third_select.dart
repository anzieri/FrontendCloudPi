import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:remotefilesystem/home/otherhome.dart';

void main() {
  runApp(MaterialApp(
    home: Pagey(),
    debugShowCheckedModeBanner: false,
  ));
}

class ThirdSelect extends StatelessWidget {
  const ThirdSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height -
            80, // Adjust this value as needed
      ),
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: HistogramChart(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TrendChart(),
                ),
              ),
            ),
          ],
        ),
      
    );
  }
}

class HistogramChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: 8, color: Colors.lightBlueAccent)
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: 10, color: Colors.lightBlueAccent)
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: 14, color: Colors.lightBlueAccent)
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                toY: 15, color: Colors.lightBlueAccent)
            ],
          ),
          BarChartGroupData(
            x: 4,
            barRods: [
              BarChartRodData(
                toY: 13, color: Colors.lightBlueAccent)
            ],
          ),
          BarChartGroupData(
            x: 5,
            barRods: [
              BarChartRodData(
                toY: 10, color: Colors.lightBlueAccent)
            ],
          ),
        ],
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                if (value == 0) {
                  return Text('0');
                } else if (value == 5) {
                  return Text('5');
                } else if (value == 10) {
                  return Text('10');
                } else if (value == 15) {
                  return Text('15');
                } else {
                  return Text('');
                }
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                switch (value.toInt()) {
                  case 0:
                    return Text('A');
                  case 1:
                    return Text('B');
                  case 2:
                    return Text('C');
                  case 3:
                    return Text('D');
                  case 4:
                    return Text('E');
                  case 5:
                    return Text('F');
                  default:
                    return Text('');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class TrendChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                if (value == 0) {
                  return Text('0');
                } else if (value == 5) {
                  return Text('5');
                } else if (value == 10) {
                  return Text('10');
                } else if (value == 15) {
                  return Text('15');
                } else {
                  return Text('');
                }
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                switch (value.toInt()) {
                  case 0:
                    return Text('Jan');
                  case 1:
                    return Text('Feb');
                  case 2:
                    return Text('Mar');
                  case 3:
                    return Text('Apr');
                  case 4:
                    return Text('May');
                  case 5:
                    return Text('Jun');
                  default:
                    return Text('');
                }
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 1),
              const FlSpot(1, 3),
              FlSpot(2, 10),
              FlSpot(3, 7),
              FlSpot(4, 12),
              FlSpot(5, 13),
            ],
            isCurved: true,
            color: Colors.blue,
            barWidth: 4,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.3),
                  Colors.blue.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}