import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPageWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool scrollable;

  const AppPageWrapper({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: padding,
      child: child,
    );

    if (scrollable) {
      return SingleChildScrollView(
        child: content,
      );
    } else {
      return content;
    }
  }
}
