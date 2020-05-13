import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/bloc/ContactBloc.dart';
import 'package:flutterapp/screens/ContactsList.dart';

class ContactsPage extends StatefulWidget {
  String name;
  ContactsPage(this.name);

  @override
  _ContactsPageState createState() => _ContactsPageState(name);
}

class _ContactsPageState extends State<ContactsPage> {
   String _name;
  _ContactsPageState(this._name);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactBloc>(
      create: (context) => ContactBloc(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sqflite Tutorial',
          home: ContactsList(_name)),
    );
  }
}
