import 'package:apod/styles/illustration.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  static Page page({LocalKey? key}) {
    return MaterialPage<void>(
      key: key,
      child: const SplashPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 16 / 5,
            child: nasal_logo,
          ),
          const SizedBox(height: 24.0),
          Text(
            'Initializing...',
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      )),
    );
  }
}
