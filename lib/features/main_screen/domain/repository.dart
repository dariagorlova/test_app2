import 'dart:async';

abstract class Repository {
  Future<bool> sendData(String name, String email, String phone);
}
