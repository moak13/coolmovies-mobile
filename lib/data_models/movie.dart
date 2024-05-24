import 'user_by_user_creator_id.dart';

class Movie {
  String? id;
  String? imgUrl;
  String? movieDirectorId;
  String? userCreatorId;
  String? title;
  String? releaseDate;
  String? nodeId;
  UserByUserCreatorId? userByUserCreatorId;

  Movie({
    this.id,
    this.imgUrl,
    this.movieDirectorId,
    this.userCreatorId,
    this.title,
    this.releaseDate,
    this.nodeId,
    this.userByUserCreatorId,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgUrl = json['imgUrl'];
    movieDirectorId = json['movieDirectorId'];
    userCreatorId = json['userCreatorId'];
    title = json['title'];
    releaseDate = json['releaseDate'];
    nodeId = json['nodeId'];
    userByUserCreatorId = json['userByUserCreatorId'] != null
        ? UserByUserCreatorId.fromJson(json['userByUserCreatorId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['imgUrl'] = imgUrl;
    data['movieDirectorId'] = movieDirectorId;
    data['userCreatorId'] = userCreatorId;
    data['title'] = title;
    data['releaseDate'] = releaseDate;
    data['nodeId'] = nodeId;
    if (userByUserCreatorId != null) {
      data['userByUserCreatorId'] = userByUserCreatorId!.toJson();
    }
    return data;
  }
}
