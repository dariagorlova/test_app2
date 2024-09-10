import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_app2/core/constants.dart';

abstract class ApiService {
  Future<bool> postData(String name, String email, String phone);
}

class ApiServiceImpl implements ApiService {
  const ApiServiceImpl();

  @override
  Future<bool> postData(String name, String email, String phone) async {
    try {
      final response = await http.post(
        Uri.parse(sampleUrl),
        body: jsonEncode({'name': name, 'email': email, 'phone': phone}),
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }
}
