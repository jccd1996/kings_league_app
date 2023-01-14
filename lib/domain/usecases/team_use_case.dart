import 'package:kings_league_app/data/repository/team_repository.dart';
import 'package:kings_league_app/domain/models/team.dart';

abstract class TeamUseCase {
  Future<List<Team>> getTeams();
}

class TeamUseCaseAdapter extends TeamUseCase{
  TeamUseCaseAdapter(this._repository);
  final TeamRepository _repository;

  @override
  Future<List<Team>> getTeams() {
    return _repository.getTeams();
  }
}