import 'package:new_mee/common_widgets/FFButtonWidget.dart';
import 'package:new_mee/themes/theme.dart';
import 'package:flutter/material.dart';

class SnackbarWidget extends SnackBar {
  final Widget content;
  //final SnackBarAction action;

  const SnackbarWidget({this.content}) : super(content: content);

  @override
  _SnackbarWidgetState createState() => _SnackbarWidgetState();
}

class _SnackbarWidgetState extends State<SnackbarWidget> {
  var selectedDate;
  @override
  Widget build(BuildContext context) {
    return SnackBar(
        content: widget.content,
        duration: Duration(milliseconds: 3000),
        backgroundColor: Colors.red);
  }
}
