import 'package:dio/dio.dart';

import '../flutter_test/data/app_remote_routes.dart';
import 'custom_exception.dart';

class ApiProvider {
  late Dio dio;

  ApiProvider() {
    dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return true;
        },
        followRedirects: false,
        baseUrl: AppRemoteRoutes.baseUrl,
        connectTimeout: 30000,
        receiveTimeout: 30000,
      ),
    );
  }

  Future<Map<String, dynamic>> get(String endPoint) async {
    try {
      final Response response = await dio.get(
        endPoint,
      );

      final Map<String, dynamic> responseData = classifyResponse(response);
      return responseData;
    } on DioError catch (err) {
      throw FetchDataException("internetError");
    }
  }

  Map<String, dynamic> classifyResponse(Response response) {
    // print(response);
    final Map<String, dynamic> responseData =
        response.data as Map<String, dynamic>;
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
      case 201:
        return responseData;
      case 400:
        throw BadRequestException(responseData.toString());
      case 401:
        throw UnauthorisedException(responseData.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
  }
}
