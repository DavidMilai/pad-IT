import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Payments'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: size.height * 0.9,
        child: ListView(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ]),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.08,
                      backgroundColor: Colors.transparent,
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://files.globalgiving.org/pfil/17310/ph_17310_60576.jpg?m=1400947068000',
                        imageBuilder: (context, imageProvider) {
                          return CircleAvatar(
                              radius: size.width * 0.13,
                              backgroundColor: Colors.transparent,
                              backgroundImage: imageProvider);
                        },
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Joyce Naserian'),
                        Text('Admission number 0023'),
                        Text('12 years old'),
                        Text('Class 7'),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          await UrlLauncher.launch("tel://0711502614");
                        },
                        child: Text(
                          'Call\nParent',
                          style: TextStyle(color: Colors.green),
                          textAlign: TextAlign.center,
                        )),
                  ],
                )),
            Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ]),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.08,
                      backgroundColor: Colors.transparent,
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRxeNTToaR6uO10BJr5M7j1K5DhbGbbq1O7w&usqp=CAU',
                        imageBuilder: (context, imageProvider) {
                          return CircleAvatar(
                              radius: size.width * 0.13,
                              backgroundColor: Colors.transparent,
                              backgroundImage: imageProvider);
                        },
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mary Nkasiogi'),
                        Text('Admission number 0009'),
                        Text('19 years old'),
                        Text('Class 8'),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          await UrlLauncher.launch("tel://0711502614");
                        },
                        child: Text(
                          'Call\nParent',
                          style: TextStyle(color: Colors.green),
                          textAlign: TextAlign.center,
                        )),
                  ],
                )),
            Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ]),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.08,
                      backgroundColor: Colors.transparent,
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrd3K5zxsvCeYmYlNXy8VceH3sWp8R-wV9Cw&usqp=CAU',
                        imageBuilder: (context, imageProvider) {
                          return CircleAvatar(
                              radius: size.width * 0.13,
                              backgroundColor: Colors.transparent,
                              backgroundImage: imageProvider);
                        },
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Faith Naipanoi'),
                        Text('Admission number 0034'),
                        Text('15 years old'),
                        Text('Class 8'),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          await UrlLauncher.launch("tel://0711502614");
                        },
                        child: Text(
                          'Call\nParent',
                          style: TextStyle(color: Colors.green),
                          textAlign: TextAlign.center,
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
