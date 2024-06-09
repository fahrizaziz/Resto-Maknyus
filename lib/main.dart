import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'View/splash_screens.dart';
import 'ViewModel/auth_providers.dart';
import 'ViewModel/product_providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProviders(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProviders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, widget) => ResponsiveBreakpoints.builder(
          child: widget!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
        home: const SplashScreens(),
      ),
    );
  }
}
