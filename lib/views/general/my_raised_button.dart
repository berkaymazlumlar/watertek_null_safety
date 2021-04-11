import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class MyRaisedButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final TextAlign textAlign;

  const MyRaisedButton(
      {Key key,
      this.onPressed,
      this.buttonText,
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElasticInRight(
      child: ButtonTheme(
        height: 50,
        child: RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          color: Theme.of(context).primaryColor,
          onPressed: this.onPressed,
          child: Text(
            this.buttonText,
            style: TextStyle(color: Colors.white),
            textAlign: textAlign,
          ),
        ),
      ),
    );
  }
}
