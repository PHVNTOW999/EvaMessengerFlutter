import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class Header extends StatelessWidget {
  final String title;

  const Header({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FHeader(title: Text(title));
  }
}
