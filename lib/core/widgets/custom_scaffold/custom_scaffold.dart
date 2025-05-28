import 'package:eva_messenger_flutter/core/widgets/custom_scaffold/components/header.dart';
import 'package:eva_messenger_flutter/core/widgets/custom_scaffold/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String? title;

  // final int pageIndex;
  // final String? backBtnPath;
  // final Widget? floatingActionButton;
  // final Widget? bottomNavigationBar;
  // final Widget? drawer;

  const CustomScaffold({
    required this.body,
    this.title,
    // required this.pageIndex,
    // this.backBtnPath,
    // this.floatingActionButton,
    // this.bottomNavigationBar,
    // this.drawer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: title != null ? Header(title: title!) : null,
      footer: Navbar(),
      child: body,
    );
  }
}
