import 'package:kings_league_app/data/services/api/base_api.dart';

abstract class ApiService with BaseApi {
  String? _baseUrl;

  @override
  String? get baseUrl => _baseUrl;

  ApiService() {
    _baseUrl = 'https://api.kingsleague.dev/';
  }
}

class KingsLeagueService extends ApiService {}
