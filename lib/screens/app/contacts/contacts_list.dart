import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urknight/screens/app/contacts/ContactsDetailsScreen.dart';


class ContactsListScreen extends StatefulWidget {
  const ContactsListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactsListScreenState createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends State<ContactsListScreen> {
  late Future<QuerySnapshot> groups;

  @override
  void initState() {
    super.initState();
    groups = FirebaseFirestore.instance.collection('groups').get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: groups,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          var groupsList = snapshot.data!.docs;
          return ListView.builder(
            itemCount: groupsList.length,
            itemBuilder: (context, index) {
              var group = groupsList[index];
              return ListTile(
                title: Text(group['name']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactsDetailScreen(
                        groupId: group.id,
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return Text('No groups found');
        }
      },
    );
  }
}
