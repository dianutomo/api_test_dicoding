class Album {
  final int? userID;
  final int id;
  final String title;

  const Album({
    required this.userID,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(userID: json['userID'], id: json['id'], title: json['title']);
  }
}
