import 'dart:convert';
import 'dart:math';

import 'package:bookshelf_virtual/BookDescriptionPage.dart';
import 'package:bookshelf_virtual/authentication/loginPage.dart';
import 'package:bookshelf_virtual/bookcards.dart';
import 'package:bookshelf_virtual/favourites.dart';
import 'package:bookshelf_virtual/genere.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:http/http.dart' as http;

import 'collectionList.dart';
import 'collectionsPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isloading = true;
  final _Controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  List genere = [
    "Action",
    "Romance",
    "Thriller",
    "Drama",
    "horror",
    "Mystery",
    "Crime"
  ];
  List books = [];
  List fav = [];
  final random = Random();
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=thriller&key=AIzaSyC4vbvm9UXmA1i8xwQ6tBgm468QzbiAz_o&maxResults=30'));

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      var obj = data["items"];
      print(obj);
      setState(() {
        for (var book in obj) {
          //books.add([book["selfLink"]]);
          var info = book["volumeInfo"];
          // var link = book["selfLink"];

          books.add([
            book["selfLink"],
            info["title"],
            info["averageRating"],
            info["imageLinks"]["thumbnail"],
            info["authors"],
            info["publisher"],
            info["publishedDate"],
            info["description"],
          ]);
        }

        isloading = false;
      });

      // print(books[8]);
    } else {
      throw Exception('Failed to fetch books');
    }
  }

  double roundToOneDecimal(double value) {
    return (value * 10).round() / 10;
  }

  void _bookdetails(int i) {
    final book = books[i];
    final link = book[0];
    final title = book[1];
    final rating = book[2];
    final imageUrl = book[3];
    final author = book[4];
    final publisher = book[5];
    final publishedDate = book[6];
    final description = book[7];
    // final isAvail = book[8];
    // final download = book[8];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDescriptionPage(
          title: title,
          rating: rating,
          imageUrl: imageUrl,
          author: author,
          publisher: publisher,
          publishedDate: publishedDate,
          description: description,
          // isAvailable: isAvail,
          //downloadLink: download,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => Collections()));
                  },
                  icon: Icon(Icons.favorite_border_rounded)),
              label: 'Collections',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await auth.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => LoginPage()));
                },
                icon: Icon(Icons.logout_outlined))
          ],
          title: Text(
            "Bookshelf",
            style: TextStyle(
                color: Color.fromARGB(255, 105, 26, 165),
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          backgroundColor: Colors.grey[200],
          elevation: 3,
          scrolledUnderElevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Container(
            height: 800,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    width: 350,
                    height: 50,
                    child: TextField(
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                          hintText: "e.g The Fantastic Four",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 149, 113, 170),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: _isFocused
                                ? Colors.purple[500]
                                : Colors.purple.shade200,
                          ),
                          //prefixIconColor: Colors.purple[500],
                          filled: true,
                          fillColor: Colors.purple[100],
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 213, 213, 213))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 167, 130, 178)))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Top picks :",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      var book = books[index];
                      double minRating = 1.0;
                      double maxRating = 3.0;
                      double randomRating = minRating +
                          random.nextDouble() * (maxRating - minRating);
                      randomRating = roundToOneDecimal(randomRating);
                      return InkWell(
                        onTap: () => _bookdetails(index),
                        child: Bookcard(
                          name: book[1],
                          rating: book[2] == null ? randomRating : book[2],
                          image: book[3],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 270.0),
                  child: Text(
                    "Genres :",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                //SizedBox(height: 30),
                Container(
                  height: 90,
                  // color: Colors.blue[200],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: genere.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Genere(genere: genere[index]),
                          );
                        })),
                  ),
                ),

                //favs
                Padding(
                  padding: const EdgeInsets.only(right: 270.0),
                  child: Text(
                    "Favourites:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: CollectionList()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
