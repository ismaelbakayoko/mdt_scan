import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WdgLoading extends StatelessWidget {
  const WdgLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GFLoader(
        size: GFSize.LARGE,
        type: GFLoaderType.circle,
        loaderColorOne: Colors.cyan.shade700,
        loaderColorTwo: Colors.deepOrange,
        loaderColorThree: Colors.green.shade700,
      ),
    );
  }
}
