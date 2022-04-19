import 'package:flutter/material.dart';

class OrganizationEvent{
  String organizationID;
  String title;
  DateTime date;
  TimeOfDay time;
  String location;
  String description;


  OrganizationEvent({required this.organizationID ,required this.title,required this.date,required this.time , required this.location,
  required this.description});
}