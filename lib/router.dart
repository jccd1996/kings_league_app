import 'package:go_router/go_router.dart';
import 'package:kings_league_app/ui/features/choose_team/choose_team_page.dart';
import 'package:kings_league_app/ui/features/splash/splash_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: SplashPage.route,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: ChooseTeamPage.route,
      builder: (context, state) => ChooseTeamPage.create(),
    ),
  ],
);
