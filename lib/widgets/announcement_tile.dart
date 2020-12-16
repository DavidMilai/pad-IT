import 'package:flutter/material.dart';
import '../constants.dart';

class AnnouncementTile extends StatelessWidget {
  final String announcementTitle, announcementsDetails, announcementsDate;
  final Color color;
  AnnouncementTile(
      {this.announcementsDate,
      this.color,
      this.announcementsDetails,
      this.announcementTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: kMyPadding / 4),
      margin: EdgeInsets.symmetric(vertical: kMyPadding / 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey[300]),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                announcementTitle,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                announcementsDetails,
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
          Spacer(),
          Text(
            announcementsDate,
            style: TextStyle(
                fontSize: 16, color: color == null ? Colors.black : color),
          ),
        ],
      ),
    );
  }
}
