import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restomaknyus/ViewModel/auth_providers.dart';
import 'package:restomaknyus/Widgets/nav_item.dart';
import '../Utils/colors.dart';
import '../Utils/context.dart';
import '../Utils/assets.dart';
import '../Utils/routes.dart';
import 'home_screens.dart';
import 'login_screens.dart';
import 'setting_screens.dart';
import 'report_screens.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({super.key});

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreens(),
    const ReportScreens(),
    const SettingScreens(),
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            SingleChildScrollView(
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(
                    16.0,
                  ),
                ),
                child: SizedBox(
                  height: context.deviceHeight - 20.0,
                  child: ColoredBox(
                    color: CustomColor.primary,
                    child: Column(
                      children: [
                        NavItem(
                          iconPath: AppAsset.iconHome,
                          isActive: _selectedIndex == 0,
                          onTap: () => _onItemTapped(0),
                        ),
                        NavItem(
                          iconPath: AppAsset.iconReport,
                          isActive: _selectedIndex == 1,
                          onTap: () => _onItemTapped(1),
                        ),
                        NavItem(
                          iconPath: AppAsset.iconSetting,
                          isActive: _selectedIndex == 2,
                          onTap: () => _onItemTapped(2),
                        ),
                        Consumer<AuthProviders>(
                          builder: (context, value, child) {
                            return NavItem(
                              iconPath: AppAsset.iconLogout,
                              isActive: false,
                              onTap: () {
                                value.logout();
                                PageNavigator(ctx: context).pushPage(
                                  page: const LoginScreens(),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
