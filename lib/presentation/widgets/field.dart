import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  final String? hintText;
  final bool isPassword;
  final TextInputType type;
  final String? initialValue;
  final TextAlign? align;
  final Color borderColor;
  final validator;
  final onSaved;

  const Field({
    Key? key,
    this.hintText,
    this.isPassword = false,
    required this.type,
    this.initialValue,
    this.validator,
     this.onSaved,
    this.align,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        textAlign: align ?? TextAlign.start,
        textAlignVertical: TextAlignVertical.bottom,
        style: const TextStyle(
            color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.only(top: 25),
          hintStyle: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),
          enabledBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor
                ,width: 3),
          ),

        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: type,
      ),
    );
  }
}
