import 'package:flutter/material.dart';

Widget customeTextButtonRegister(
        {required void Function()? onPressed, required String text}) =>
    TextButton(
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
              fontSize: 15,
              color: Color(0xff00C6FF),
              fontWeight: FontWeight.bold),
        ));
