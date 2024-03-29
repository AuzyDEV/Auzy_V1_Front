import 'package:flutter/material.dart';
import '../../themes/theme.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;

  const ProfileHeaderWidget({@required this.name, Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    height: 93,
    decoration: BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    ),
  ),
    padding: EdgeInsets.all(16).copyWith(left: 0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(color: FlutterAppTheme.of(context).whiteColor),
            Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    color: FlutterAppTheme.of(context).whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              
            ),
            SizedBox(width: 4),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(41, 0, 0, 0),
              child: Text(
                "Online",
                style: TextStyle(
                  fontSize: 14.5,
                  color: FlutterAppTheme.of(context).whiteColor,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          SizedBox(width: 4),
          ],
        )
      ],
    ),
  );

  Widget buildIcon(IconData icon) => Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white54,
    ),
    child: Icon(icon, size: 25, color: Colors.black),
  );
}
