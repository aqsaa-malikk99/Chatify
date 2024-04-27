import 'package:chatify/src/models/message.dart';
import 'package:chatify/src/models/user.dart';
import 'package:chatify/src/services/encryption/encryption_service_implementation.dart';
import 'package:chatify/src/services/message/message_service_implementation.dart';
import 'package:encrypt/encrypt.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';

import 'helpers.dart';

void main() {
  RethinkDb r = RethinkDb();
  Connection? connection;
  MessageService? sut;

  final user1 = User.fromJson({
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
    final encryption=EncryptedService(Encrypter(AES(Key.fromLength(32))));
    await createDb(r, connection!);
    sut = MessageService(r, connection!,encryption);
  });
  tearDown(() async {
    await cleanDB(r, connection!);
  });
  test('sent message successfully', () async {
    Message message = Message(
        from: user1.id ?? "",
        to: '3456',
        timestamp: DateTime.now(),
        contents: 'this is a message');
    final res = await sut!.send(message);
    expect(res, true);
  });

  test('sucessfully subscribe and receive messages', () async {
    const contents='this is an another message';
    sut!.messages(activeUser: user2).listen(expectAsync1((message) {
          expect(message.to, user2.id);
          expect(message.id, isNotEmpty);
          expect(message.contents, contents);
        }, count: 2));

    Message message = Message(
        from: user1.id!,
        to: user2.id!,
        timestamp: DateTime.now(),
        contents: contents);
    Message secondMessage = Message(
        from: user1.id!,
        to: user2.id!,
        timestamp: DateTime.now(),
        contents: contents);
    await sut!.send(message);
    await sut!.send(secondMessage);
  });
}
