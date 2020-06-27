class Tour {
  String id;
  String title;
  String imageUrl;
  String descriptions;
  List<Activities> activities;
  String vehicle;
  int day;
  int night;
  int adultPrice;
  int childPrice;
  String mapLocation;
  String createdAt;
  String updatedAt;

  Tour(
      {this.id,
      this.title,
      this.imageUrl,
      this.descriptions,
      this.activities,
      this.vehicle,
      this.day,
      this.night,
      this.adultPrice,
      this.childPrice,
      this.mapLocation,
      this.createdAt,
      this.updatedAt});

  Tour.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    imageUrl = json['image_url'];
    descriptions = json['descriptions'];
    if (json['activities'] != null) {
      activities = new List<Activities>();
      json['activities'].forEach((v) {
        activities.add(new Activities.fromJson(v));
      });
    }
    vehicle = json['vehicle'];
    day = json['day'];
    night = json['night'];
    adultPrice = json['adult_price'];
    childPrice = json['child_price'];
    mapLocation = json['map_location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['image_url'] = this.imageUrl;
    data['descriptions'] = this.descriptions;
    if (this.activities != null) {
      data['activities'] = this.activities.map((v) => v.toJson()).toList();
    }
    data['vehicle'] = this.vehicle;
    data['day'] = this.day;
    data['night'] = this.night;
    data['adult_price'] = this.adultPrice;
    data['child_price'] = this.childPrice;
    data['map_location'] = this.mapLocation;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Activities {
  String sId;
  String num;
  String desc;

  Activities({this.sId, this.num, this.desc});

  Activities.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    num = json['num'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['num'] = this.num;
    data['desc'] = this.desc;
    return data;
  }
}