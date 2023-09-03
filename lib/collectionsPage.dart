import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'collectionList.dart';

class Collections extends StatefulWidget {
  final title;
  final rating;
  final imageUrl;
  final author;
  final publisher;
  final publishedDate;
  final description;
  const Collections(
      {super.key,
      this.title,
      this.rating,
      this.imageUrl,
      this.author,
      this.publisher,
      this.publishedDate,
      this.description});

  @override
  State<Collections> createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  @override
  final FirebaseAuth auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "My Collections",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            CollectionList()
          ],
        ),
      )),
    );
  }
}
