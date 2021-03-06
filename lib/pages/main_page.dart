import 'package:flutter/material.dart';
import 'package:nonton_app/pages/home_page.dart';
import 'package:nonton_app/pages/logout_page.dart';
import 'package:nonton_app/pages/search_page.dart';
import 'package:nonton_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const routeName = 'main-page';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const SearchPage(),
    const LogOutPage(),
  ];

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<AuthProvider>(context).signUp();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        elevation: 0,
        title: Text(
          'NONTON',
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
          ),
        ),
        centerTitle: true,
      ),
      // drawer: AppDrawer(),
      body: SizedBox.expand(
        child: _widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: lightBlackColor,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: "Home",
              backgroundColor: lightBlackColor),
          BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: "Search",
              backgroundColor: lightBlackColor),
          BottomNavigationBarItem(
              icon: const Icon(Icons.logout),
              label: "Log Out",
              backgroundColor: lightBlackColor),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: orangeColor,
        unselectedItemColor: greyColor,
        showSelectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
