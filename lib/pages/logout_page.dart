import 'package:flutter/material.dart';
import 'package:nonton_app/pages/login_page.dart';
import 'package:nonton_app/providers/auth_provider.dart';
import 'package:nonton_app/theme.dart';
import 'package:provider/provider.dart';

class LogOutPage extends StatefulWidget {
  const LogOutPage({Key? key}) : super(key: key);

  static const routeName = 'logout-page';

  @override
  State<LogOutPage> createState() => _LogOutPageState();
}

class _LogOutPageState extends State<LogOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: orangeColor,
          ),
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).logout();
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginPage.routeName,
              (route) => false,
            );
          },
          child: Text(
            'Log Out',
            style: whiteTextStyle.copyWith(
              fontWeight: semiBold,
            ),
          ),
        ),
      ),
    );
  }
}
