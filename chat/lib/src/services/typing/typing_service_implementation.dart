// ignore_for_file: unused_import

import 'dart:async';

import 'package:chat/src/models/typing_event.dart';
import 'package:chat/src/models/user.dart';
import 'package:chat/src/services/typing/typing_service_contract.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';

import '../../helper/logger.dart';

class TypingNotification implements ITypingNotification {
  final Connection _connection;
  final RethinkDb r;
  final _controller = StreamController<TypingEvent>.broadcast();
  StreamSubscription? _changefeed;
  TypingNotification(this._connection, {required this.r});
  @override
  void dispose() {
    _changefeed?.cancel();
    _controller.close();
  }

  @override
  Future<bool> send({required TypingEvent event, required User to}) async {
    if (!to.active) return false;
    Map record = await r
        .table('typing_events')
        .insert(event.toJson(), {'conflict': 'update'}).run(_connection);
    return record['inserted'] == 1;
  }

  @override
  Stream<TypingEvent> subscribe(User user, List<String> userIds) {
    _startReceivingTypingEvent(user, userIds);
    return _controller.stream;
  }

  _startReceivingTypingEvent(User user, List<String> userIds) {
    _changefeed = r
        .table('typing_events')
        .filter((event) {
          //receive events which is sent to me and where chats are related to me
          return event('to')
              .eq(user.id)
              .and(r.expr(userIds).contains(event('from')));
        })
        .changes({'include_initial': true})
        .run(_connection)
        .asStream()
        .cast<Feed>()
        .listen((event) {
          event
              .forEach((feedData) {
                if (feedData['new_val'] == null) return;
                final typing = _receiptFromFeed(feedData);
                _controller.sink.add(typing);
                _removeEvent(typing);
              })
              .catchError((err, stackTrace) => Log.print(err))
              .onError((error, stackTrace) => Log.print(error));
        });
  }

  TypingEvent _receiptFromFeed(feedData) {
    //receiving feed
    //decryption
    var data = feedData['new_val'];

    return TypingEvent.fromJson(data);
  }

  _removeEvent(TypingEvent event) {
    r
        .table("typing_events")
        .get(event.id)
        .delete({'return_changes': false}).run(_connection);
  }
}
