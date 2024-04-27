import 'dart:async';

import 'package:chatify/src/models/receipt.dart';
import 'package:chatify/src/models/user.dart';
import 'package:chatify/src/services/receipt/receipt_service_contract.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';

import '../../helper/logger.dart';

class ReceiptService implements IReceiptService {
  final Connection _connection;
  final RethinkDb r;
  final _controller = StreamController<Receipt>.broadcast();
  StreamSubscription? _changefeed;
  ReceiptService(this._connection, {required this.r});
  @override
  void dispose() {
    _changefeed?.cancel();
    _controller.close();
  }



  @override
  Future<bool> send(Receipt receipt) async {
    var data = receipt.toJson();
    Map record = await r.table("receipts").insert(data).run(_connection);
    return record['inserted'] == 1;
  }
  @override
  Stream<Receipt> receipt(User user) {
    _startReceivingReceipt(user);
    return _controller.stream;
  }
  _startReceivingReceipt(User user) {
    _changefeed = r
        .table('receipts')
        .filter({'recipient': user.id})
        .changes({'include_initial': true})
        .run(_connection)
        .asStream()
        .cast<Feed>()
        .listen((event) {
          event
              .forEach((feedData) {
                if (feedData['new_val'] == null) return;
                final receipt = _receiptFromFeed(feedData);
                _controller.sink.add(receipt);
              })
              .catchError((err, stackTrace) => Log.print(err))
              .onError((error, stackTrace) => Log.print(error));
        });
  }

  Receipt _receiptFromFeed(feedData) {
    //receiving feed
    //decryption
    var data = feedData['new_val'];

    return Receipt.fromJson(data);
  }
}
