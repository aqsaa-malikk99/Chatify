import 'dart:async';

import 'package:chatify/src/helper/logger.dart';
import 'package:chatify/src/models/message.dart';
import 'package:chatify/src/models/user.dart';
import 'package:chatify/src/services/encryption/encryption_service_contract.dart';
import 'package:chatify/src/services/message/message_service_contract.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';

class MessageService implements IMessageService {
  final Connection _connection;
  final RethinkDb r;
  final IEncryption _encryption;
  StreamSubscription? _changefeed;
  final _controller = StreamController<Message>.broadcast();
  MessageService(this.r, this._connection,this._encryption);

  @override
  dispose() {
    _changefeed!.cancel();
    _controller.close();
  }

  @override
  Stream<Message> messages({required User activeUser}) {
    _startReceivingMessages(activeUser: activeUser);
    return _controller.stream;
  }

  @override
  Future<bool> send(Message message) async {
    //encrypt
    var data=message.toJson();
    data['contents']=_encryption.encrypt(message.contents);
    Map record =
        await r.table("messages").insert(data).run(_connection);
    return record['inserted'] == 1;
  }

  _startReceivingMessages({required User activeUser}) {
    _changefeed = r
        .table('messages')
        .filter({'to': activeUser.id})
        .changes({'include_initial': true})
        .run(_connection)
        .asStream()
        .cast<Feed>()
        .listen((event) {
          event
              .forEach((feedData) {
                if (feedData['new_val'] == null) return;
                final message = _messageFromFeed(feedData);
                _controller.sink.add(message);
                _removeDeliveredMessage(message);
              })
              .catchError((err, stackTrace) => Log.print(err))
              .onError((error, stackTrace) => Log.print(error));
        });
  }

  Message _messageFromFeed(feedData) { //receiving feed
    //decryption
    var data=feedData['new_val'];
    data['contents']=_encryption.decrypt(data['contents']);
    return Message.fromJson(data);
  }

  _removeDeliveredMessage(Message message) {
    r
        .table('messages')
        .get(message.id)
        .delete({'return_changes': false}).run(_connection);
  }
}
