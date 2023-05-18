import 'package:fx_project/screens/environmentpage.dart';
import 'package:fx_project/services/loginservice.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AllJobsService {
  static final storage = FlutterSecureStorage();
  static const FETCH_LIMIT = 20;
  // EmergencyService({required this.service});

  Future<dynamic> allJobsService(int page) async {
    try {
      dynamic token = await LoginService.getToken();

      dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
      final Dio service = Dio(BaseOptions(baseUrl: 'https://$baseurl1'));

      bool validateStatus(status) {
        return status! <= 500;
      }

      final options = Options(
          validateStatus: validateStatus,
          headers: {"Authorization": "Bearer $token", "source": "android"});
      final response = await service.get(
        '/v1/jobs/?filter=active&page=$page',
        options: options,
      );
      print('tok $token');

      if (response.statusCode == 200) {
        print('success');
      } else {
        print(response.statusCode);
      }
      print('reonse${response.data}\n');

      print("print results: ${response.data['results'].toString()}");

      return response.data as dynamic;
    } catch (err) {
      print('error$err');
      return [];
    }
  }
}
