import 'package:bloc/bloc.dart';
import 'package:flutterapp/events/AddContactEvent.dart';
import 'package:flutterapp/events/ContactEvent.dart';
import 'package:flutterapp/events/DeleteContactEvent.dart';
import 'package:flutterapp/events/SetContactsEvent.dart';
import 'package:flutterapp/events/UpdateContactEvent.dart';
import 'package:flutterapp/models/Contact.dart';

class ContactBloc extends Bloc<ContactEvent, List<Contact>> {
  @override
  List<Contact> get initialState => List<Contact>();

  @override
  Stream<List<Contact>> mapEventToState(ContactEvent event) async* {
    if (event is SetContactsEvent) {
      yield event.contactList;
    } else if (event is AddContactEvent) {
      List<Contact> newState = List.from(state);
      if (event.contact != null) {
        newState.add(event.contact);
      }
      yield newState;
    } else if (event is DeleteContactEvent) {
      List<Contact> newState = List.from(state);
      newState.removeAt(event.contactId);
      yield newState;
    } else if (event is UpdateContactEvent) {
      List<Contact> newState = List.from(state);
      newState[event.id] = event.contact;
      yield newState;
    }
  }
}
