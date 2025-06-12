import 'package:eva_messenger_flutter/modules/auth/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupDependencies();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FThemes.blue.dark;

    return MaterialApp(
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
      builder: (_, child) => FTheme(data: theme, child: child!),
      theme: theme.toApproximateMaterialTheme(),
      home: AuthPage(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int _count = 0;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: [
        Text('Count: $_count'),
        FButton(
          onPress: () => setState(() => _count++),
          suffix: const Icon(FIcons.chevronsUp),
          child: const Text('Increase'),
        ),
        // Add other global BLoC providers here if needed
      ],
    ),
  );
}
