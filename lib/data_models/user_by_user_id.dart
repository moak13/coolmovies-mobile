class UserByUserId {
  String? id;
  String? name;
  String? nodeId;

  UserByUserId({
    this.id,
    this.name,
    this.nodeId,
  });

  UserByUserId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nodeId = json['nodeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['nodeId'] = nodeId;
    return data;
  }
}
