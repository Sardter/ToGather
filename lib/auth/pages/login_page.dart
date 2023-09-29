import 'package:ToGather/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passVisible = false;

  Future<bool> _onSubmit(context) async {
    final result = await AuthService().login(
            fields: AuthFields(
                username: _usernameController.text,
                email: null,
                password: _passwordController.text)) ??
        false;
    if (result) closePage(context);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return AuthPage(
        child: Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            RoundedTextField(
                prefix: const [
                  Icon(Icons.person, color: ThemeService.secondaryText),
                  SizedBox(width: 10)
                ],
                type: TextInputType.text,
                controller: _usernameController,
                hint: "Kullanıcı Adı"),
            const SizedBox(height: 10),
            RoundedTextField(
                prefix: const [
                  Icon(Icons.vpn_key, color: ThemeService.secondaryText),
                  SizedBox(width: 10)
                ],
                suffix: [
                  GestureDetector(
                    onTap: () => setState(() => _passVisible = !_passVisible),
                    child: Icon(
                        _passVisible ? Icons.visibility : Icons.visibility_off),
                  )
                ],
                obscureText: !_passVisible,
                type: TextInputType.visiblePassword,
                controller: _passwordController,
                hint: "Şifre")
          ],
        ),
        const SizedBox(height: 20),
        Container(
          //margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          height: 40,
          child: SylvestButton(
            maximizeLength: true,
            children: [
              Text(
                LanguageService().data.authentication.signIn,
                style: TextStyle(color: ThemeService.onContrastColor),
              )
            ],
            onTap: () => _onSubmit(context),
          ),
        ),
        const SizedBox(height: 20),
        Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => launchPage(context, ForgotPasswordPage()),
              child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                  child: Text(
                    "     " +
                        LanguageService().data.authentication.forgotPassword,
                    style:
                        TextStyle(color: ThemeService.eventColor, fontSize: 11),
                  )),
            )),
        //SocialAuthWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              LanguageService().data.authentication.dontHaveAcount,
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            TextButton(
                onPressed: () {
                  closePage(context);
                  launchPage(context, RegisterPage());
                },
                child: Text(
                  LanguageService().data.authentication.signUp,
                  style: TextStyle(
                      fontSize: 11,
                      color: ThemeService.eventColor,
                      fontWeight: FontWeight.w700),
                ))
          ],
        )
      ],
    ));
  }
}
