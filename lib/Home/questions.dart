import 'package:flutter/material.dart';
import 'package:sa3dni_app/models/category.dart';
import 'package:sa3dni_app/shared/constData.dart';

class QuestionTemp extends StatefulWidget {

   QuestionTemp({Key? key}) : super(key: key);

  @override
  _QuestionTempState createState() => _QuestionTempState();
}

class _QuestionTempState extends State<QuestionTemp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstData().basicColor,
        title: Text('Question'),
      ),
      backgroundColor: ConstData().secColor,
      body : Center()
    );
  }
}
