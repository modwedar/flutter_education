import 'package:flutter/material.dart';
import 'package:flutter_education/components/text_field_container.dart';
import 'package:flutter_education/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  @required
  final ValueChanged<String> onChanged;
  final bool phone;
  final TextEditingController controller;
  final Widget drawable;
  const RoundedInputField({
    Key key,
    @required this.hintText,
    this.onChanged, 
    this.phone = false, 
    this.controller,
    this.drawable
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        keyboardType: phone ? TextInputType.number : TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontFamily: 'ElMessiri',
          ),
            icon: drawable,
            hintText: hintText,
            border: InputBorder.none),
      ),
    );
  }
}
