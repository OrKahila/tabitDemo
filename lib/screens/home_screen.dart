import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tabit/models/character.dart';
import 'package:tabit/providers/charecters.dart';
import 'package:tabit/widgets/background.dart';
import 'package:tabit/widgets/error_ui.dart';
import 'package:tabit/widgets/search_box.dart';

import '../widgets/animated_list.dart';
import '../widgets/filter_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CharactersProvider _charactersProvider;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _showErrorUI = false;

  List<Character> originalCharacters = [];
  List<Character> displayedCharacters = [];
  String _searchQuery = '';
  String _statusFilter = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _charactersProvider =
        Provider.of<CharactersProvider>(context, listen: false);
    fetchCharacters();

    // Set up scroll listener for lazy loading
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoadingMore &&
          _charactersProvider.hasMore) {
        fetchMoreCharacters();
      }
    });
  }

  Future<void> fetchCharacters() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _charactersProvider.fetchCharacters();

      // delay just for the cool loading animation
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        originalCharacters = _charactersProvider.characters;
        displayedCharacters =
            originalCharacters; // start by displaying all characters

        if (_showErrorUI) _showErrorUI = false;
      });
    } catch (error) {
      log('Error fetching characters: $error');
      setState(() {
        _showErrorUI = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchMoreCharacters() async {
    setState(() {
      _isLoadingMore = true;
    });
    try {
      await _charactersProvider.fetchCharacters(isNextPage: true);
      setState(() {
        originalCharacters = _charactersProvider.characters;
        _applySearchAndFilter(); // Apply search/filter to new characters
      });
    } catch (error) {
      log('Error fetching more characters: $error');
    } finally {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  void _applySearchAndFilter() {
    setState(() {
      displayedCharacters = originalCharacters.where((character) {
        final matchesSearch =
            character.name.toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesFilter = _statusFilter.isEmpty ||
            character.status.toLowerCase() == _statusFilter.toLowerCase();
        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applySearchAndFilter();
  }

  void _onFilterPressed() {
    showDialog(
      context: context,
      builder: (ctx) {
        return FilterDialog(
          initialFilter: _statusFilter,
          onFilterSelected: (filter) {
            setState(() {
              _statusFilter = filter;
            });
            _applySearchAndFilter();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const HomeBackground(),
          Positioned(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // search box
                SearchBox(
                  onSearchChanged: _onSearchChanged,
                  onFilterPressed: _onFilterPressed,
                ),
                Container(
                  alignment: Alignment.center,
                  height: size.height * 0.6,
                  width: size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        Color.fromARGB(255, 216, 236, 255),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, -10),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: _showErrorUI
                      ? ErrorUI(
                          message: 'Oops!\nSomething went wrong',
                          secondaryMessage:
                              'We couldn\'t fetch the characters.\nPlease try again',
                          onRetry: () => fetchCharacters(),
                        )
                      : Column(
                          children: [
                            // title
                            const Text(
                              'Rick and Morty Characters',
                              style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Rubik',
                              ),
                            ),
                            const SizedBox(height: 15),
                            // characters list
                            _isLoading && displayedCharacters.isEmpty
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: Lottie.asset(
                                        'assets/loading.json',
                                        height: 100,
                                        repeat: true,
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: CharactersAnimatedList(
                                      charactersList: displayedCharacters,
                                      scrollController: _scrollController,
                                    ),
                                  ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
