import 'package:flutter/material.dart';
import '../../index.dart';
import '../../themes/theme.dart';
import '../../user-profile/profile-model.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<User> users;

  const ChatBodyWidget({ @required this.users, Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: FlutterAppTheme.of(context).whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: buildChats(),
    ),
  );

  Widget buildChats() => ListView.builder(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      final user = users[index];
      return Container(
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatPage(user: user),
            ));
          },
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("../../assets/images/user.png"),
          ),
          title: Text(user.displayName),
        ),
      );
    },
    itemCount: users.length,
  );
}
