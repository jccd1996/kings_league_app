import 'package:flutter/material.dart';
import 'package:kings_league_app/domain/models/team.dart';
import 'package:kings_league_app/domain/usecases/team_use_case.dart';

class ChooseTeamProvider extends ChangeNotifier {
  ChooseTeamProvider({this.teamUseCase});
  final TeamUseCase? teamUseCase;

  late Future<List<Team>> teams;

  Future<List<Team>> getTeams() async{
    teams = teamUseCase!.getTeams();
    return teams;
  }
}
