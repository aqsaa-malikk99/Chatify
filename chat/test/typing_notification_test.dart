import 'package:chat/src/models/typing_event.dart';
import 'package:chat/src/models/user.dart';
import 'package:chat/src/services/typing/typing_service_implementation.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';

import 'helpers.dart';

void main() {
  RethinkDb r = RethinkDb();
  Connection? connection;
  TypingNotification? sut;

  final user = User.fromJson({
    'id': '1234',
    'username': 'awsa',
    'photoUrl': 'abc',
    'active': true,
    'lastseen': DateTime.now(),
  });

  final user2 = User.fromJson({
    'id': '1111',
    'username': 'laiba',
    'photoUrl': 'abc',
    'active': true,
    'lastseen': DateTime.now(),
  });

  setUp(() async {
    connection = await r.connect(host: '127.0.0.1', port: 28015);
    await createDb(r, connection!);
    sut = TypingNotification(r: r, connection!);
  });
  tearDown(() async {
    sut!.dispose();
    await cleanDB(r, connection!);
  });
  test('sent typing notification successfully', () async {
    TypingEvent typingEvent =
        TypingEvent(from: user2.id!, to: user.id!, event: Typing.start);
    final res = await sut!.send(event: typingEvent, to: user);
    expect(res, true);
  });

  test('subscribe to receive type events', () async {
    sut!.subscribe(user2, [user.id!]).listen(
      expectAsync1((event) {
        expect(event.from, user.id!);
      }, count: 2),
    );
    TypingEvent typing =
        TypingEvent(from: user.id!, to: user2.id!, event: Typing.start);
    TypingEvent typing2 =
        TypingEvent(from: user.id!, to: user2.id!, event: Typing.stop);
    await sut!.send(event: typing, to: user2);
    await sut!.send(event: typing2, to: user2);
  });
}
