import 'package:flutter/foundation.dart';

class Log{
  static print(message){
    if(kDebugMode){
      print(message.toString());
    }
  }
}