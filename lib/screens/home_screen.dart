import 'package:flutter/material.dart';
import 'package:pad_app/tabs/donors_tab.dart';
import 'package:pad_app/tabs/students_tab.dart';
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
  int tab = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              height: size.height * 0.17,
              color: Colors.pink,
              child: Column(
                children: [
                  Row(
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
                      CircleAvatar(
                        radius: size.width * 0.075,
                        backgroundColor: Colors.transparent,
                        backgroundImage: ExactAssetImage('assets/profile.jpg'),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  tab = 0;
                                });
                              },
                              child: Text(
                                'DashBoard',
                                style: TextStyle(
                                    color:
                                        tab == 0 ? Colors.white : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  tab = 1;
                                });
                              },
                              child: Text(
                                'Students',
                                style: TextStyle(
                                    color:
                                        tab == 1 ? Colors.white : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  tab = 2;
                                });
                              },
                              child: Text(
                                'Donors',
                                style: TextStyle(
                                    color:
                                        tab == 2 ? Colors.white : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  tab = 3;
                                });
                              },
                              child: Text(
                                'Reports',
                                style: TextStyle(
                                    color:
                                        tab == 3 ? Colors.white : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            tab == 0
                ? Expanded(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        width: 50,
                                        height: 50,
                                        child: CircularGraph(
                                          items: 3,
                                          one: Colors.amber,
                                          two: Colors.green,
                                          three: Colors.grey,
                                          itemOne: 150,
                                          itemTwo: 700,
                                          itemThree: 300,
                                        )),
                                    Hero(
                                      tag: 'taken',
                                      child: TextWithNumber(
                                        text: 'Girls',
                                        numberColor: Colors.amber,
                                        number: '150',
                                      ),
                                    ),
                                    Hero(
                                      tag: 'applications',
                                      child: TextWithNumber(
                                        text: 'Donations',
                                        numberColor: Colors.green,
                                        number: '700',
                                      ),
                                    ),
                                    Hero(
                                      tag: 'balance',
                                      child: TextWithNumber(
                                        text: 'Available',
                                        numberColor: Colors.grey,
                                        number: '300',
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kMyPadding),
                                  child: Text(
                                    'Donors',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        width: 50,
                                        height: 50,
                                        child: CircularGraph(
                                          items: 3,
                                          one: Colors.green,
                                          two: Colors.amber,
                                          three: Colors.red,
                                          itemOne: 4,
                                          itemTwo: 3500,
                                          itemThree: 750,
                                        )),
                                    TextWithNumber(
                                      text: 'Donors',
                                      numberColor: Colors.green,
                                      number: '4',
                                    ),
                                    TextWithNumber(
                                      text: 'Receives',
                                      numberColor: Colors.amber,
                                      number: '3500',
                                    ),
                                    TextWithNumber(
                                      text: 'Pending',
                                      numberColor: Colors.red,
                                      number: '750',
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
                                  text: 'Reports',
                                  icon: Icons.file_copy_outlined,
                                  color: Colors.blue[700],
                                ),
                                IconWithText(
                                  onTap: () => {},
                                  text: 'Donors',
                                  icon: Icons.monetization_on,
                                  color: Colors.green,
                                ),
                                IconWithText(
                                  onTap: () {},
                                  text: 'QR codes',
                                  icon: Icons.qr_code_outlined,
                                  color: Colors.pink,
                                ),
                                IconWithText(
                                  onTap: () {},
                                  text: 'E-wallet',
                                  icon: Icons.account_balance_wallet_outlined,
                                  color: Colors.green,
                                ),
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
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.red),
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
                                announcementsDetails: 'Donated 2000 pads',
                              ),
                              AnnouncementTile(
                                announcementsDate: '14 Dec 2020',
                                announcementTitle: 'Kotex Kenya',
                                announcementsDetails: 'Donated 500 pads',
                              ),
                              AnnouncementTile(
                                announcementsDate: '12 Dec 2020',
                                announcementTitle: 'Zana Africa',
                                announcementsDetails: 'Donated 1000 pads',
                              ),
                              AnnouncementTile(
                                announcementsDate: '5 Dec 2020',
                                announcementTitle: 'Unilever',
                                announcementsDetails: 'Donated 750 pads',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : tab == 1
                    ? StudentsTab()
                    : tab == 2
                        ? DonorsTab()
                        : Container(
                            child: Center(
                                child: Text(
                              'To show reports',
                              style: TextStyle(fontSize: 20),
                            )),
                          )
          ],
        ),
      ),
    );
  }
}
