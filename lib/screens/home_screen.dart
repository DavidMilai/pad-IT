import 'package:flutter/material.dart';
import 'package:pad_app/widgets/announcement_tile.dart';
import 'package:pad_app/widgets/circular_graph.dart';
import 'package:pad_app/widgets/custom_card.dart';
import 'package:pad_app/widgets/icon_with_text.dart';
import 'package:pad_app/widgets/text_with_number.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              height: size.height * 0.13,
              color: Colors.pink,
              child: Row(
                children: [
                  Text(
                    'Hi Bizey',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  Spacer(),
                  SizedBox(width: 15),
                  CircleAvatar(
                    radius: size.width * 0.075,
                    backgroundColor: Colors.transparent,
                    backgroundImage: ExactAssetImage('assets/background.jpg'),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  CustomCard(
                    height: size.height * 0.19,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Siyapei Primary School',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  width: 50,
                                  height: 50,
                                  child: CircularGraph(
                                    items: 3,
                                    one: Colors.red,
                                    three: Colors.green,
                                    itemOne: 20,
                                    two: Colors.grey[350],
                                    itemTwo: 30,
                                    itemThree: 40,
                                  )),
                              Hero(
                                tag: 'taken',
                                child: TextWithNumber(
                                  text: 'Girls',
                                  numberColor: Colors.green,
                                  number: '10',
                                ),
                              ),
                              Hero(
                                tag: 'applications',
                                child: TextWithNumber(
                                  text: 'Applications',
                                  numberColor: Colors.grey[350],
                                  number: '20',
                                ),
                              ),
                              Hero(
                                tag: 'balance',
                                child: TextWithNumber(
                                  text: 'Balance',
                                  numberColor: Colors.green,
                                  number: '30',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  CustomCard(
                      height: size.height * 0.19,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: kMyPadding),
                            child: Text(
                              'Attendance',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  width: 50,
                                  height: 50,
                                  child: CircularGraph(
                                    items: 3,
                                    one: Colors.red,
                                    itemOne: 1,
                                    two: Colors.yellow,
                                    itemTwo: 3,
                                    three: Colors.green,
                                    itemThree: 10,
                                  )),
                              TextWithNumber(
                                text: 'Attendance',
                                numberColor: Colors.green,
                                number: '30',
                              ),
                              TextWithNumber(
                                text: 'Late',
                                numberColor: Colors.yellow,
                                number: '3',
                              ),
                              TextWithNumber(
                                text: 'Absent',
                                numberColor: Colors.red,
                                number: '1',
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      )),
                  CustomCard(
                      height: size.height * 0.13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconWithText(
                            onTap: () {},
                            text: 'Calender',
                            icon: Icons.date_range,
                            color: Colors.blue[700],
                          ),
                          IconWithText(
                            onTap: () => {},
                            text: 'Expenses',
                            icon: Icons.monetization_on,
                            color: Colors.green,
                          ),
                          IconWithText(
                            text: 'Openings',
                            icon: Icons.account_box,
                            color: Colors.yellow,
                          )
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kMyPadding, vertical: kMyPadding / 2),
                    child: Row(
                      children: [
                        Text(
                          'Latest Arrivals',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'View All',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: kMyPadding),
                    height: size.height * 0.25,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        AnnouncementTile(
                          announcementsDate: '16 Dec 2020',
                          announcementTitle: 'Always Kenya',
                          announcementsDetails: 'Donated 20,000 pads',
                        ),
                        AnnouncementTile(
                          announcementsDate: '14 Dec 2020',
                          announcementTitle: 'Kotex Kenya',
                          announcementsDetails: 'Donated 50,000 pads',
                        ),
                        AnnouncementTile(
                          announcementsDate: '12 Dec 2020',
                          announcementTitle: 'Zana Africa',
                          announcementsDetails: 'Donated 10,000 pads',
                        ),
                        AnnouncementTile(
                          announcementsDate: '5 Dec 2020',
                          announcementTitle: 'Unilever',
                          announcementsDetails: 'Donated 15,000 pads',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
