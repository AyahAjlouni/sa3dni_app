
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class ConstData{
  Color basicColor = Color(0xFF09376B);
  Color secColor = Color(0xFFDAEFEF);
  Color kAppPrimaryColor = Colors.grey.shade200;
  Color kWhite = Colors.white;
  Color kLightBlack = Colors.black.withOpacity(0.075);
  Color mCC = Colors.green.withOpacity(0.65);
  Color fCL = Colors.grey.shade600;


  IconData twitter = IconData(0xe900, fontFamily: "CustomIcons");
  IconData facebook = IconData(0xe901, fontFamily: "CustomIcons");
  IconData googlePlus =
  IconData(0xe902, fontFamily: "CustomIcons");
  IconData linkedin = IconData(0xe903, fontFamily: "CustomIcons");

  static const kSpacingUnit = 10;

  final kTitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  BoxDecoration avatarDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFF09376B),
      boxShadow: [
        BoxShadow(
          color: Colors.white,
          offset: Offset(10, 10),
          blurRadius: 10,
        ),
        BoxShadow(
          color: Colors.white,
          offset: Offset(-10, -10),
          blurRadius: 10,
        ),
      ]
  );

}