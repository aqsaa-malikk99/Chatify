import 'dart:async';

import 'package:chatify/src/models/message.dart';
import 'package:chatify/src/models/user.dart';
import 'package:chatify/src/services/message/message_service_contract.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';

class MessageService implements IMessageService {
  final Connection _connection;
  final RethinkDb r;
  StreamSubscription? _changefeed;

  final _controller = StreamController<Message>.broadcast();
  MessageService(this.r, this._connection);

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
    Map record =
        await r.table("messages").insert(message.toJson()).run(_connection);
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
              .catchError((err, stackTrace) => print(err))
              .onError((error, stackTrace) => print(error));
        });
  }

  Message _messageFromFeed(feedData) {
    return Message.fromJson(feedData['new_val']);
  }

  _removeDeliveredMessage(Message message) {
    r
        .table('message')
        .get(message.id)
        .delete({'return_changes': 'false'}).run(_connection);
  }
}
