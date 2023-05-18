import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fx_project/models/alljobsresponsemodel.dart';
import 'package:fx_project/services/loginservice.dart';

class AllJobsServices {
  final Dio service;
  static final storage = FlutterSecureStorage();

  AllJobsServices({required this.service});

  Future<AllJobsResponesModel?> allJobsService() async {
    dynamic token = await LoginService.getToken();

    bool validateStatus(status) {
      return status! <= 500;
    }

    final options = Options(
        validateStatus: validateStatus,
        headers: {"Authorization": "Bearer $token", "source": "android"});

    final response = await service.get(
      '',
      options: options,
    );

    if (response.statusCode == 200) {
      print('success');
    } else {
      print(response.statusCode);
    }
    print("response in alljobsservice: $response");
    return AllJobsResponesModel.fromJson(response.data);
  }
}
