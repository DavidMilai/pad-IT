import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pad_app/screens/notifications_screen.dart';
import 'package:pad_app/screens/qr_codes_screen.dart';
import 'package:pad_app/tabs/donors_tab.dart';
import 'package:pad_app/tabs/reports_tab.dart';
import 'package:pad_app/tabs/students_tab.dart';
import 'package:pad_app/widgets/announcement_tile.dart';
import 'package:pad_app/widgets/circular_graph.dart';
import 'package:pad_app/widgets/custom_card.dart';
import 'package:pad_app/widgets/icon_with_text.dart';
import 'package:pad_app/widgets/text_with_number.dart';
import 'package:pad_app/widgets/title_and_content.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tab = 0, totalDonations = 0, donors = 0, students = 0;
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference donationsCollection, studentsCollection;

  Future getTotalDonations() async {
    totalDonations = 0;
    var studentsSnapshot = await studentsCollection.get();
    students = studentsSnapshot.docs.length;
    kNumberOfStudents = studentsSnapshot.docs.length;
    var dataSnapshot = await donationsCollection.get();
    donors = dataSnapshot.docs.length;
    dataSnapshot.documents.forEach((element) {
      setState(() {
        totalDonations = totalDonations + element['donations'];
      });
      setState(() {
        kTotalDonations = totalDonations.toDouble();
      });
    });
  }

  void checkUser(String user) async {
    if (user == 'nabuyuni.sankan@strathmore.edu') {
      kProfileImage = 'assets/profile.jpg';
      kName = 'Nabuyuni Sankan';
      kSchool = 'Narok Primary School';
      kDBtoUse = 'Narok Primary School';
    } else if (user == 'nabuyuni@strathmore.edu') {
      kProfileImage = 'assets/profile1.jpg';
      kName = 'Nabuyuni';
      kSchool = 'Olkeri Primary school';
      kDBtoUse = 'Olkeri Primary school';
    } else if (user == 'bizeysankan@gmail.com') {
      kProfileImage = 'assets/profile2.jpg';
      kName = 'Bizey';
      kSchool = 'Masikonde Primary School';
      kDBtoUse = 'Masikonde Primary School';
    } else if (user == 'sankan@gmail.com') {
      kProfileImage = 'assets/profile3.jpg';
      kName = 'Sankan';
      kSchool = 'Siyapei Primary School';
      kDBtoUse = 'BUShus6GvovjCb9lT48X';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser(auth.currentUser.email);
    studentsCollection = FirebaseFirestore.instance
        .collection('Schools')
        .doc(kDBtoUse)
        .collection('students');
    donationsCollection = FirebaseFirestore.instance
        .collection('Schools')
        .doc(kDBtoUse)
        .collection('sponsors');
    getTotalDonations();
  }

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
              //Color(0xff09182D),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          getTotalDonations();
                        },
                        child: Text(
                          'Hi $kName',
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationsScreen()));
                        },
                        child: Badge(
                          badgeContent: Text(
                            '3',
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Icon(Icons.notifications,
                              color: Colors.white, size: 30),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(kMyPadding),
                                ),
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: kMyPadding,
                                          top: kMyPadding * 3,
                                          right: kMyPadding,
                                          bottom: kMyPadding),
                                      margin: EdgeInsets.only(
                                          top: kMyPadding * 2.1),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(kMyPadding),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(0, 10),
                                                blurRadius: 10),
                                          ]),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 20),
                                          TitleAndContent(
                                              title: 'Name', content: kName),
                                          TitleAndContent(
                                              title: 'Email Address',
                                              content: auth.currentUser.email),
                                          SizedBox(height: 10),
                                          // Align(
                                          //   alignment: Alignment.bottomRight,
                                          //   child: FlatButton(
                                          //       onPressed: () {},
                                          //       child: Text(
                                          //         'EDIT',
                                          //         style: TextStyle(
                                          //             color: Colors.red,
                                          //             fontSize: 18),
                                          //       )),
                                          // ),
                                        ],
                                      ),
                                    ), // bottom part
                                    Positioned(
                                        left: kMyPadding,
                                        right: kMyPadding,
                                        top: 0,
                                        child: CircleAvatar(
                                          radius: size.width * 0.15,
                                          backgroundColor: Colors.transparent,
                                          backgroundImage:
                                              ExactAssetImage(kProfileImage),
                                        ))
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          radius: size.width * 0.075,
                          backgroundColor: Colors.transparent,
                          backgroundImage: ExactAssetImage(kProfileImage),
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.8,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  getTotalDonations();
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
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          kName = '';
                          kSchool = '';
                          kDBtoUse = '';
                          Navigator.pop(context);
                        },
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
                                  kSchool,
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
                                        child: totalDonations == 0 ||
                                                students == 0
                                            ? SpinKitWave(
                                                color: Colors.brown,
                                                size: 20,
                                              )
                                            : CircularGraph(
                                                items: 3,
                                                one: Colors.amber,
                                                two: Colors.green,
                                                three: Colors.grey,
                                                itemOne: students.toDouble(),
                                                itemTwo:
                                                    totalDonations.toDouble(),
                                                itemThree: 150,
                                              )),
                                    TextWithNumber(
                                      text: 'Girls',
                                      numberColor: Colors.amber,
                                      number: '$students',
                                    ),
                                    TextWithNumber(
                                      text: 'Donations',
                                      numberColor: Colors.green,
                                      number: '$totalDonations',
                                    ),
                                    TextWithNumber(
                                      text: 'Available',
                                      numberColor: Colors.grey,
                                      number: '150',
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
                                        child: donors == 0
                                            ? SpinKitWave(
                                                color: Colors.brown,
                                                size: 20,
                                              )
                                            : CircularGraph(
                                                items: 2,
                                                one: Colors.green,
                                                two: Colors.red,
                                                itemOne: donors.toDouble(),
                                                itemTwo: 30,
                                              )),
                                    TextWithNumber(
                                      text: 'Donors',
                                      numberColor: Colors.green,
                                      number: '$donors',
                                    ),
                                    TextWithNumber(
                                      text: 'Receives',
                                      numberColor: Colors.amber,
                                      number: '150',
                                    ),
                                    TextWithNumber(
                                      text: 'Pending',
                                      numberColor: Colors.red,
                                      number: '30',
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
                                  onTap: () {
                                    setState(() {
                                      tab = 2;
                                    });
                                  },
                                  text: 'Donors',
                                  icon: Icons.monetization_on,
                                  color: Colors.green,
                                ),
                                IconWithText(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QRCodes()));
                                  },
                                  text: 'QR codes',
                                  icon: Icons.qr_code_outlined,
                                  color: Colors.pink,
                                ),
                                IconWithText(
                                  onTap: () {
                                    Fluttertoast.showToast(
                                        msg: "Future work",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  },
                                  text: 'E-wallet',
                                  icon: Icons.account_balance_wallet_outlined,
                                  color: Colors.green,
                                ),
                                IconWithText(
                                  onTap: () {
                                    setState(() {
                                      tab = 3;
                                    });
                                  },
                                  text: 'Reports',
                                  icon: Icons.file_copy_outlined,
                                  color: Colors.blue[700],
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
                                onTap: () {
                                  setState(() {
                                    tab = 2;
                                  });
                                },
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
                                announcementsDetails: 'Donated 10 pads',
                              ),
                              AnnouncementTile(
                                announcementsDate: '14 Dec 2020',
                                announcementTitle: 'Kotex Kenya',
                                announcementsDetails: 'Donated 20 pads',
                              ),
                              AnnouncementTile(
                                announcementsDate: '12 Dec 2020',
                                announcementTitle: 'Zana Africa',
                                announcementsDetails: 'Donated 20 pads',
                              ),
                              AnnouncementTile(
                                announcementsDate: '5 Dec 2020',
                                announcementTitle: 'Unilever',
                                announcementsDetails: 'Donated 10 pads',
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
                        : ReportsTab()
          ],
        ),
      ),
    );
  }
}
