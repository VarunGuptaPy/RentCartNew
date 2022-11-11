import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final IconData? iconData;
  final TextEditingController? controller;
  bool? isObsecured = false;
  bool? enabled = true;
  CustomTextField(
      {this.hintText,
      this.iconData,
      this.controller,
      this.isObsecured,
      this.enabled});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: enabled,
        obscureText: isObsecured!,
        controller: controller,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            iconData,
            color: Colors.cyan,
          ),
          hintText: hintText,
          focusColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
