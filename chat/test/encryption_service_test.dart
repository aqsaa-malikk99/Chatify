import 'package:chat/src/services/encryption/encryption_service_contract.dart';
import 'package:chat/src/services/encryption/encryption_service_implementation.dart';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';

main(){
  IEncryption? sut;
  setUp(() {
    final encrypter=Encrypter(AES(Key.fromLength(32)));
    sut= EncryptedService(encrypter);
  });
  test("it encrypts plain text", () {
    const text='this is a message';
    final base64=RegExp(r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$');
    final encrypted=sut!.encrypt(text);
    expect(base64.hasMatch(encrypted),true);
  });
  test("it decrypts the encrypted test", () {
    const text='this is a message';
    final encrypted=sut!.encrypt(text);
    final decrypted=sut!.decrypt(encrypted);
    expect(decrypted,text);
  });
}