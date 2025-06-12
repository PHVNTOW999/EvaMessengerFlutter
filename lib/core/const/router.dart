import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:eva_messenger_flutter/test.dart';

import '../../modules/auth/auth.dart';

final GoRouter router = GoRouter(
  initialLocation: '/auth',
  routes: [
    ...AuthModule.routes,
    GoRoute(path: '/', builder: (context, state) => ExamplePage()),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Error')),
    body: Center(child: Text('Page not found: ${state.error}')),
  ),
);
