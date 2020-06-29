class Product {
  int iD;
  int catid;
  int submenu;
  String name;
  String slug;
  String img;
  String detail;
  int number;
  double price;
  double pricesale;
  String metakey;
  String metadesc;
  String createdAt;
  int createdBy;
  String updatedAt;
  int updatedBy;
  int status;
  int sold;

  Product(
      {this.iD,
      this.catid,
      this.submenu,
      this.name,
      this.slug,
      this.img,
      this.detail,
      this.number,
      this.price,
      this.pricesale,
      this.metakey,
      this.metadesc,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.status,
      this.sold});

  Product.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    catid = json['catid'];
    submenu = json['Submenu'];
    name = json['name'];
    slug = json['slug'];
    img = json['img'];
    detail = json['detail'];
    number = json['number'];
    price = json['price'];
    pricesale = json['pricesale'];
    metakey = json['metakey'];
    metadesc = json['metadesc'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    status = json['status'];
    sold = json['sold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['catid'] = this.catid;
    data['Submenu'] = this.submenu;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['img'] = this.img;
    data['detail'] = this.detail;
    data['number'] = this.number;
    data['price'] = this.price;
    data['pricesale'] = this.pricesale;
    data['metakey'] = this.metakey;
    data['metadesc'] = this.metadesc;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['status'] = this.status;
    data['sold'] = this.sold;
    return data;
  }
}