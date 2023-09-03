// ignore_for_file: await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookDescriptionPage extends StatefulWidget {
  final title;
  final rating;
  final imageUrl;
  final author;
  final publisher;
  final publishedDate;
  final description;
  //final isAvailable;
  // final downloadLink;
  const BookDescriptionPage({
    Key? key,
    required this.title,
    required this.rating,
    required this.imageUrl,
    required this.author,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    //required this.isAvailable,
    // required this.downloadLink,
  }) : super(key: key);

  @override
  State<BookDescriptionPage> createState() => _BookDescriptionPageState();
}

class _BookDescriptionPageState extends State<BookDescriptionPage> {
  @override
  final FirebaseAuth auth = FirebaseAuth.instance;
  //String userId = auth.currentUser!.uid;
  Future<void> addToCollections(
    String userid,
    String author,
    String title,
    String imageUrl,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set({
        "userId": userid,
        "title": title,
        "imageUrl": imageUrl,
        "author": author.toString(),
      });
      print('Book added to collections successfully.');
    } catch (e) {
      print('Error adding book to collections: $e');
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 228, 204, 246),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Image.network(widget.imageUrl),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.title),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(widget.author[0].toString()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20,
                            ),
                            Icon(
                              Icons.star_border,
                              size: 20,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 90,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text("Read"),
                              ),
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            IconButton(
                                onPressed: () {
                                  addToCollections(
                                      auth.currentUser!.uid.toString(),
                                      widget.author.toString(),
                                      widget.title.toString(),
                                      widget.imageUrl.toString());
                                  // SnackBar(
                                  //     content: Text("Added to collections"));
                                },
                                icon: Icon(Icons.favorite_border_rounded))
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 237, 224, 243),
                          backgroundBlendMode: BlendMode.darken,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.description,
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
