import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praxis_client/paths/index.dart';
import 'package:praxis_client/paths/index_shell.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'paths/bills/bills.dart';
import 'paths/bills/bills_shell.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '',
      routes: [
        ShellRoute(
          builder: (context, state, child) => IndexShell(child: child),
          routes: [
            GoRoute(
              path: "/",
              name: "index.index",
              builder: (_, __) => const Index(),
            ),
            ShellRoute(
              builder: (context, state, child) => BillsShell(child: child),
              routes: [
                GoRoute(
                  path: '/bills',
                  name: 'bills.index',
                  builder: (_, __) => const Bills(),
                ),
              ],
            ),
          ],
        ),
      ],
    );

    return shadcn.ShadcnApp.router(
      title: 'CivicLens',
      theme: shadcn.ThemeData(
        radius: 0.5,
        colorScheme: shadcn.ColorSchemes.darkZinc(),
      ),
      routerConfig: router,
    );
  }
}
