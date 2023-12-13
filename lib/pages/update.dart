import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditPage extends StatefulWidget {
  final String cafeId;

  EditPage({required this.cafeId});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController cafenameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Cafe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: cafenameController,
              decoration: InputDecoration(labelText: 'Cafe Name'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: rateController,
              decoration: InputDecoration(labelText: 'Rate'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await updateCafeData();
                Navigator.pop(context); // Go back to previous screen
              },
              child: Text("Update Cafe"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateCafeData() async {
    await FirebaseFirestore.instance
        .collection('myCafe')
        .doc(widget.cafeId)
        .update({
      'Cafe': cafenameController.text,
      'Location': locationController.text,
      'Rate': rateController.text,
    });

    // You can add a toast or snackbar here to indicate successful update
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      DocumentSnapshot cafeSnapshot = await FirebaseFirestore.instance
          .collection('myCafe')
          .doc(widget.cafeId)
          .get();

      Map<String, dynamic>? cafeData =
          cafeSnapshot.data() as Map<String, dynamic>?;

      if (cafeData != null) {
        cafenameController.text = cafeData['Cafe'] ?? '';
        locationController.text = cafeData['Location'] ?? '';
        rateController.text = cafeData['Rate'] ?? '';
      }
    } catch (e) {
      // Handle errors or edge cases
      print(e.toString());
    }
  }
}
