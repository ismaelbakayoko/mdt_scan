import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WdgRoundButton extends StatelessWidget {
  final String title;
  final double buttonSize, elevation, titleSize, borderRadius;
  final Color buttonColor, titleColor;
  final bool transparent;
  final Icon? icon;
  final void Function()? onPressed;
  const WdgRoundButton({
    super.key,
    required this.title,
    this.titleSize = 25,
    this.buttonSize = 50,
    this.icon,
    this.elevation = 2,
    this.borderRadius = 50,
    this.buttonColor = const Color(0xFF193948),
    this.transparent = false,
    required this.onPressed,
    this.titleColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: onPressed,
      text: title,
      elevation: elevation,
      textStyle: TextStyle(
        fontSize: titleSize,
        fontWeight: FontWeight.w600,
        color: transparent ? buttonColor : titleColor,
      ),
      size: buttonSize,
      color: buttonColor,
      type: transparent ? GFButtonType.outline2x : GFButtonType.solid,
      shape: GFButtonShape.pills,
      fullWidthButton: true,
      borderShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      icon: icon,
    );
  }
}
