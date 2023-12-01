import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/button/app_icon_text_button_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';

class AppInfoPage extends StatefulWidget {
  final Future<bool?> shouldShow;
  final Widget Function() nextPage;
  final Function() onAccept;
  final Widget? child;

  const AppInfoPage({super.key, required this.shouldShow, required this.nextPage, required this.onAccept, this.child});

  @override
  State<AppInfoPage> createState() => _AppInfoPageState();
}

class _AppInfoPageState extends State<AppInfoPage> {
  late Widget _displayedWidget = Container();

  @override
  void initState() {
    super.initState();
    widget.shouldShow.then((shown) {
      if (shown ?? false) {
        _openNextPage(context);
      } else {
        setState(() => _displayedWidget = _root());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _displayedWidget;
  }

  Widget _root() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [_infoArea(context), _buttonArea(context)],
      ),
    );
  }

  Widget _infoArea(BuildContext context) {
    return Expanded(
        child: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppLayoutConfig.defaultSpacing),
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppLayoutConfig.pageInfoContentMaxWidth),
              child: widget.child),
        ),
      ),
    ));
  }

  Widget _buttonArea(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppLayoutConfig.defaultSpacing),
      child: AppIconTextButtonComponent(
        onTap: () {
          widget.onAccept.call();
          _openNextPage(context);
        },
        type: AppButtonTypeEnum.primary,
        icon: Icons.check,
        text: "Alles klar",
      ),
    );
  }

  void _openNextPage(BuildContext context) {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => widget.nextPage.call(),
        ));
  }
}
