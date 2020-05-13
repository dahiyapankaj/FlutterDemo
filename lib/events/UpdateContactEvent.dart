import 'package:flutterapp/events/ContactEvent.dart';
import 'package:flutterapp/models/Contact.dart';

class UpdateContactEvent extends ContactEvent {
  Contact contact;
  int id;

  UpdateContactEvent(int index, Contact newContact) {
    print("updating data for $index " + newContact.name);
    this.id = index;
    this.contact = newContact;
  }
}
