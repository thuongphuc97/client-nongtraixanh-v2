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
    adultPrice: json['adultPrice'] as int,
    childPrice: json['childPrice'] as int,
    mapLocation: json['mapLocation'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
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
