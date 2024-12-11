import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final Location origin;
  final Location location;
  final String image;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    try {
      return _$CharacterFromJson(json);
    } catch (e) {
      log('Error parsing Character: $e');

      // return default character
      return Character(
        id: json['id'] ?? -1,
        name: json['name'] ?? 'Unknown',
        status: json['status'] ?? 'Unknown',
        species: json['species'] ?? 'Unknown',
        gender: json['gender'] ?? 'Unknown',
        origin: Location.fromJson(
          Map<String, dynamic>.from(
            json['origin'] ?? {'name': 'Unknown', 'url': ''},
          ),
        ),
        location: Location.fromJson(
          Map<String, dynamic>.from(
            json['location'] ?? {'name': 'Unknown', 'url': ''},
          ),
        ),
        image: json['image'] ?? '',
      );
    }
  }

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}

@JsonSerializable()
class Location {
  final String name;
  final String url;

  Location({
    required this.name,
    required this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    try {
      return _$LocationFromJson(json);
    } catch (e) {
      log('Error parsing Location: $e');

      // return default location
      return Location(
        name: json['name'] ?? 'Unknown',
        url: json['url'] ?? '',
      );
    }
  }

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
