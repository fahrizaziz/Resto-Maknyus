import 'dart:async';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_view/splash_view.dart';
import 'package:provider/provider.dart';
import '../Utils/colors.dart';
import '../Utils/routes.dart';
import '../Utils/strings.dart';
import '../ViewModel/auth_providers.dart';
import '../Utils/assets.dart';
import 'login_screens.dart';
import 'main_screens.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  late Timer _checkLoginTimeOut;
  @override
  void initState() {
    _checkLoginTimeOut = Timer(
      const Duration(seconds: 3),
      () => PageNavigator(ctx: context).nextPage(
        page: const LoginScreens(),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _checkLoginTimeOut.cancel();
    super.dispose();
  }

  Future<bool?> _checkLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String email = prefs.getString('user' 'email') ?? '';
    String password = prefs.getString('user' 'password') ?? '';

    if (_checkLoginTimeOut.isActive) {
      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );
      AuthProviders authProvider = Provider.of(
        context,
        listen: false,
      );
      final isLogin = await authProvider.checkLogin();
      if (isLogin == true) {
        bool isTokenExpired = JwtDecoder.isExpired(token);
        if (!isTokenExpired) {
          PageNavigator(ctx: context).nextPage(
            page: const MainScreens(),
          );
        } else {
          final authProvider = Provider.of<AuthProviders>(
            context,
            listen: false,
          );
          await authProvider.login(
            email: email,
            password: password,
            context: context,
          );
        }
      } else {
        PageNavigator(ctx: context).nextPage(
          page: const LoginScreens(),
        );
      }
      _checkLoginTimeOut.cancel();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _checkLogin(context);
    });
    return Scaffold(
      body: SplashView(
        backgroundColor: CustomColor.bg,
        title: Padding(
          padding: EdgeInsets.only(
            top: (ResponsiveBreakpoints.of(context).smallerThan(TABLET))
                ? 40
                : 100,
          ),
          child: Text(
            Strings.appName,
            style: const TextStyle(
              fontSize: 40,
              color: CustomColor.colorAppName,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        subtitle: Text(
          Strings.deskripsiApp,
          style: const TextStyle(
            fontSize: 16,
            color: CustomColor.colorAppName,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        bottomLoading: true,
        logo: Image.asset(
          AppAsset.logo,
          fit: BoxFit.cover,
          height: (ResponsiveBreakpoints.of(context).smallerThan(TABLET))
              ? 120
              : 183,
          width: (ResponsiveBreakpoints.of(context).smallerThan(TABLET))
              ? 120
              : 183,
        ),
      ),
    );
  }
}
