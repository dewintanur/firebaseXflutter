import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color.fromARGB(255, 59, 44, 22),
      indicatorColor: Colors.orangeAccent,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String cafeName, cafeLocation;
  late double cafeRate;

  getCafeName(name) {
    this.cafeName = name;
  }

  getCafeLocation(location) {
    this.cafeLocation = location;
  }

  getCafeRate(rate) {
    this.cafeRate = rate;
  }

  createData() {
    print("created data");

    Future createData({required String name}) async {
      // reference to document
      final docCafe =
          FirebaseFirestore.instance.collection("myCafe").doc(cafeName);

      final json = {
        "cafeName": cafeName,
        "cafeLocation": cafeLocation,
        "cafeRate": cafeRate
      };
      // create document and write data to Firebase
      await docCafe.set(json);
    }

    Map<String, dynamic> toJson() => {
          "cafeName": cafeName,
          "cafeLocation": cafeLocation,
          "cafeRate": cafeRate
        };

    // documentReference.Future<>.whenComplete((){
    //   print("$cafeName created")
    // });
  }

  readData() {
    print("read data");
  }

  updateData() {
    print("updated data");
  }

  deleteData() {
    print("deleted data");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My List Cafe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 59, 44, 22),
                          width: 2.0))),
              onChanged: (String name) {
                getCafeName(name);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Location",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 59, 44, 22),
                          width: 2.0))),
              onChanged: (String location) {
                getCafeLocation(location);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Rating",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 59, 44, 22), width: 2.0))),
              onChanged: (String rate) {
                getCafeRate(rate);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    createData();
                  },
                  child: Text("Create")),
              ElevatedButton(
                  onPressed: () {
                    readData();
                  },
                  child: Text("Read")),
              ElevatedButton(
                  onPressed: () {
                    updateData();
                  },
                  child: Text("Update")),
              ElevatedButton(
                  onPressed: () {
                    deleteData();
                  },
                  child: Text("Delete"))
            ],
          )
        ]),
      ),
    );
  }
}
