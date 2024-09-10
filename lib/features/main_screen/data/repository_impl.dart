import 'dart:async';

import 'package:test_app2/core/network_info.dart';
import 'package:test_app2/features/main_screen/data/api_service.dart';
import 'package:test_app2/features/main_screen/domain/repository.dart';

class RepositoryImpl implements Repository {
  final NetworkInfo _networkInfo;
  final ApiService _apiService;

  const RepositoryImpl(NetworkInfo networkInfo, ApiService apiService)
      : _networkInfo = networkInfo,
        _apiService = apiService;

  @override
  Future<bool> sendData(String name, String email, String phone) async {
    if (await _networkInfo.isConnected) {
      return _apiService.postData(name, email, phone);
    } else {
      return false;
    }
  }
}
