import 'package:flutter/material.dart';

const textInputField = InputDecoration(
    hintText:  'Email',
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white,width: 1.0)
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFB0E4F1))
    )
);