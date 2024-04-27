import 'package:chat/src/models/receipt.dart';
import 'package:chat/src/models/user.dart';
import 'package:chat/src/services/receipt/receipt_service_implementation.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';

import 'helpers.dart';



void main() {
  RethinkDb r = RethinkDb();
  Connection? connection;
  ReceiptService? sut;

  final user1 = User.fromJson({
    'id': '1234',
    'username': 'awsa',
    'photoUrl': 'abc',
    'active': true,
    'lastseen': DateTime.now(),
  });


  setUp(() async {
    connection = await r.connect(host: '127.0.0.1', port: 28015);
    await createDb(r, connection!);
    sut = ReceiptService(r: r, connection!);
  });
  tearDown(() async {
    sut!.dispose();
    await cleanDB(r, connection!);
  });
  test('sent receipt successfully', () async {
    Receipt receipt = Receipt(
        recipient: '444',
        messageId: '1234',
        status: ReceiptStatus.delivered,
        timestamp: DateTime.now());
    final res = await sut!.send(receipt);
    expect(res, true);
  });

  test('sucessfully subscribe and receive messages', () async {
    sut!.receipt(user1).listen(expectAsync1((receipt) {
          expect(receipt.recipient, user1.id);
        }, count: 2));
    Receipt receipt = Receipt(
        recipient: user1.id ?? "",
        messageId: '1234',
        status: ReceiptStatus.delivered,
        timestamp: DateTime.now());
    Receipt anotherReceipt = Receipt(
        recipient: user1.id ?? "",
        messageId: '1234',
        status: ReceiptStatus.read,
        timestamp: DateTime.now());
    await sut!.send(receipt);
    await sut!.send(anotherReceipt);
  });
}
