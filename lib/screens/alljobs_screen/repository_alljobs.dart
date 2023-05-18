import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fx_project/models/alljobsresponsemodel.dart';
import 'package:fx_project/screens/alljobs_screen/services.dart';

class PaginationRepository {
  final AllJobsService service;

  PaginationRepository(this.service);

  Future<List<Result>?> fetchPosts(int page) async {
    final dataResults = await service.allJobsService(page);
    final jsonData = AllJobsResponesModel.fromJson(dataResults);
    print('dr${dataResults}');

    return jsonData.results;
  }
}

// class AlljobRepository {
//   final AllJobsService service;

//   AlljobRepository(this.service);

//   Future<List<Result>> fetchPosts(int page) async {
//     final dataResults = await service.allJobsService(page);
//     final jsonData = AllJobsResponseModel.fromJson(dataResults);
//     print('dr${dataResults}');
    
//     return jsonData.results;
    
//   }
// }