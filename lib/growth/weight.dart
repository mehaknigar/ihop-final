import 'package:baba_spira/Consts/color.dart';
import 'package:baba_spira/functions/roundAndInc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/growth.dart';

class Weight extends StatefulWidget {
  final List<Growth> list;
  final DateTime db;
  Weight(this.list, this.db);
  @override
  State<StatefulWidget> createState() => WeightState();
}

class WeightState extends State<Weight> {
  List<FlSpot> pointData = [];
  List<FlSpot> minDatadDay = [];
  List<FlSpot> minDataMonth = [
    FlSpot(0, 2.5),
    FlSpot(1, 3.4),
    FlSpot(2, 4.4),
    FlSpot(3, 5.1),
    FlSpot(4, 5.6),
    FlSpot(5, 6.1),
    FlSpot(6, 6.4),
    FlSpot(7, 6.7),
    FlSpot(8, 7.0),
    FlSpot(9, 7.2),
    FlSpot(10, 7.5),
    FlSpot(11, 7.7),
    FlSpot(12, 7.8),
    FlSpot(13, 8.0),
    FlSpot(14, 8.2),
    FlSpot(15, 8.4),
    FlSpot(16, 8.5),
    FlSpot(17, 8.7),
    FlSpot(18, 8.9),
    FlSpot(19, 9.0),
    FlSpot(29, 9.2),
  ];
  List<FlSpot> maxDataMonth = [];

  @override
  void initState() {
    super.initState();
  }

  void createList() {
    pointData.clear();

    List listMaxX = maxX();

    if (widget.list.length != 0) {
      for (var item in widget.list) {
        double x;
        double days = item.date.difference(widget.db).inDays.toDouble();

        switch (listMaxX[1]) {
          case 'Days':
            x = days;
            break;
          case 'Weeks':
            x = days / 7;
            break;
          case 'Months':
            x = listMaxX[0] > 40
                ? (days / 30.4167) / 3
                : listMaxX[0] > 20 ? (days / 30.4167) / 2 : days / 30.4167;
            break;
        }

        pointData.add(
          FlSpot(x, maxY() > 20 ? (item.weight) / 2 : item.weight),
        );
      }
    }
  }

  List maxX() {
    double maxR;
    String scale;
    if (widget.list.length != 0) {
      double max;
      bool first = true;
      int days;

      for (var item in widget.list) {
        days = item.date.difference(widget.db).inDays;

        if (first) {
          max = days.toDouble();
        } else {
          if (days.toDouble() > max) max = days.toDouble();
        }
      }

      if (days >= 0 && days <= 14) {
        scale = 'Days';
        max = days.toDouble();
      } else if (days <= 60) {
        scale = 'Weeks';
        double weeks = days / 7;
        max = weeks;
      } else {
        scale = 'Months';
        double months = days / 30.4167;
        max = months;
      }

      maxR = max.roundToDouble();

      if (max > maxR) maxR++;
    } else
      maxR = 5;

    return [maxR, scale];
  }

  double maxY() {
    double maxR;
    if (widget.list.length != 0) {
      double max = widget.list[0].weight;

      for (var item in widget.list) {
        if (item.weight > max) max = item.weight;
      }

      maxR = roundAndInc(max);
    } else
      maxR = 5;

    return maxR;
  }

  @override
  Widget build(BuildContext context) {
    createList();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 15),
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: const [
                        Color(0xffF5F5F5),
                        Color(0xffF5F5F5),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 16.0, left: 6.0),
                          child: LineChart(
                            chartData(),
                            swapAnimationDuration:
                                const Duration(milliseconds: 250),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          maxX()[1] != null ? maxX()[1] : 'Days',
                          style: TextStyle(color: Color(0xff75729e)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LineChartData chartData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xffB9B9B9),
            strokeWidth: 1,
          );
        },
        drawVerticalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xffB9B9B9),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            if (maxX()[0] > 40) {
              switch (value.toInt()) {
                case 0:
                  return '0';
                case 1:
                  return '3';
                case 2:
                  return '6';
                case 3:
                  return '9';
                case 4:
                  return '12';
                case 5:
                  return '15';
                case 6:
                  return '18';
                case 7:
                  return '21';
                case 8:
                  return '24';
                case 9:
                  return '27';
                case 10:
                  return '30';
                case 11:
                  return '33';
                case 12:
                  return '36';
                case 13:
                  return '39';
                case 14:
                  return '42';
                case 15:
                  return '45';
                case 16:
                  return '48';
                case 17:
                  return '51';
                case 18:
                  return '54';
                case 19:
                  return '57';
                case 20:
                  return '60';
              }
            } else if (maxX()[0] > 20) {
              switch (value.toInt()) {
                case 0:
                  return '0';
                case 1:
                  return '2';
                case 2:
                  return '4';
                case 3:
                  return '6';
                case 4:
                  return '8';
                case 5:
                  return '10';
                case 6:
                  return '12';
                case 7:
                  return '14';
                case 8:
                  return '16';
                case 9:
                  return '18';
                case 10:
                  return '20';
                case 11:
                  return '22';
                case 12:
                  return '24';
                case 13:
                  return '26';
                case 14:
                  return '28';
                case 15:
                  return '30';
                case 16:
                  return '32';
                case 17:
                  return '34';
                case 18:
                  return '36';
                case 19:
                  return '38';
                case 20:
                  return '40';
              }
            } else {
              switch (value.toInt()) {
                case 0:
                  return '0';
                case 1:
                  return '1';
                case 2:
                  return '2';
                case 3:
                  return '3';
                case 4:
                  return '4';
                case 5:
                  return '5';
                case 6:
                  return '6';
                case 7:
                  return '7';
                case 8:
                  return '8';
                case 9:
                  return '9';
                case 10:
                  return '10';
                case 11:
                  return '11';
                case 12:
                  return '12';
                case 13:
                  return '13';
                case 14:
                  return '14';
                case 15:
                  return '15';
                case 16:
                  return '16';
                case 17:
                  return '17';
                case 18:
                  return '18';
                case 19:
                  return '19';
                case 20:
                  return '20';
              }
            }
            return '';
          },
          /* (value) => xAxisData(
            value.toInt(),
          ), */
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            if (maxY() > 20) {
              switch (value.toInt()) {
                case 0:
                  return '0 kg';
                case 1:
                  return '2 kg';
                case 2:
                  return '4 kg';
                case 3:
                  return '6 kg';
                case 4:
                  return '8 kg';
                case 5:
                  return '10 kg';
                case 6:
                  return '12 kg';
                case 7:
                  return '14 kg';
                case 8:
                  return '16 kg';
                case 9:
                  return '18 kg';
                case 10:
                  return '20 kg';
                case 11:
                  return '22 kg';
                case 12:
                  return '24 kg';
                case 13:
                  return '26 kg';
                case 14:
                  return '28 kg';
                case 15:
                  return '30 kg';
                case 16:
                  return '32 kg';
                case 17:
                  return '34 kg';
                case 18:
                  return '36 kg';
                case 19:
                  return '38 kg';
                case 20:
                  return '40 kg';
              }
            } else {
              switch (value.toInt()) {
                case 0:
                  return '0 kg';
                case 1:
                  return '1 kg';
                case 2:
                  return '2 kg';
                case 3:
                  return '3 kg';
                case 4:
                  return '4 kg';
                case 5:
                  return '5 kg';
                case 6:
                  return '6 kg';
                case 7:
                  return '7 kg';
                case 8:
                  return '8 kg';
                case 9:
                  return '9 kg';
                case 10:
                  return '10 kg';
                case 11:
                  return '11 kg';
                case 12:
                  return '12 kg';
                case 13:
                  return '13 kg';
                case 14:
                  return '14 kg';
                case 15:
                  return '15 kg';
                case 16:
                  return '16 kg';
                case 17:
                  return '17 kg';
                case 18:
                  return '18 kg';
                case 19:
                  return '19 kg';
                case 20:
                  return '20 kg';
              }
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: blueGreen,
            width: 4,
          ),
          left: BorderSide(
            color: blueGreen,
            width: 4,
          ),
          right: BorderSide(
            color: blueGreen,
          ),
          top: BorderSide(
            color: blueGreen,
          ),
        ),
      ),
      minX: 0,
      maxX: maxX()[0] > 40
          ? roundAndInc(maxX()[0] / 3)
          : maxX()[0] > 20 ? roundAndInc(maxX()[0] / 2) : maxX()[0],
      maxY: maxY() > 20 ? roundAndInc(maxY() / 2) : maxY(),
      minY: 0,
      lineBarsData: linesBarData(),
    );
  }

  List<LineChartBarData> linesBarData() {
    return [
      LineChartBarData(
        spots: pointData.length != 0 ? pointData : [FlSpot(0, 0)],
        isCurved: false,
        curveSmoothness: 0,
        colors: const [
          pink,
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }
}
