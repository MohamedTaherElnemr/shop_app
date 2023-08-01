import 'package:flutter/material.dart';

Widget customeTextFormField(
        {required TextEditingController controller,
        required TextInputType type,
        void Function(String)? onSubmit,
        void Function(String)? onChanged,
        required String? Function(String?)? validate,
        required String? hintText,
        required IconData? prefixIcon,
        IconData? suffixIcon,
        bool isPass = false,
        bool isclick = true,
        void Function()? onTap,
        Widget? suffix}) =>
    TextFormField(
      enabled: isclick,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      obscureText: isPass,
      onTap: onTap,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: Icon(suffixIcon),
          suffix: suffix,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(8)),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(8))),
    );
