import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// A simple overlay loading indicator.
/// This is a shared component used across different modules.
class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: FProgress.circularIcon());
  }
}
