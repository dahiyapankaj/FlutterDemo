import 'package:flutterapp/events/ContactEvent.dart';
import 'package:flutterapp/models/Contact.dart';

class AddContactEvent extends ContactEvent {
  Contact contact;

  AddContactEvent(this.contact);
}
