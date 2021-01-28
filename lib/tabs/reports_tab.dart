import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pad_app/widgets/custom_card.dart';
import 'package:pad_app/widgets/line_graph.dart';
import 'package:pad_app/widgets/text_with_number.dart';

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
                    SizedBox(height: 20),
                    CustomCard(
                      height: size.height * 0.2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              'January',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextWithNumber(
                                number: '${kTotalDonations.toInt()}',
                                numberColor: Colors.green,
                                text: 'Total Donations',
                              ),
                              TextWithNumber(
                                number: '$kNumberOfStudents',
                                numberColor: Colors.amber,
                                text: 'Number of girls',
                              ),
                              TextWithNumber(
                                number: '${kTotalDonations.toInt() - 20}',
                                numberColor: Colors.pink,
                                text: 'Issued Donations',
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
//kTotalDonations
