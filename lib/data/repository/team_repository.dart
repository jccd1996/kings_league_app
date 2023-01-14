import 'package:kings_league_app/data/services/api/team_api.dart';
import 'package:kings_league_app/domain/models/team.dart';

abstract class TeamRepository {
  Future<List<Team>> getTeams();
}

class TeamRepositoryAdapter extends TeamRepository {
  TeamRepositoryAdapter(this._api);

  final TeamApi _api;

  @override
  Future<List<Team>> getTeams() {
    return _api.getTeams();
  }
}
