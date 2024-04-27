import '../../models/receipt.dart';
import '../../models/user.dart';

abstract class IReceiptService{
  Future<bool> send(Receipt receipt);
  Stream<Receipt> receipt(User user);
  void dispose();
}