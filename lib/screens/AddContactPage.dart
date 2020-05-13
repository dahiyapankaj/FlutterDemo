import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/bloc/ContactBloc.dart';
import 'package:flutterapp/db/DbHelper.dart';
import 'package:flutterapp/events/AddContactEvent.dart';
import 'package:flutterapp/events/DeleteContactEvent.dart';
import 'package:flutterapp/events/UpdateContactEvent.dart';
import 'package:flutterapp/models/Contact.dart';

class AddContactPage extends StatefulWidget {
  final Contact contact;
  final int contactId;

  AddContactPage({this.contact, this.contactId});

  @override
  State<StatefulWidget> createState() {
    return AddContactPageState();
  }
}

class AddContactPageState extends State<AddContactPage> {
  String _name;
  String _mobile;
  String _landline;
  bool _isFav = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
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
    );
  }

  Widget _buildMobile() {
    return TextFormField(
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
    );
  }

  Widget _buildLandline() {
    return TextFormField(
      initialValue: _landline,
      decoration: InputDecoration(hintText: 'Landline'),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 16),
      onSaved: (String value) {
        _landline = value;
      },
    );
  }

  Widget _buildIsFav() {
    return SwitchListTile(
      title: Text("Fav?", style: TextStyle(fontSize: 20)),
      value: _isFav,
      onChanged: (bool newValue) => setState(() {
        _isFav = newValue;
      }),
    );
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
      appBar: AppBar(title: Text("Add Contact")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildName(),
              _buildMobile(),
              _buildLandline(),
              SizedBox(height: 16),
              _buildIsFav(),
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

                        Contact contact =
                            Contact(_name, _mobile, _landline, _isFav, "NA");

                        DbHelper.dbHelper.insertContact(contact).then(
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
                        RaisedButton(
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();

                            Contact newContact = Contact(
                                _name, _mobile, _landline, _isFav, "NA");
                            print("id before updating is "+widget.contactId.toString());
                            DbHelper.dbHelper.updateContact(widget.contact,widget.contact.id).then(
                                  (storedContact) =>
                                      BlocProvider.of<ContactBloc>(context).add(
                                    UpdateContactEvent(widget.contactId, newContact),
                                  ),
                                );
                            print("popping out");
                            Navigator.pop(context);
                          },
                        ),
                        RaisedButton(
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                          onPressed: () {
                            DbHelper.dbHelper.deleteContact(widget.contactId).then(
                                    (storedContact) =>
                                    BlocProvider.of<ContactBloc>(context).add(
                                      DeleteContactEvent(widget.contactId),
                                    ));
                            Navigator.pop(context);
                          },
                        ),
                        RaisedButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
