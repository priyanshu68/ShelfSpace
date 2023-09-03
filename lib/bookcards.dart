// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Bookcard extends StatelessWidget {
  final name;
  final image;

  final rating;

  const Bookcard({
    Key? key,
    required this.name,
    required this.image,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 130,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                )),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 157, 139, 170),
                      blurRadius: 10,
                      offset: Offset(0, 5)),
                  BoxShadow(
                      blurRadius: 5,
                      color: Colors.white,
                      offset: Offset(-5, 0)),
                  BoxShadow(
                      blurRadius: 5, color: Colors.white, offset: Offset(0, -5))
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: 150,
              child: Center(
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Text('${rating}/5')
        ],
      ),
    );
  }
}
