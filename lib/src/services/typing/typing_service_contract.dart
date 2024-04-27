// ignore_for_file: unused_import

import 'package:chatify/src/models/typing_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../models/user.dart';

abstract class ITypingNotification {
  Future<bool> send({required TypingEvent event,required User to});
  //the person who wants to know that typing is happening `` user
  //usersIds who is typing events from usersIds.
  Stream<TypingEvent> subscribe(User user, List<String> userIds);
  void dispose();
}
