import 'package:flutter_test/flutter_test.dart';
import 'package:tabit/models/character.dart';

void main() {
  group('Character.fromJson', () {
    test('parses valid JSON correctly', () {
      final Map<String, dynamic> json = {
        "id": 1,
        "name": "Or",
        "status": "Alive",
        "species": "Alien",
        "gender": "Male",
        "origin": {
          "name": "Earth",
          "url": "https://rickandmortyapi.com/api/location/1"
        },
        "location": {
          "name": "Tel Aviv",
          "url": "https://rickandmortyapi.com/api/location/3"
        },
        "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
      };

      final character = Character.fromJson(json);

      expect(character.id, 1);
      expect(character.name, "Or");
      expect(character.status, "Alive");
      expect(character.species, "Alien");
      expect(character.gender, "Male");
      expect(character.origin.name, "Earth");
      expect(
          character.origin.url, "https://rickandmortyapi.com/api/location/1");
      expect(character.location.name, "Tel Aviv");
      expect(
          character.location.url, "https://rickandmortyapi.com/api/location/3");
      expect(character.image,
          "https://rickandmortyapi.com/api/character/avatar/1.jpeg");
    });

    test('handles missing fields gracefully', () {
      final Map<String, dynamic> json = {
        "id": 2,
        "name": "Or",
        "status": "Alive",
        "species": null, // Missing species
        "gender": "Male",
        "origin": {"name": "Unknown", "url": null}, // Missing URL
        "location": {"name": "Unknown", "url": null}, // Empty location
        "image": null // Missing image
      };

      final character = Character.fromJson(json);

      expect(character.id, 2);
      expect(character.name, "Or");
      expect(character.status, "Alive");
      expect(character.species, "Unknown"); // Fallback value
      expect(character.gender, "Male");
      expect(character.origin.name, "Unknown");
      expect(character.origin.url, ""); // Fallback value
      expect(character.location.name, "Unknown"); // Fallback value
      expect(character.location.url, ""); // Fallback value
      expect(character.image, ""); // Fallback value
    });

    test('handles completely invalid JSON gracefully', () {
      final Map<String, dynamic> json = {}; // Empty map

      final character = Character.fromJson(json);

      expect(character.id, -1); // Default invalid ID
      expect(character.name, "Unknown"); // Fallback value
      expect(character.status, "Unknown"); // Fallback value
      expect(character.species, "Unknown"); // Fallback value
      expect(character.gender, "Unknown"); // Fallback value
      expect(character.origin.name, "Unknown"); // Fallback value
      expect(character.origin.url, ""); // Fallback value
      expect(character.location.name, "Unknown"); // Fallback value
      expect(character.location.url, ""); // Fallback value
      expect(character.image, ""); // Fallback value
    });
  });
}
