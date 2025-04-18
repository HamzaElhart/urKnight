// ignore: file_names
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactsDetailScreen extends StatefulWidget {
  final String groupId;

  const ContactsDetailScreen({super.key, required this.groupId});

  @override
  // ignore: library_private_types_in_public_api
  _ContactsDetailScreenState createState() => _ContactsDetailScreenState();
}

class _ContactsDetailScreenState extends State<ContactsDetailScreen> {
  late Future<QuerySnapshot> contacts;

  @override
  void initState() {
    super.initState();
    contacts = FirebaseFirestore.instance
        .collection('contacts')
        .where('groupId', isEqualTo: widget.groupId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: contacts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          var contactsList = snapshot.data!.docs;
          return ListView.builder(
            itemCount: contactsList.length,
            itemBuilder: (context, index) {
              var contact = contactsList[index];
              return ListTile(
                title: Text(contact['name']),
                subtitle: Text(contact['phoneNumber']),
                onTap: () {
                  // Add code for showing contact details
                },
              );
            },
          );
        } else {
          return Text('No contacts found');
        }
      },
    );
  }
}
