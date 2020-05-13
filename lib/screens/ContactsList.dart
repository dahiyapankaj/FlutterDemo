import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/bloc/ContactBloc.dart';
import 'package:flutterapp/db/DbHelper.dart';
import 'package:flutterapp/events/SetContactsEvent.dart';
import 'package:flutterapp/models/Contact.dart';

import 'AddContactPage.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  void initState() {
    super.initState();
    DbHelper.dbHelper.getContacts().then(
      (contacts) {
        BlocProvider.of<ContactBloc>(context).add(SetContactsEvent(contacts));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact List")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AddContactPage()),
        ),
      ),
      body: Container(
        child: BlocConsumer<ContactBloc, List<Contact>>(
          builder: (context, dataList) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                Contact contact = dataList[index];
                return Card(
                  elevation: 10,
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(contact.id.toString().toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.normal))),
                      title: Text(contact.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(contact.mobile,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.normal)),
                      trailing: Icon(
                        getIcon(contact.fav),
                        color: Colors.blue,
                      ),
                      onTap: () {
                        print("id is"+contact.id.toString().toUpperCase());
                        print("sending update index as : " +
                           index.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => AddContactPage(
                                    contact: contact,
                                    contactId: index,
                                  )),
                        );
                      }),
                );
              },
              itemCount: dataList.length,
            );
          },
          listener: (BuildContext context, foodList) {},
        ),
      ),
    );
  }
}

IconData getIcon(bool fav) {
  return fav ? Icons.star : Icons.star_border;
}
