import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:restomaknyus/ViewModel/auth_providers.dart';
import '../Utils/buttons.dart';
import '../Utils/colors.dart';
import '../Utils/custom_text_field.dart';
import '../Utils/strings.dart';
import '../Utils/assets.dart';
import '../Utils/spaces.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _toggleVisibility = true;
  bool isValidEmail = false;
  bool isOnchange = false;
  bool isOnchangePassword = false;
  bool isValidPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 124.0,
          vertical: 20.0,
        ),
        children: [
          const SpaceHeight(
            80.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 130.0,
            ),
            child: SvgPicture.asset(
              AppAsset.iconHome,
              width: 100,
              height: 100,
              color: CustomColor.primary,
            ),
          ),
          const SpaceHeight(
            24.0,
          ),
          Center(
            child: Text(
              Strings.appName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SpaceHeight(
            8.0,
          ),
          Center(
            child: Text(
              Strings.akses,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
          const SpaceHeight(
            40.0,
          ),
          CustomTextField(
            controller: emailController,
            label: Strings.email,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              setState(() {
                isValidEmail = false;
                isOnchange = true;
              });
              RegExp regex =
                  RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
              bool isEmailValid = regex.hasMatch(value);
              if (isEmailValid) {
                setState(() {
                  isValidEmail = true;
                });
              }
            },
            validator: (value) {
              if (value!.isEmpty && isOnchange) {
                return Strings.isi;
              }
              if (!isValidEmail && isOnchange) {
                return Strings.format;
              }
            },
          ),
          const SpaceHeight(
            12.0,
          ),
          CustomTextField(
            controller: passwordController,
            label: Strings.password,
            obscureText: _toggleVisibility,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _toggleVisibility = !_toggleVisibility;
                });
              },
              icon: _toggleVisibility
                  ? const Icon(
                      Icons.visibility_off,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.visibility,
                      color: Colors.black,
                    ),
            ),
            validator: (value) {
              if (value!.isEmpty && isOnchangePassword) {
                return Strings.isi;
              } else {
                return null;
              }
            },
            onChanged: (value) {
              if (value!.isEmpty) {
                setState(() {
                  isValidPassword = false;
                });
                return;
              }
              setState(() {
                isValidPassword = true;
                isOnchangePassword = true;
              });
            },
          ),
          const SpaceHeight(
            24.0,
          ),
          Consumer<AuthProviders>(
            builder: (context, value, child) {
              return Button.filled(
                label: Strings.masuk,
                onPressed: () {
                  value.login(
                    context: context,
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
