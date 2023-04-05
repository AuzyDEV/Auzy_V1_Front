import 'package:flutter/material.dart';
import 'package:new_mee/authentification/login/login-controller.dart';
import 'package:new_mee/listing-directory/add-listing-category/add-listing-category-view.dart';
import 'package:new_mee/social-post/all-posts/all-posts-view.dart';
import 'package:new_mee/home/welcome-view.dart';
import 'package:new_mee/live-chat/conversation-list/conversation-list-view.dart';
import 'package:new_mee/user-profile/profile-model.dart';
import '../user-profile/profile-view.dart';
import '../admin-functions/user-management/all-users/all-users-view.dart';
import '../admin-functions/mail-broadcast/mail-broadcast-view.dart';
import '../admin-functions/post-management/all-management-posts/all-management-posts-view.dart';
import 'package:new_mee/user-profile/profile-controller.dart';
import '../authentification/login/login-view.dart';
import '../contact-us/contact-us-view.dart';
import '../themes/theme.dart';
import 'package:new_mee/home/home-view.dart';
import '../index.dart';

class Drawerr extends StatefulWidget {
  @override
  _DrawerrState createState() => _DrawerrState();
}

int selectedIndex = 0;
String _futureStringValue;
ProfilingMan apiUser = ProfilingMan();
Future<User> _futureUser;
ProfilingMan api = ProfilingMan();
SigninMan sapi = SigninMan();

class _DrawerrState extends State<Drawerr> {
  Future<String> _getCurrentUserRole() async {
    return apiUser.GetCurrentUserRole();
  }

  // Function to get the value of Future<String>
  void _getFutureStringValue() async {
    String value = await _getCurrentUserRole();
    setState(() {
      _futureStringValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _futureUser = api.GetCurrentUser();
    _getFutureStringValue();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    height: 130,
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 35, 16, 0),
                        child: FutureBuilder<User>(
                            future: _futureUser,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: FlutterAppTheme.of(context)
                                                  .primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(1, 1, 1, 1),
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.network(
                                                    '${snapshot.data.photoURL}',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${snapshot.data.displayName}',
                                            style: FlutterAppTheme.of(context)
                                                .title1
                                                .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: FlutterAppTheme.of(
                                                          context)
                                                      .blackColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                            child: Text(
                                              '${snapshot.data.email}',
                                              style: FlutterAppTheme.of(context)
                                                  .title1
                                                  .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: FlutterAppTheme.of(
                                                            context)
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }

                              return Center(
                                  child: const CircularProgressIndicator());
                            }),
                      ),
                      Divider()
                    ]),
                  ),
                ),
              ],
            ),
            _createDrawerItem(
                icon: Icons.home_outlined,
                text: 'Home',
                isSelected: selectedIndex == 0,
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeWithButtomNavBarWidget(),
                    ),
                  );
                }),
            _createDrawerItem(
                icon: Icons.account_circle_outlined,
                text: 'Profil',
                isSelected: selectedIndex == 1,
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyprofilWidget(),
                    ),
                  );
                }),
            if (_futureStringValue == "admin")
              _createDrawerItem(
                  icon: Icons.people_alt_outlined,
                  text: 'User Management',
                  isSelected: selectedIndex == 2,
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UsersWidget(),
                      ),
                    );
                  }),
            if (_futureStringValue == "admin")
              _createDrawerItem(
                  icon: Icons.send_outlined,
                  text: 'Announcement',
                  isSelected: selectedIndex == 5,
                  onTap: () {
                    setState(() {
                      selectedIndex = 5;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => announcementWidget(),
                      ),
                    );
                  }),
            if (_futureStringValue == "admin")
              _createDrawerItem(
                  icon: Icons.co_present_outlined,
                  text: 'Post Management',
                  isSelected: selectedIndex == 6,
                  onTap: () {
                    setState(() {
                      selectedIndex = 6;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostsManagementWidget(),
                      ),
                    );
                  }),
            if (_futureStringValue == "user")
              _createDrawerItem(
                  icon: Icons.co_present_outlined,
                  text: 'Posts',
                  isSelected: selectedIndex == 6,
                  onTap: () {
                    setState(() {
                      selectedIndex = 6;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => postsForUsersWidget(),
                      ),
                    );
                  }),
            _createDrawerItem(
                icon: Icons.person_search_outlined,
                text: 'Doctors',
                isSelected: selectedIndex == 8,
                onTap: () {
                  setState(() {
                    selectedIndex = 8;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpecialitiesWidget(),
                    ),
                  );
                }),
            _createDrawerItem(
                icon: Icons.message_outlined,
                text: 'Messages',
                isSelected: selectedIndex == 3,
                onTap: () {
                  setState(() {
                    selectedIndex = 3;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => chatcopyWidget(),
                    ),
                  );
                }),
            if (_futureStringValue == "user")
              _createDrawerItem(
                  icon: Icons.email_outlined,
                  text: 'Contact Us',
                  isSelected: selectedIndex == 9,
                  onTap: () {
                    setState(() {
                      selectedIndex = 9;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => contactUsWidget(),
                      ),
                    );
                  }),
            _createDrawerItem(
              icon: Icons.logout_outlined,
              text: 'Logout',
              isSelected: selectedIndex == 10,
              onTap: () async {
                bool response = await sapi.LogoutUser();
                if (response)
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SigninWidget(),
                    ),
                  );
                setState(() {
                  selectedIndex = 10;
                });
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap, bool isSelected}) {
  return Ink(
    child: ListTile(
      selected: true,
      hoverColor: Colors.white,
      title: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 0),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: isSelected ? Color(0xFF9457FB) : Color(0xFF616A6B),
              size: 24,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    color: isSelected ? Color(0xFF9457FB) : Color(0xFF616A6B)),
              ),
            )
          ],
        ),
      ),
      onTap: onTap,
    ),
  );
}