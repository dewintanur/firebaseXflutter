import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'update.dart';

class ListCafe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Cafes"),
      ),
      body: CafeList(),
    );
  }
}

class CafeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('myCafe').snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var cafeData = snapshot.data!.docs[index].data()!;
              var cafeId = snapshot.data!.docs[index].id;

              return ListTile(
                title: Text(cafeData['Cafe'] ?? ''),
                subtitle: Text(
                  'Location: ${cafeData['Location'] ?? ''}, Rate: ${cafeData['Rate'] ?? ''}',
                ),
                onTap: () {
                  // Navigate to a detailed view or perform any action on cafe item tap
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Navigate to the EditPage with the cafeId
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPage(cafeId: cafeId)),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Show a confirmation dialog before deleting
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Delete Cafe"),
                            content: Text(
                                "Are you sure you want to delete this cafe?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  // Delete the cafe and close the dialog
                                  await FirebaseFirestore.instance
                                      .collection('myCafe')
                                      .doc(cafeId)
                                      .delete();
                                  Navigator.pop(context);
                                },
                                child: Text("Delete"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }

        // If there's no data
        return Center(
          child: Text("No cafes available."),
        );
      },
    );
  }
}


