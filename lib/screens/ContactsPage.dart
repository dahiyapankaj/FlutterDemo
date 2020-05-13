import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/bloc/ContactBloc.dart';
import 'package:flutterapp/screens/ContactsList.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactBloc>(
      create: (context) => ContactBloc(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sqflite Tutorial',
          home: ContactsList()),
    );
  }
}
