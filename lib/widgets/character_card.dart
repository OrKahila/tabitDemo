import 'package:flutter/material.dart';
import 'package:tabit/utils.dart';
import 'package:tabit/widgets/image_icon.dart';

import '../animations/hero_dialog.dart';
import '../models/character.dart';
import '../screens/character_details_dialog.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(right: 10, bottom: 5),
      leading: Hero(
        tag: 'character-${character.id}',
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(character.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      title: Text(
        character.name,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          fontFamily: 'Rubik',
        ),
      ),
      subtitle: Row(
        children: [
          Text(
            '${character.species} - ',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: character.species.length > 20 ? 14 : 18,
              fontFamily: 'Rubik',
            ),
          ),
          Expanded(
            child: Text(
              character.status,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontFamily: 'Rubik',
                color: Utils.getStatusColor(character.status),
              ),
            ),
          ),
        ],
      ),
      trailing: const MyImageIcon(
        icon: 'expand',
        size: 25,
      ),
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return CharacterDetailsDialog(
            character: character,
          );
        }));
      },
    );
  }
}
