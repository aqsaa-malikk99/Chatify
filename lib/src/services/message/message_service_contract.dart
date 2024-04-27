import 'package:chatify/src/models/user.dart';

import '../../models/message.dart';

abstract class IMessageService {
  Future<bool> send(Message message);
  Stream<Message> messages({
    required User activeUser,
  });
  dispose();
}
