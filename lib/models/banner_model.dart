class Slide {
  int iD;
  String name;
  String url;
  String position;
  String img;
  int orders;
  String createdAt;
  int createdBy;
  String updatedAt;
  int updatedBy;
  int status;

  Slide(
      {this.iD,
      this.name,
      this.url,
      this.position,
      this.img,
      this.orders,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.status});

  Slide.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['name'];
    url = json['url'];
    position = json['position'];
    img = json['img'];
    orders = json['orders'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['name'] = this.name;
    data['url'] = this.url;
    data['position'] = this.position;
    data['img'] = this.img;
    data['orders'] = this.orders;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['status'] = this.status;
    return data;
  }
}
