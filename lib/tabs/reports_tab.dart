import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pad_app/widgets/line_graph.dart';

import '../constants.dart';

class ReportsTab extends StatefulWidget {
  @override
  _ReportsTabState createState() => _ReportsTabState();
}

class _ReportsTabState extends State<ReportsTab> {
  List<FlSpot> mySpot = [
    FlSpot(0, 90),
    FlSpot(1, 100),
    FlSpot(2, 70),
    FlSpot(3, kTotalDonations)
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Scaffold(
        body: kTotalDonations == 0
            ? SpinKitWave(
                color: Colors.pink,
                size: 80,
              )
            : Container(
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.45,
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Deliveries in the last months',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              Container(
                                  padding: EdgeInsets.only(left: 10, right: 20),
                                  width: double.infinity,
                                  height: size.height * 0.4,
                                  child: LineChartSample2(
                                    mySpot: mySpot,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
