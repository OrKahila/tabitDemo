import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class CharactersProvider with ChangeNotifier {
  List<Character> _characters = [];
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isFetching = false;

  List<Character> get characters => [..._characters];

  bool get hasMore => _hasMore;

  Future<void> fetchCharacters({bool isNextPage = false}) async {
    if (_isFetching) return;

    _isFetching = true;
    final String apiUrl =
        'https://rickandmortyapi.com/api/character?page=$_currentPage';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'] as List;

        if (isNextPage) {
          _characters
              .addAll(results.map((json) => Character.fromJson(json)).toList());
        } else {
          _characters =
              results.map((json) => Character.fromJson(json)).toList();
        }

        _hasMore = data['info']['next'] != null;
        if (_hasMore) _currentPage++;
      } else {
        throw Exception(
            'Failed to load characters. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Something went wrong while fetching characters.');
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  void resetCharacters() {
    _characters = [];
    _currentPage = 1;
    _hasMore = true;
    notifyListeners();
  }
}
