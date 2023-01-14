import 'package:kings_league_app/data/services/api/api_service.dart';
import 'package:kings_league_app/domain/models/team.dart';

abstract class TeamApi {
  Future<List<Team>> getTeams();
}

class TeamApiAdapter extends TeamApi {
  TeamApiAdapter(this.kingsApi);

  final KingsLeagueService kingsApi;

  @override
  Future<List<Team>> getTeams() {
    var response = kingsApi.getApi('teams',
        (teams) => (teams as List).map((e) => Team.fromJson(e)).toList());
    return response;
  }
}
