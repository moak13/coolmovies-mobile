class Review {
  String? title;
  String? body;
  int? rating;

  Review({
    this.title,
    this.body,
    this.rating,
  });

  Review.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    data['rating'] = rating;
    return data;
  }
}
