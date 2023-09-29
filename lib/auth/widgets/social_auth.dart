import 'package:ToGather/auth/auth.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';

class SocialAuthWidget extends StatefulWidget {
  const SocialAuthWidget({super.key});

  @override
  State<SocialAuthWidget> createState() => _SocialAuthWidgetState();
}

class _SocialAuthWidgetState extends State<SocialAuthWidget> {
  Future<bool> _onGoogleLogin() async {
    AuthService().signInWithGoogle();
    return false;
  }

  Future<bool> _onFacebookLogin() async {
    AuthService().signInWithFacebook();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
                child: Divider(
              indent: 10,
              endIndent: 10,
            )),
            Text(
              "Ya da",
              style: TextStyle(color: ThemeService.secondaryText),
            ),
            Expanded(
                child: Divider(
              indent: 10,
              endIndent: 10,
            )),
          ],
        ),
        const SizedBox(height: 20),
        SylvestButton(
            maximizeLength: true,
            color: ThemeService.menuBackground,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  "assets/images/google-logo.png",
                  width: 30,
                  height: 30,
                ),
              ),
              SizedBox(width: 10),
              Text("Google ile Giriş Yap", style: TextStyle())
            ],
            onTap: _onGoogleLogin),
        const SizedBox(height: 5),
        SylvestButton(
            maximizeLength: true,
            color: Colors.blue,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  "assets/images/facebook-logo.png",
                  width: 30,
                  height: 30,
                ),
              ),
              SizedBox(width: 10),
              Text("Facebook ile Giriş Yap",
                  style: TextStyle(color: ThemeService.onContrastColor))
            ],
            onTap: _onFacebookLogin)
      ],
    );
  }
}
