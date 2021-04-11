import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextAlign textAlign;
  final String hintText;
  final String labelText;
  final int maxLines;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final Function onChanged;
  final bool autoFocus;
  final TextAlignVertical textAlignVertical;
  final Function validator;

  MyTextField(
      {this.controller,
      this.hintText,
      this.prefixIcon,
      this.labelText,
      this.textInputAction,
      this.textCapitalization,
      this.suffixIcon,
      this.maxLines = 1,
      this.obscureText = false,
      this.inputFormatters,
      this.keyboardType,
      this.textAlign = TextAlign.start,
      this.onChanged,
      this.autoFocus = false,
      this.textAlignVertical,
      this.validator});
  @override
  Widget build(BuildContext context) {
    return ElasticInRight(
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 4,
        child: TextFormField(
          validator: this.validator,
          textAlignVertical: this.textAlignVertical,
          autofocus: this.autoFocus,
          onChanged: this.onChanged,
          textAlign: this.textAlign,
          keyboardType: this.keyboardType,
          inputFormatters: this.inputFormatters,
          obscureText: this.obscureText,
          maxLines: this.maxLines,
          controller: this.controller,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            contentPadding:
                new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
            filled: true,
            fillColor: Colors.white,
            hintText: this.hintText,
            labelText: this.labelText,
            prefixIcon: this.prefixIcon,
            suffixIcon: this.suffixIcon,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
