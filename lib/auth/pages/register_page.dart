import 'package:ToGather/auth/models/auth_cred.dart';
import 'package:ToGather/auth/pages/login_page.dart';
import 'package:ToGather/auth/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/auth/pages/auth_page.dart';
import 'package:ToGather/utilities/utilities.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _emailController = TextEditingController();

  Future<bool> _onSubmit() async {
    final result = await AuthService().register(
            fields: AuthFields(
                username: _usernameController.text,
                email: _emailController.text,
                password: _passwordController.text)) ??
        false;
    if (result) {
      await showSylvestSnackbar(
          context: context,
          message: "Hesabın oluşturuldu. Artık giriş yapabilirsin.",
          type: DisplayMessageType.Success);
      closePage(context);
      launchPage(context, LoginPage());
    }
    return result;
  }

  String? _emailError;
  String? _usernameError;
  String? _pass1Error;
  String? _pass2Error;

  bool _passVisible1 = false;
  bool _passVisible2 = false;

  void _onEmailChanged(String value) {
    _emailError = EmailValidator.validate(value)
        ? null
        : LanguageService().data.errors.emailNotValid;
    setState(() {});
  }

  void _onUsernameChanged(String value) {
    _usernameError =
        value.isEmpty ? LanguageService().data.errors.usernameEmpty : null;
    setState(() {});
  }

  void _onPasswordChanged(String value) {
    _pass1Error =
        value.length < 8 ? LanguageService().data.errors.passNotValid : null;
    setState(() {});
  }

  void _onPasswordConfirmationChanged(String value) {
    _pass2Error = value != _passwordController.text
        ? LanguageService().data.errors.pass1NotEQPass2
        : null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AuthPage(
        child: Column(
      children: <Widget>[
        RoundedTextField(
          type: TextInputType.emailAddress,
          prefix: const [
            Icon(Icons.email, color: ThemeService.secondaryText),
            SizedBox(width: 10)
          ],
          controller: _emailController,
          error: _emailError,
          hint: "Email",
          onChanged: _onEmailChanged,
        ),
        const SizedBox(height: 10),
        RoundedTextField(
            prefix: const [
              Icon(Icons.person, color: ThemeService.secondaryText),
              SizedBox(width: 10)
            ],
            type: TextInputType.text,
            controller: _usernameController,
            error: _usernameError,
            onChanged: _onUsernameChanged,
            hint: "Kullanıcı Adı"),
        const SizedBox(height: 10),
        RoundedTextField(
            prefix: const [
              Icon(Icons.vpn_key, color: ThemeService.secondaryText),
              SizedBox(width: 10)
            ],
            type: TextInputType.visiblePassword,
            controller: _passwordController,
            error: _pass1Error,
            obscureText: !_passVisible1,
            onChanged: _onPasswordChanged,
            suffix: [
              GestureDetector(
                onTap: () => setState(() => _passVisible1 = !_passVisible1),
                child: Icon(
                    _passVisible1 ? Icons.visibility : Icons.visibility_off),
              )
            ],
            hint: "Şifre"),
        const SizedBox(height: 10),
        RoundedTextField(
            prefix: const [
              Icon(Icons.check, color: ThemeService.secondaryText),
              SizedBox(width: 10)
            ],
            type: TextInputType.visiblePassword,
            error: _pass2Error,
            obscureText: !_passVisible2,
            controller: _passwordConfirmationController,
            onChanged: _onPasswordConfirmationChanged,
            suffix: [
              GestureDetector(
                onTap: () => setState(() => _passVisible2 = !_passVisible2),
                child: Icon(
                    _passVisible2 ? Icons.visibility : Icons.visibility_off),
              )
            ],
            hint: "Şifre Onayı"),
        const SizedBox(height: 10),
        SylvestButton(
          maximizeLength: true,
          children: [
            Text(
              LanguageService().data.authentication.signUp,
              style: TextStyle(color: ThemeService.onContrastColor),
            )
          ],
          onTap: () => _onSubmit(),
        ),
        //SocialAuthWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              LanguageService().data.authentication.haveAcount,
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            TextButton(
                onPressed: () {
                  closePage(context);
                  launchPage(context, LoginPage());
                },
                child: Text(
                  LanguageService().data.authentication.signIn,
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
