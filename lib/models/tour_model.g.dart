// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tour _$TourFromJson(Map<String, dynamic> json) {
  return Tour(
    id: json['id'] as String,
    title: json['title'] as String,
    imageUrl: json['image_url'] as String,
    descriptions: json['descriptions'] as String,
    vehicle: json['vehicle'] as String,
    day: json['day'] as int,
    night: json['night'] as int,
    adultPrice: json['adult_price'] as int,
    childPrice: json['child_price'] as int,
    mapLocation: json['map_location'] as String,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
  );
}

Map<String, dynamic> _$TourToJson(Tour instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'descriptions': instance.descriptions,
      'vehicle': instance.vehicle,
      'day': instance.day,
      'night': instance.night,
      'adultPrice': instance.adultPrice,
      'childPrice': instance.childPrice,
      'mapLocation': instance.mapLocation,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
