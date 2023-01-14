import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kings_league_app/domain/models/team.dart';
import 'package:kings_league_app/domain/usecases/team_use_case.dart';
import 'package:kings_league_app/ui/features/choose_team/choose_team_provider.dart';
import 'package:kings_league_app/ui/features/choose_team/choose_team_theme.dart';
import 'package:kings_league_app/ui/kings_league_palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ChooseTeamPage extends StatefulWidget {
  static ChangeNotifierProvider<ChooseTeamProvider> create({Key? key}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => ChooseTeamProvider(
          teamUseCase: context.read<TeamUseCase>(),
        )..getTeams(),
        child: ChooseTeamPage._(key: key),
      );

  const ChooseTeamPage._({super.key});

  static const route = '/chooseTeam';

  @override
  State<ChooseTeamPage> createState() => _ChooseTeamPageState();
}

class _ChooseTeamPageState extends State<ChooseTeamPage> {
  final PageController _pageController = PageController(viewportFraction: 0.7);
  final ValueNotifier<double?> _pageNotifier = ValueNotifier(0.0);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.addListener(_listener);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listener);
    _pageController.dispose();
    super.dispose();
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
        child: SafeArea(
          child: FutureBuilder<List<Team>>(
            future: context.read<ChooseTeamProvider>().teams,
            builder: (context, teamsSnapshot) {
              if (teamsSnapshot.hasData) {
                return Column(
                  children: [
                    const SizedBox(
                      height: ChooseTeamTheme.mediumSize,
                    ),
                    Text(
                      AppLocalizations.of(context)!.chooseYourTeam,
                      style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: ChooseTeamTheme.smallSize),
                    Expanded(
                      child: ValueListenableBuilder<double?>(
                        valueListenable: _pageNotifier,
                        builder: (context, snapshot, _) {
                          return PageView.builder(
                            itemCount: teamsSnapshot.data!.length,
                            controller: _pageController,
                            itemBuilder: (context, index) {
                              final lerp = lerpDouble(
                                  0, 1, (index - _pageNotifier.value!).abs())!;

                              double opacity = lerpDouble(0.0, 0.5,
                                  (index - _pageNotifier.value!).abs())!;
                              if (opacity > 1.0) opacity = 1.0;
                              if (opacity < 0.0) opacity = 0.0;
                              final team = teamsSnapshot.data![index];
                              return Transform.translate(
                                offset: Offset(0.0, lerp * 50),
                                child: Opacity(
                                  opacity: (1 - opacity),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: ChooseTeamTheme.largeSize,
                                        height: ChooseTeamTheme.largeSize,
                                        child: SvgPicture.network(
                                          team.image!,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: ChooseTeamTheme.bigSize,
                                      ),
                                      Text(
                                        team.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: ChooseTeamTheme.mediumSize,
                      ),
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: teamsSnapshot.data!.length,
                        effect: const JumpingDotEffect(
                          dotHeight: ChooseTeamTheme.smallSize,
                          dotWidth: ChooseTeamTheme.smallSize,
                          activeDotColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  void _listener() {
    _pageNotifier.value = _pageController.page;
    setState(() {});
  }
}
