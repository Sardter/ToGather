import 'package:flutter/material.dart';
import 'package:ToGather/utilities/services/language.dart';
import 'package:ToGather/utilities/services/theme.dart';
import 'package:ToGather/utilities/widgets/app_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
        title: LanguageService().data.pages.authentication,
        body: ListView(
          children: <Widget>[
            const SizedBox(height: 50),
            Image.asset(
              "assets/images/sylvest_icon.png",
              width: 150,
              height: 150,
            ),
            Text.rich(
              
              TextSpan(
                
                style: TextStyle(
                    
                    fontSize: 25, fontFamily: ThemeService.headlineFont),
                children: [
                  TextSpan(
                      text: "To",
                      style: TextStyle(color: ThemeService.eventColor)),
                  TextSpan(
                    text: "Gather",
                  )
                ]), textAlign: TextAlign.center,),
            Container(
              margin: const EdgeInsets.all(15),
              child: widget.child,
            )
          ],
        ));
  }
}
