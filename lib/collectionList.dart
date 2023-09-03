import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CollectionList extends StatelessWidget {
  const CollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Use FutureBuilder to fetch and display data
    return FutureBuilder<QuerySnapshot>(
      future: users.get(), // Fetch the data from Firestore
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No data available');
        } else {
          // Data fetched successfully, build the list view of ListTiles
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // Get data for each document
                var document = snapshot.data!.docs[index];
                String author = document['author'].toString();
                String image = document['imageUrl'].toString();
                String title = document['title'].toString();

                return ListTile(
                  leading:
                      Image.network(image), // Display the image on the left
                  title: Text(title), // Display the title
                  subtitle: Text(author), // Display the author as the subtitle
                );
              },
            ),
          );
        }
      },
    );
  }
}
