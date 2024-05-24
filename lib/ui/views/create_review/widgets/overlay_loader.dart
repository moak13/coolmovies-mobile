import 'package:coolmovies/ui/widgets/busy_widget.dart';
import 'package:flutter/material.dart';

class OverlayLoader extends StatelessWidget {
  final bool isBusy;
  final Widget child;
  const OverlayLoader({
    super.key,
    this.isBusy = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [child];
    if (isBusy) {
      children.add(const BusyWidget());
    }
    return Stack(
      children: children,
    );
  }
}
