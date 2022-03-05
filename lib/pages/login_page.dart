import 'package:flutter/material.dart';
import 'package:nonton_app/pages/main_page.dart';
import 'package:nonton_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routeName = 'login-page';

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Username'),
              ),
              controller: usernameController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Password'),
              ),
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .requestToken(
                        context,
                        usernameController.text,
                        passwordController.text,
                      );
                    } catch (e) {
                      e;
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, MainPage.routeName);
                  },
                  child: const Text('Skip'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
