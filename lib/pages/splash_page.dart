import 'package:flutter/material.dart';
import 'package:nonton_app/pages/login_page.dart';
import 'package:nonton_app/providers/auth_provider.dart';
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
    // TODO: implement initState
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
            title: Text('Nonton App'),
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
      body: Center(
        child: Text('Nonton App'),
      ),
    );
  }
}
