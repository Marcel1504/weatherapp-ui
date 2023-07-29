import 'package:flutter/material.dart';

class AppDetailDataPage extends StatelessWidget {
  final Widget child;
  final String? title;

  const AppDetailDataPage({super.key, required this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: child,
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(title ?? ""),
      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
