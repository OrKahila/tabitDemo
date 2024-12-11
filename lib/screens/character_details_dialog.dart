import 'package:flutter/material.dart';
import 'package:tabit/utils.dart';

import '../models/character.dart';

class CharacterDetailsDialog extends StatelessWidget {
  final Character character;

  const CharacterDetailsDialog({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: 'character-${character.id}',
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(
                character.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik',
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'Status: ',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      fontFamily: 'Rubik',
                    ),
                    children: [
                      TextSpan(
                        text: character.status,
                        style: TextStyle(
                          color: Utils.getStatusColor(character.status),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Rubik',
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'Species: ',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      fontFamily: 'Rubik',
                    ),
                    children: [
                      TextSpan(
                        text: character.species,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                if (character.gender.isNotEmpty)
                  RichText(
                    text: TextSpan(
                      text: 'Gender: ',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontFamily: 'Rubik',
                      ),
                      children: [
                        TextSpan(
                          text: character.gender,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Rubik',
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 8),
                if (character.origin.name.isNotEmpty)
                  RichText(
                    text: TextSpan(
                      text: 'Origin: ',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontFamily: 'Rubik',
                      ),
                      children: [
                        TextSpan(
                          text: character.origin.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Rubik',
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 8),
                if (character.location.name.isNotEmpty)
                  RichText(
                    text: TextSpan(
                      text: 'Location: ',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontFamily: 'Rubik',
                      ),
                      children: [
                        TextSpan(
                          text: character.location.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Rubik',
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Rubik',
                      color: Colors.white,
                    ),
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
