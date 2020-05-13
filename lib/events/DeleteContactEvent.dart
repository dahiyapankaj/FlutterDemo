import 'package:flutterapp/events/ContactEvent.dart';

class DeleteContactEvent extends ContactEvent {
  int contactId;

  DeleteContactEvent(this.contactId);
}
