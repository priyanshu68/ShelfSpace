// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Favourites extends StatelessWidget {
  final name;
  final image;
  // final author;
  final rating;

  const Favourites({
    Key? key,
    required this.name,
    required this.image,
    // required this.author,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              image,
              fit: BoxFit.fill,
              width: 85,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: Container(width: 150, child: Text(name)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Icon(Icons.favorite_border_outlined),
        )
      ]),
    );
  }
}
