import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DonorsTab extends StatefulWidget {
  @override
  _DonorsTabState createState() => _DonorsTabState();
}

class _DonorsTabState extends State<DonorsTab> {
  CollectionReference collectionReference;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    collectionReference = FirebaseFirestore.instance
        .collection('Schools')
        .doc('Masikonde Primary School')
        .collection('sponsors');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return collectionReference != null
        ? StreamBuilder(
            stream: collectionReference.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data == null) {
                return Column(
                  children: [
                    SizedBox(height: size.height * 0.25),
                    SpinKitWave(
                      color: Colors.brown,
                      size: 80,
                    ),
                  ],
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        var doc = snapshot.data.docs[index].data();
                        return Container(
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
                                Image.network(
                                  '${doc['logo']}',
                                  height: 50,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${doc['organization']}'),
                                    Text('Donations ${doc['donations']}'),
                                  ],
                                ),
                              ],
                            ));
                      }),
                );
              }
            })
        : Center(
            child: SpinKitWave(
              color: Colors.amber,
              size: 80.0,
            ),
          );
  }
}
