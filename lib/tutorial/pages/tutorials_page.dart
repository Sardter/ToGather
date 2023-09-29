import 'package:ToGather/tutorial/models/tutorial_data.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialsPage extends StatefulWidget {
  const TutorialsPage(
      {Key? key, this.kvkkToggled = false, this.eulaToggled = false})
      : super(key: key);
  final bool kvkkToggled, eulaToggled;

  @override
  State<TutorialsPage> createState() => _TutorialsPageState();
}

class _TutorialsPageState extends State<TutorialsPage> {
  final _materialColor = ThemeService.eventColor;
  late final _kvkkController = SylvestCheckBoxController(
      onToggle: () => setState(() {}), toggled: widget.kvkkToggled);
  late final _eulaController = SylvestCheckBoxController(
      onToggle: () => setState(() {}), toggled: widget.eulaToggled);

  void _launchLink(String link) {
    launchUrl(Uri.parse(link));
  }

  Widget _image(String image) {
    return SylvestCard(
        boxShadow: Colors.transparent,
        child: ClipRRect(
          borderRadius: ThemeService.allAroundBorderRadius,
          child: SylvestImage(
            image: NetworkImageData(url: image),
            useDefault: false,
            defaultImage: null,
            width: 370,
            height: 370,
          ),
        ));
  }

  Widget _title(String title) {
    return Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: _materialColor,
            fontFamily: ThemeService.headlineFont,
            fontSize: 25));
  }

  PageViewModel _aggreementsPage() {
    return PageViewModel(
      titleWidget: _title("Antlaşmalar"),
      bodyWidget: Column(
        children: [
          SylvestCheckBox(children: [
            InkWell(
              onTap: () => _launchLink(
                  "https://docs.google.com/document/d/1lNfGcCoDtiPzLV5NO0Ho38ElULe1wn8a/edit?usp=share_link&ouid=114329187644032187576&rtpof=true&sd=true"),
              child:
                  Text("Sylvest Gizlilik Politikasını okudum ve onaylıyorum."),
            )
          ], controller: _kvkkController),
          SylvestCheckBox(children: [
            InkWell(
              onTap: () => _launchLink(
                  "https://docs.google.com/document/d/15Wk0mz165T5ICi34AbiiC-9MtIhDuMfh/edit?usp=share_link&ouid=114329187644032187576&rtpof=true&sd=true"),
              child: Text("EULA sözleşmesini okudum ve onaylıyorum."),
            )
          ], controller: _eulaController)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: ThemeService.menuBackground,
        done: Text(LanguageService().data.navigationItems.done,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: ThemeService.headlineFont,
                color: _materialColor)),
        back: Text(LanguageService().data.navigationItems.prev,
            style: TextStyle(
                color: _materialColor, fontFamily: ThemeService.headlineFont)),
        next: Text(LanguageService().data.navigationItems.next,
            style: TextStyle(
                color: _materialColor, fontFamily: ThemeService.headlineFont)),
        onDone: () => closePage(context,
            result: SylvestTutorialData(
                introCompleted: true,
                kvkkAgreed: _kvkkController.toggled.value,
                eulaAgreed: _eulaController.toggled.value)),
        showDoneButton:
            _kvkkController.toggled.value && _eulaController.toggled.value,
        dotsFlex: 2,
        showBackButton: true,
        showNextButton: true,
        pages: [
          ...LanguageService()
              .data
              .tutorialData
              .map((e) => PageViewModel(
                  titleWidget: _title(e.title),
                  body: e.body,
                  image: _image(e.image)))
              .toList(),
          _aggreementsPage()
        ],
      ),
    );
  }
}
