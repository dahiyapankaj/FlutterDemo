import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/bloc/ContactBloc.dart';
import 'package:flutterapp/db/DbHelper.dart';
import 'package:flutterapp/events/AddContactEvent.dart';
import 'package:flutterapp/events/DeleteContactEvent.dart';
import 'package:flutterapp/events/UpdateContactEvent.dart';
import 'package:flutterapp/models/Contact.dart';
import 'package:image_picker/image_picker.dart';

class AddContactPage extends StatefulWidget {
  final Contact contact;
  final int contactId;

  AddContactPage({this.contact, this.contactId});

  @override
  State<StatefulWidget> createState() {
    return AddContactPageState(contact);
  }
}

class AddContactPageState extends State<AddContactPage> {
  String _name;
  String _mobile;
  String _landline;
  bool _isFav = false;
  File _image;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Contact receivedContact;

  AddContactPageState(this.receivedContact);

  Widget _buildName() {
    return ListTile(
      leading: Icon(Icons.person, color: Colors.blue, size: 35),
      title: TextFormField(
        initialValue: _name,
        decoration: InputDecoration(hintText: 'Name'),
        maxLength: 50,
        style: TextStyle(fontSize: 16),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is Required';
          }

          return null;
        },
        onSaved: (String value) {
          _name = value;
        },
      ),
    );
  }

  Widget _buildMobile() {
    return ListTile(
      leading: Icon(
        Icons.phone_android,
        color: Colors.blue,
        size: 35,
      ),
      title: TextFormField(
        initialValue: _mobile,
        decoration: InputDecoration(hintText: 'Mobile'),
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 16),
        maxLength: 10,
        validator: (String value) {
          if (value == null || value.isEmpty) {
            return 'Mobile number must be of 10 digits';
          }
          return null;
        },
        onSaved: (String value) {
          _mobile = value;
        },
      ),
    );
  }

  Widget _buildLandline() {
    return ListTile(
        leading: Icon(Icons.local_phone, color: Colors.blue, size: 35),
        title: TextFormField(
          initialValue: _landline,
          decoration: InputDecoration(hintText: 'Landline'),
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 16),
          onSaved: (String value) {
            _landline = value;
          },
        ));
  }

  void _toggleFavorite() {
    setState(() {
      _isFav = !_isFav;
      print("user is fav :" + _isFav.toString());
    });
  }

  Widget _buildImageAvatar() {
    return Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(2.0),
        // border width
        decoration: new BoxDecoration(
          color: Colors.blue, // border color
          shape: BoxShape.circle,
        ),
        child: _getImage());
  }

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      _name = widget.contact.name;
      _mobile = widget.contact.mobile;
      _landline = widget.contact.landLine;
      _isFav = widget.contact.fav;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  _toggleFavorite();
                },
                child: Icon(
                  _isFav ? Icons.star : Icons.star_border,
                  size: 26.0,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildImageAvatar(),
              SizedBox(height: 30),
              _buildName(),
              _buildMobile(),
              _buildLandline(),
//              SizedBox(height: 16),
//              _buildIsFav(),
              SizedBox(height: 20),
              widget.contact == null
                  ? RaisedButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }

                        _formKey.currentState.save();

                        Contact newContact = Contact(
                            name: _name,
                            mobile: _mobile,
                            landLine: _landline,
                            fav: _isFav);
                        DbHelper.dbHelper.insertContact(newContact).then(
                              (storedContact) =>
                                  BlocProvider.of<ContactBloc>(context).add(
                                AddContactEvent(storedContact),
                              ),
                            );

                        Navigator.pop(context);
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(32.0),
                            color: Colors.blue,
                            child: MaterialButton(
                              child: Text(
                                "Update",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              onPressed: () {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                _formKey.currentState.save();

                                Contact newContact = Contact(
                                    id: receivedContact.id,
                                    name: _name,
                                    mobile: _mobile,
                                    landLine: _landline,
                                    fav: _isFav);
                                print("id before updating is " +
                                    newContact.id.toString());
                                DbHelper.dbHelper
                                    .updateContact(newContact)
                                    .then(
                                      (storedContact) =>
                                          BlocProvider.of<ContactBloc>(context)
                                              .add(
                                        UpdateContactEvent(
                                            widget.contactId, newContact),
                                      ),
                                    );
                                print("popping out");
                                Navigator.pop(context);
                              },
                            )),
                        Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(32.0),
                            color: Colors.blue,
                            child: MaterialButton(
                              child: Text(
                                "Delete",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              onPressed: () {
                                DbHelper.dbHelper
                                    .deleteContact(receivedContact.id)
                                    .then((storedContact) =>
                                        BlocProvider.of<ContactBloc>(context)
                                            .add(
                                          DeleteContactEvent(widget.contactId),
                                        ));
                                Navigator.pop(context);
                              },
                            )),
                        Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(32.0),
                            color: Colors.blue,
                            child: MaterialButton(
                                child: Text(
                                  "Cancel",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                onPressed: () => getImage(ImageSource
                                    .gallery) //Navigator.pop(context),
                                )),
                      ],
                    ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _getImage() {
    return CircleAvatar(
        backgroundColor: Colors.white, child: getChildForImage());
  }

  String getTitle() {
    return widget.contact == null ? "Add Contact" : "Update Contact";
  }

  Future<void> getImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        _image = imageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget getChildForImage() {
    return _image == null
        ? Icon(Icons.add_a_photo, color: Colors.blue, size: 40)
        : Image.file(_image);
  }
}
