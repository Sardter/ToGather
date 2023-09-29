import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';

class SylvestButton extends StatefulWidget {
  const SylvestButton(
      {Key? key,
      required this.children,
      this.maximizeLength = false,
      this.enabled = true,
      this.color = ThemeService.eventColor,
      this.initialActivation = false,
      required this.onTap})
      : super(key: key);
  final List<Widget> children;
  final bool maximizeLength;
  final bool enabled;
  final bool initialActivation;
  final Future<bool> Function()? onTap;
  final Color color;

  @override
  State<SylvestButton> createState() => _SylvestButtonState();
}

class _SylvestButtonState extends State<SylvestButton> {
  late bool _activited = widget.initialActivation;
  bool _busy = false;

  Future<void> _onTap() async {
    setState(() {
      _busy = true;
    });
    final result = await widget.onTap!();
    if (mounted)
      setState(() {
        _activited = result;
        _busy = false;
      });
  }

  Row _child() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: widget.maximizeLength ? MainAxisSize.max : MainAxisSize.min,
      children: _busy ? [LoadingIndicator(radius: 5)] : widget.children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 600),
      child: _activited || _busy
          ? OutlinedButton(
              onPressed: !widget.enabled
                  ? null
                  : widget.onTap != null
                      ? _onTap
                      : null,
              child: _child(),
              style: OutlinedButton.styleFrom(
                  foregroundColor: widget.color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))))
          : ElevatedButton(
              onPressed: !widget.enabled
                  ? null
                  : widget.onTap != null
                      ? _onTap
                      : null,
              child: _child(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: widget.color,
                  foregroundColor: ThemeService.onContrastColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)))),
    );
  }
}
