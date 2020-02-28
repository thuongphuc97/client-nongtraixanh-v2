class Tour {
  final int id;
  final String title;
  final String imagesUrl;
  Tour({ this.id, this.title,this.imagesUrl});

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['id'],
      title: json['title'],
      imagesUrl:json['imagesUrl'],
    );
  }
}