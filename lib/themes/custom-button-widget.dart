
import '../themes/theme.dart';
import 'package:flutter/material.dart';

import 'button-widget.dart';

class buttonWidget extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const buttonWidget({this.text, this.onPressed}) : super();

  @override
  _buttonWidgetState createState() => _buttonWidgetState();
}

class _buttonWidgetState extends State<buttonWidget> {
  var selectedDate;
  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: widget.onPressed,
      text: widget.text,
      options: FFButtonOptions(
        height: 45,
        color: FlutterAppTheme.of(context).ButtonPrimaryColor,
        textStyle: FlutterAppTheme.of(context).subtitle2.override(
              fontFamily: 'Roboto',
              color: FlutterAppTheme.of(context).primaryBtnText,
              fontWeight: FontWeight.bold,
            ),
        borderSide: BorderSide(
          color: FlutterAppTheme.of(context).TransparentColor,
          width: 1,
        ),
      ),
    );
  }
}