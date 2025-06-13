import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:eva_messenger_flutter/test.dart';

import '../../modules/auth/auth.dart';

final GoRouter router = GoRouter(
  // Init
  initialLocation: '/',
  // Routes
  routes: [
    GoRoute(path: '/', builder: (context, state) => ExamplePage()),
    ...AuthModule.routes,
  ],
  // Middleware
  redirect: (context, state) {
    final authState = getIt<AuthBloc>().state;

    if (authState is AuthSuccess && state.fullPath == '/auth') {
      return '/';
    }

    if (authState is Unauthenticated && state.fullPath != '/auth') {
      return '/auth';
    }

    return null;
  },
  // Error page
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Error')),
    body: Center(child: Text('Page not found: ${state.error}')),
  ),
);
