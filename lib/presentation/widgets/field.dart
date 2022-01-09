import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  final String? hintText;
  final bool isPassword;
  final TextInputType type;
  final String? initialValue;
  final TextAlign? align;
  final Color borderColor;
  final bool isEnabled;
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
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        textAlign: align ?? TextAlign.start,
        textAlignVertical: TextAlignVertical.bottom,
        initialValue: initialValue,
        obscureText: isPassword ? true : false,
        keyboardType: type,
        enabled: isEnabled,
        style: const TextStyle(
            color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 3),
          ),
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
