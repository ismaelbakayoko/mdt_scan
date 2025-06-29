//info en ligne sans espace between
import 'dart:ui';

import 'package:flutter/material.dart';

class WdgInfoLigne extends StatelessWidget {
  final String title, value;
  final Color? color;
  const WdgInfoLigne({
    super.key,
    required this.title,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black),
        children: [
          TextSpan(text: title),
          TextSpan(
            text: value.toString(),
            style: TextStyle(
                color: color ?? Colors.orange.shade700,
                fontWeight: FontWeight.w600,
                fontSize: 16),
          )
        ],
      ),
    );
  }
}