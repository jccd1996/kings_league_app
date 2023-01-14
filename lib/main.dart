import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kings_league_app/data/repository/team_repository.dart';
import 'package:kings_league_app/data/services/api/base_api.dart';
import 'package:kings_league_app/data/services/api/api_service.dart';
import 'package:kings_league_app/data/services/api/team_api.dart';
import 'package:kings_league_app/domain/usecases/team_use_case.dart';
import 'package:kings_league_app/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TeamApi>(
          create: (context) => TeamApiAdapter(
            KingsLeagueService(),
          ),
        ),
        Provider<TeamRepository>(
          create: (context) => TeamRepositoryAdapter(
            context.read<TeamApi>(),
          ),
        ),
        Provider<TeamUseCase>(
          create: (context) => TeamUseCaseAdapter(
            context.read<TeamRepository>(),
          ),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp.router(
          routerConfig: router,
          title: 'Kings League App',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
          ],
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.archivoBlackTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
        ),
      ),
    );
  }
}
