import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nonton_app/pages/login_page.dart';
import 'package:nonton_app/providers/auth_provider.dart';
import 'package:nonton_app/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkSession();
  }

  void checkSession() async {
    final sharedPref = await SharedPreferences.getInstance();
    final requestToken = sharedPref.getString('@requestToken');
    final sessionId = sharedPref.getString('@sessionId');
    if (requestToken != null && sessionId != null) {
      await Provider.of<AuthProvider>(context, listen: false)
          .checkSession(context, requestToken)
          .catchError((e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Nonton App'),
            content: Text('$e'),
          ),
        );
      });
      Navigator.pushReplacementNamed(context, MainPage.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlackColor,
      body: Center(
        child: AutoSizeText(
          'nonton',
          style: whiteTextStyle.copyWith(
            fontSize: 32,
            fontWeight: semiBold,
          ),
          maxFontSize: 32,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
