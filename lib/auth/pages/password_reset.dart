import 'package:ToGather/auth/models/auth_cred.dart';
import 'package:ToGather/auth/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/auth/pages/auth_page.dart';
import 'package:ToGather/utilities/utilities.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage();

  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  Future<bool> _onSubmit(context) async {
    final response = await AuthService().resetPassword(
            fields: AuthFields(
                username: null,
                email: _emailController.text,
                password: null)) ??
        false;

    await showSylvestSnackbar(
        context: context,
        type: response ? DisplayMessageType.Success : DisplayMessageType.Danger,
        message: response
            ? LanguageService().data.alerts.sentPasswordReset
            : LanguageService().data.errors.passwordResetFailed);

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return AuthPage(
        child: ListView(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: ThemeService.textField,
              //border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: ThemeService.eventColor,
                    ),
                    focusedBorder: InputBorder.none,
                    labelText: LanguageService().data.authentication.email,
                    enabledBorder: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.grey)),
              )
            ],
          ),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => closePage(context),
              child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                  child: Text(
                    LanguageService().data.authentication.haveAcount,
                    style:
                        TextStyle(color: ThemeService.eventColor, fontSize: 11),
                  )),
            )),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          height: 40,
          child: SylvestButton(
            children: [Text(LanguageService().data.authentication.reset)],
            onTap: () => _onSubmit(context),
          ),
        ),
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
                  Navigator.pushNamed(context, '/register');
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
