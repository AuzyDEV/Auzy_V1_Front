import 'package:flutter/material.dart';
import '../index.dart';
import 'theme.dart';
import '../user-profile/profile-controller.dart';

class buttomNavBar extends StatefulWidget {
  @override
  _buttomNavBarState createState() => _buttomNavBarState();
}

int _selectedIndex = 0;
ProfilingMan apiUser = ProfilingMan();

PageController _pageController;
final List<Widget> _pagesUser = [
  HomeWidget(),
  postsForUsersWidget(),
  addListingWidget(),
  MyprofilWidget()
];
final List<Widget> _pagesAdmin = [
  HomeWidget(),
  postsNewWidget(),
  addListingWidget(),
  MyprofilWidget()
];
int _currentIndex = 0;
String _futureRoleValue;
Future<String> _getCurrentUserRole() async {
  return apiUser.GetCurrentUserRole();
}

void _getFutureRoleValue() async {
  String value = await _getCurrentUserRole();
  _futureRoleValue = value;
}

class _buttomNavBarState extends State<buttomNavBar> {
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _getFutureRoleValue();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      fixedColor: FlutterAppTheme.of(context).ButtonPrimaryColor,
      unselectedItemColor: FlutterAppTheme.of(context).secondaryText,
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_sharp,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_sharp,
            ),
            label: 'Posts'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person_search,
            ),
            label: 'Doctors'),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_sharp,
          ),
          label: "Profile",
        ),
      ],
    );
  }
}
