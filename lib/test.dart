import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'core/widgets/custom_scaffold/custom_scaffold.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExampleState();
}

class _ExampleState extends State<ExamplePage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) => CustomScaffold(
    title: 'Example',
    body: Column(
      spacing: 10,
      children: [
        Text('Count: $_count'),
        FButton(
          onPress: () => setState(() => _count++),
          suffix: const Icon(FIcons.chevronsUp),
          child: const Text('Increase'),
        ),
        FButton(
            onPress: () => context.go('/auth'),
            child: Text('Auth')
        ),
      ],
    ),
  );
}
