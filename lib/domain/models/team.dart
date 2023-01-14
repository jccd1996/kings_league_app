import 'package:kings_league_app/domain/models/coach.dart';
import 'package:kings_league_app/domain/models/players.dart';

class Team {
  String? id;
  String? color;
  String? name;
  String? image;
  String? imageWhite;
  String? url;
  String? presidentId;
  String? channel;
  List<String>? socialNetworks;
  List<Players>? players;
  String? coach;
  String? shortName;
  CoachInfo? coachInfo;

  Team(
      {this.id,
        this.color,
        this.name,
        this.image,
        this.imageWhite,
        this.url,
        this.presidentId,
        this.channel,
        this.socialNetworks,
        this.players,
        this.coach,
        this.shortName,
        this.coachInfo});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
    name = json['name'];
    image = json['image'];
    imageWhite = json['imageWhite'];
    url = json['url'];
    presidentId = json['presidentId'];
    channel = json['channel'];
    socialNetworks = json['socialNetworks'].cast<String>();
    if (json['players'] != null) {
      players = <Players>[];
      json['players'].forEach((v) {
        players!.add(Players.fromJson(v));
      });
    }
    coach = json['coach'];
    shortName = json['shortName'];
    coachInfo = json['coachInfo'] != null
        ? CoachInfo.fromJson(json['coachInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['color'] = color;
    data['name'] = name;
    data['image'] = image;
    data['imageWhite'] = imageWhite;
    data['url'] = url;
    data['presidentId'] = presidentId;
    data['channel'] = channel;
    data['socialNetworks'] = socialNetworks;
    if (players != null) {
      data['players'] = players!.map((v) => v.toJson()).toList();
    }
    data['coach'] = coach;
    data['shortName'] = shortName;
    if (coachInfo != null) {
      data['coachInfo'] = coachInfo!.toJson();
    }
    return data;
  }
}

