// ignore_for_file: unnecessary_this


import 'package:encrypt/encrypt.dart';

import 'encryption_service_contract.dart';

class EncryptedService implements IEncryption{
  final Encrypter _encrypter;
  final _iv=IV.fromLength(16);

  EncryptedService(this._encrypter, );
  @override
  String decrypt(String encryptedText) {
    final encrypted=Encrypted.fromBase64(encryptedText);
    return _encrypter.decrypt(encrypted,iv: this._iv);

  }
  @override
  String encrypt(String text) {
    return _encrypter.encrypt(text,iv: _iv).base64;
  }
}