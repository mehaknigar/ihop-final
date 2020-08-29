import 'package:baba_spira/Consts/color.dart';
import 'package:baba_spira/functions/roundAndInc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/growth.dart';

class Height extends StatefulWidget {
  final List<Growth> list;
  final DateTime db;
  Height(this.list, this.db);
  @override
  State<StatefulWidget> createState() => HeightState();
}

class HeightState extends State<Height> {
  List<FlSpot> pointData = [];

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
          FlSpot(
              x,
              maxY() > 90
                  ? (item.height - 30) / 5
                  : maxY() > 55 ? (item.height - 30) / 3 : item.height - 30),
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
      double max = widget.list[0].height;

      for (var item in widget.list) {
        if (item.height > max) max = item.height;
      }

      maxR = roundAndInc(max);
    } else
      maxR = -1;

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
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            if (maxY() > 90) {
              switch (value.toInt()) {
                case 0:
                  return '30 cm';
                case 1:
                  return '35 cm';
                case 2:
                  return '40 cm';
                case 3:
                  return '45 cm';
                case 4:
                  return '50 cm';
                case 5:
                  return '55 cm';
                case 6:
                  return '60 cm';
                case 7:
                  return '65 cm';
                case 8:
                  return '70 cm';
                case 9:
                  return '75 cm';
                case 10:
                  return '80 cm';
                case 11:
                  return '85 cm';
                case 12:
                  return '90 cm';
                case 13:
                  return '95 cm';
                case 14:
                  return '100 cm';
                case 15:
                  return '105 cm';
                case 16:
                  return '110 cm';
                case 17:
                  return '115 cm';
                case 18:
                  return '120 cm';
                case 19:
                  return '125 cm';
                case 20:
                  return '130 cm';
                case 21:
                  return '135 cm';
                case 22:
                  return '140 cm';
                case 23:
                  return '145 cm';
                case 24:
                  return '150 cm';
              }
            } else if (maxY() > 55) {
              switch (value.toInt()) {
                case 0:
                  return '30 cm';
                case 1:
                  return '33 cm';
                case 2:
                  return '36 cm';
                case 3:
                  return '39 cm';
                case 4:
                  return '42 cm';
                case 5:
                  return '45 cm';
                case 6:
                  return '48 cm';
                case 7:
                  return '51 cm';
                case 8:
                  return '54 cm';
                case 9:
                  return '57 cm';
                case 10:
                  return '60 cm';
                case 11:
                  return '63 cm';
                case 12:
                  return '66 cm';
                case 13:
                  return '69 cm';
                case 14:
                  return '72 cm';
                case 15:
                  return '75 cm';
                case 16:
                  return '78 cm';
                case 17:
                  return '81 cm';
                case 18:
                  return '84 cm';
                case 19:
                  return '87 cm';
                case 20:
                  return '90 cm';
              }
            } else {
              switch (value.toInt()) {
                case 0:
                  return '30 cm';
                case 1:
                  return '31 cm';
                case 2:
                  return '32 cm';
                case 3:
                  return '33 cm';
                case 4:
                  return '34 cm';
                case 5:
                  return '35 cm';
                case 6:
                  return '36 cm';
                case 7:
                  return '37 cm';
                case 8:
                  return '38 cm';
                case 9:
                  return '39 cm';
                case 10:
                  return '40 cm';
                case 11:
                  return '41 cm';
                case 12:
                  return '42 cm';
                case 13:
                  return '43 cm';
                case 14:
                  return '44 cm';
                case 15:
                  return '45 cm';
                case 16:
                  return '46 cm';
                case 17:
                  return '47 cm';
                case 18:
                  return '48 cm';
                case 19:
                  return '49 cm';
                case 20:
                  return '50 cm';
                case 21:
                  return '51 cm';
                case 22:
                  return '52 cm';
                case 23:
                  return '53 cm';
                case 24:
                  return '54 cm';
                case 25:
                  return '55 cm';
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
      maxY: maxY() == -1
          ? 5
          : maxY() > 90
              ? roundAndInc((maxY() - 30) / 5)
              : maxY() > 55 ? roundAndInc((maxY() - 30) / 3) : (maxY() - 30),
      minY: 0,
      lineBarsData: linesBarData(),
      //backgroundColor: Colors.green,
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
