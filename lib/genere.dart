import 'package:flutter/material.dart';

class Genere extends StatelessWidget {
  final genere;
  const Genere({Key? key, required this.genere}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 129, 58, 183),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 171, 159, 177),
                  blurRadius: 10,
                  offset: Offset(0, 5)),
              BoxShadow(
                  blurRadius: 4,
                  color: Color.fromARGB(255, 255, 255, 255),
                  offset: Offset(-5, 0)),
              BoxShadow(
                  blurRadius: 4,
                  color: Color.fromARGB(255, 255, 253, 253),
                  offset: Offset(0, -5))
            ]),
        width: 90,
        height: 20,
        //color: Colors.purple[800],
        child: Center(
            child: Text(
          genere,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
