import 'package:ToGather/users/users.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:ToGather/utilities/utilities.dart';

class CreateModelPage<T extends Model> extends StatefulWidget {
  const CreateModelPage(
      {super.key,
      required this.controller,
      required this.segments,
      required this.warningsController,
      required this.buttonChildren,
      required this.pageTitle,
      required this.detailPage,
      this.errorMessage = "Paylaşım tamamlanamadı",
      this.successMessage = "Paylaşıldı!"});
  final BuilderPublisher<T> controller;
  final BuilderWarningsController warningsController;
  final List<CreatePageSegment> Function(Profile user) segments;
  final List<Widget> buttonChildren;
  final String pageTitle;
  final Widget Function(T item) detailPage;
  final String errorMessage;
  final String successMessage;

  @override
  State<CreateModelPage<T>> createState() => _CreateModelPageState<T>();
}

class _CreateModelPageState<T extends Model> extends State<CreateModelPage<T>> {
  List<CreatePageSegment> _segments = [];
  Profile? _user;
  bool _isLoading = false;

  Future<void> _getUser() async {
    _isLoading = true;
    setState(() {});
    _user = await ModelServiceFactory.PROFILE.getCurrentUser(context);

    if (_user != null) _segments = widget.segments(_user!);

    _isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getUser();
    });
  }

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: widget.pageTitle,
      body: _user == null
          ? Container(
              child: Text("Önce giriş yapman lazım",
                  style: TextStyle(color: ThemeService.secondaryText)),
            )
          : BuilderWarnings(
              controller: widget.warningsController,
              builder: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ListView(
                    children: [
                      StickyHeader(
                          header: CreatePageSegmentIndicators(
                            segments: _segments,
                            selectedIndex: _selectedPage,
                            onSelect: (index) => setState(() {
                              _selectedPage = index;
                            }),
                          ),
                          content: _segments[_selectedPage]),
                      const SizedBox(height: 60)
                    ],
                  ),
                  SylvestCard(
                      margin: EdgeInsets.zero,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(ThemeService.borderRadiusValue)),
                      padding: const EdgeInsets.all(10),
                      background: ThemeService.eventColor,
                      height: 60,
                      child: InkWell(
                        onTap: _isLoading
                            ? null
                            : () async {
                                _isLoading = true;
                                setState(() {});
                                final item = await widget.controller.onDone();

                                await showSylvestSnackbar(
                                    context: context,
                                    message: item == null
                                        ? widget.errorMessage
                                        : widget.successMessage,
                                    type: item == null
                                        ? DisplayMessageType.Danger
                                        : DisplayMessageType.Success);

                                if (item != null) {
                                  closePage(context);
                                  launchPage(
                                      context,
                                      (widget.detailPage)(item));
                                }
                                _isLoading = false;
                                setState(() {});
                              },
                        child: _isLoading
                            ? LoadingIndicator()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: widget.buttonChildren,
                              ),
                      ))
                ],
              ),
            ),
    );
  }
}
