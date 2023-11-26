import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AppLoadingComponent extends StatelessWidget {
  final double size;

  const AppLoadingComponent({super.key, this.size = 25});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: const RiveAnimation.asset("assets/rive/icon-loading.riv"),
    );
  }
}
