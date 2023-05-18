import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fx_project/models/dashboardresponsemodel.dart';
import 'package:fx_project/services/loginservice.dart';

class DashBoardService {
  final Dio service;
  static final storage = FlutterSecureStorage();

  DashBoardService({required this.service});

  Future<DashBoardResponesModel?> dashBoardService() async {
    dynamic token = await LoginService.getToken();

    bool validateStatus(status) {
      return status! <= 500;
    }

    final options = Options(
        validateStatus: validateStatus,
        headers: {"Authorization": "Bearer $token", "source": "android"});

    final response = await service.get(
      '/v1/dashboard/',
      options: options,
    );
    print(token);
    if (response.statusCode == 200) {
      print('success');
    } else {
      print(response.statusCode);
    }
    print("response in dashboardservice: $response");
    return DashBoardResponesModel.fromJson(response.data);
  }
}
