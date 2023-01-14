class Players {
  String? name;
  String? role;
  String? image;

  Players({this.name, this.role, this.image});

  Players.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    role = json['role'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['role'] = role;
    data['image'] = image;
    return data;
  }
}