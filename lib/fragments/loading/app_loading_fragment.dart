import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AppLoadingFragment extends StatelessWidget {
  final double size;

  const AppLoadingFragment({super.key, this.size = 25});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: const RiveAnimation.asset("assets/rive/icon-loading.riv"),
    );
  }
}
