import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sa3dni_app/shared/constData.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    required Key? key,
    required this.icon,
    required this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ).copyWith(
        bottom: 20,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade300,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: 25,
          ),
          SizedBox(width: 15),
          Text(
            this.text,
            style: ConstData().kTitleTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins"
            ),
          ),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              LineAwesomeIcons.angle_right,
              size: 25,
            ),
        ],
      ),
    );
  }
}