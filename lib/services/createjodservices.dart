import 'package:dio/dio.dart';
import 'package:fx_project/services/loginservice.dart';

class CreateJobServices {
  final Dio service;

  CreateJobServices({required this.service});

  //Future<CreateJobResponseModel?> createJobService() async {
  Future<List<dynamic>?> createJobService() async {
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
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
    return (response.data);
  }

  Future<dynamic> uploadDataCreateJobService(uploadFile) async {
    dynamic token = await LoginService.getToken();
    var data = uploadFile;
    bool validateStatus(status) {
      return status! <= 500;
    }

    final options = Options(
        validateStatus: validateStatus,
        headers: {"Authorization": "Bearer $token", "source": "android"});
    final response = await service.post(
      '',
      data: data,
      options: options,
    );
    if (response.statusCode == 201) {
      print(response.statusCode);
      print(response.data);
    } else {
      print(response.statusCode);
      print(response);
    }
    return (response.data);
  }

  Future<dynamic> deleteDataService() async {
    dynamic token = await LoginService.getToken();

    bool validateStatus(status) {
      return status! <= 500;
    }

    final options = Options(
        validateStatus: validateStatus,
        headers: {"Authorization": "Bearer $token", "source": "android"});
    final response = await service.delete(
      '',
      options: options,
    );

    if (response.statusCode == 201) {
      print(response.statusCode);
      print(response.data);
    } else {
      print(response.statusCode);
      print(response);
    }
    return (response.data);
  }
}
