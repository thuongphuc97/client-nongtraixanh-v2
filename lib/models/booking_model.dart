class Booking {
  String sId;
  String uid;
  String status;
  List<BookingItems> bookingItems;
  String updatedAt;
  String createdAt;
  int total;

  Booking(
      {this.sId,
      this.uid,
      this.status,
      this.bookingItems,
      this.updatedAt,
      this.createdAt,
      this.total});

  Booking.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uid = json['uid'];
    status = json['status'];
    if (json['booking_items'] != null) {
      bookingItems = new List<BookingItems>();
      json['booking_items'].forEach((v) {
        bookingItems.add(new BookingItems.fromJson(v));
      });
    }
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['uid'] = this.uid;
    data['status'] = this.status;
    if (this.bookingItems != null) {
      data['booking_items'] = this.bookingItems.map((v) => v.toJson()).toList();
    }
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['total'] = this.total;
    return data;
  }
}

class BookingItems {
  String sId;
  String tourId;
  String type;
  int quantity;

  BookingItems({this.sId, this.tourId, this.type, this.quantity});

  BookingItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tourId = json['tour_id'];
    type = json['type'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['tour_id'] = this.tourId;
    data['type'] = this.type;
    data['quantity'] = this.quantity;
    return data;
  }
}
