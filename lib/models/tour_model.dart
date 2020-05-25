import 'activity_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'tour_model.g.dart';

@JsonSerializable()
class Tour {
	String id;
	String title;
	String imageUrl;
	String descriptions;
	String vehicle;
	int day;
	int night;
	int adultPrice;
	int childPrice;
	String mapLocation;
	String createdAt;
	String updatedAt;

	Tour({this.id, this.title, this.imageUrl, this.descriptions, this.vehicle, this.day, this.night, this.adultPrice, this.childPrice, this.mapLocation, this.createdAt, this.updatedAt});

factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_id'] = this.id;
		data['title'] = this.title;
		data['image_url'] = this.imageUrl;
		data['descriptions'] = this.descriptions;
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

//mot xoa may nay di ha, yes
List<Tour> tours = [
  Tour(
    id: '1',
    title: "tour 1",
    imageUrl: 'assets/images/venice.jpg',
    childPrice: 150,
    descriptions: 'Visit Venice for an amazing and unforgettable adventure.',
  ),
   Tour(
    id: '1',
    title: "tour 1",
    imageUrl: 'assets/images/venice.jpg',
    childPrice: 150,
    descriptions: 'Visit Venice for an amazing and unforgettable adventure.',
  ),  Tour(
    id: '1',
    title: "tour 1",
    imageUrl: 'assets/images/venice.jpg',
    childPrice: 150,
    descriptions: 'Visit Venice for an amazing and unforgettable adventure.',
  ),  Tour(
    id: '1',
    title: "tour 1",
    imageUrl: 'assets/images/venice.jpg',
    childPrice: 150,
    descriptions: 'Visit Venice for an amazing and unforgettable adventure.',
  ),
];
