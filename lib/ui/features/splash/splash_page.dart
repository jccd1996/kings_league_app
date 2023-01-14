import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kings_league_app/ui/assets.dart';
import 'package:kings_league_app/ui/features/choose_team/choose_team_page.dart';
import 'package:kings_league_app/ui/features/splash/splash_theme.dart';
import 'package:kings_league_app/ui/kings_league_palette.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const route = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _handleSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: KingsLeaguePalette.orangeRedGradient,
          ),
        ),
        child: Center(
          child: SizedBox(
            height: SplashTheme.logoHeight,
            width: SplashTheme.logoWidth,
            child: SvgPicture.asset(
              Assets.logo,
            ),
          ),
        ),
      ),
    );
  }

  void _handleSplash() {
    Future.delayed(const Duration(seconds: 3),(){
      context.go(ChooseTeamPage.route);
    });
  }
}
