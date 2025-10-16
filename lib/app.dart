import 'package:flutter/material.dart';
import 'package:portfolio_web/app_controller.dart';
import 'package:portfolio_web/material/app.dart' as material;

class App extends StatelessWidget {
  const App({super.key});

  static final controller = AppController();
  @override
  Widget build(BuildContext context) {
    switch (App.controller.appStyle) {
      case AppStyle.material:
        return const material.App();
      case AppStyle.cupertino:
        return const material.App(); // TODO: Replace with CupertinoApp
    }
  }
}
