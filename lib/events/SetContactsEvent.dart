import 'package:flutterapp/events/ContactEvent.dart';
import 'package:flutterapp/models/Contact.dart';

class SetContactsEvent extends ContactEvent {
  List<Contact> contactList;

  SetContactsEvent(this.contactList);
}
