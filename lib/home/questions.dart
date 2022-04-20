import 'package:flutter/material.dart';
import 'package:sa3dni_app/shared/constData.dart';

class QuestionTemp extends StatefulWidget {

   const QuestionTemp({Key? key}) : super(key: key);

  @override
  _QuestionTempState createState() => _QuestionTempState();
}

class _QuestionTempState extends State<QuestionTemp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstData().basicColor,
        title: const Text('Question'),
      ),
      backgroundColor: ConstData().secColor,
      body : const Center()
    );
  }
}
