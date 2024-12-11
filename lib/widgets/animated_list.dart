import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tabit/models/character.dart';

import 'character_card.dart';

class CharactersAnimatedList extends StatelessWidget {
  const CharactersAnimatedList({
    super.key,
    required this.scrollController,
    required this.charactersList,
  });

  final List<Character> charactersList;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
        child: ListView.builder(
      itemCount: charactersList.length,
      controller: scrollController,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(milliseconds: 300),
        child: ScaleAnimation(
          child: FadeInAnimation(
            child: CharacterCard(
              character: charactersList[index],
            ),
          ),
        ),
      ),
    ));
  }
}
