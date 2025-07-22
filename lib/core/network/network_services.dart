import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'app_end_points.dart';

class NetworkServices {
  static late Dio _dio;

  static init() {
    BaseOptions options = BaseOptions(
      baseUrl: AppEndPoints.baseUrl,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      receiveTimeout: Duration(seconds: 60),
      connectTimeout: Duration(seconds: 60),
    );
    _dio = Dio(options);
  }

  static Future<Either<String, dynamic>> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print("request url ===> ${_dio.options.baseUrl + endPoint}");
      final response = await _dio.get(
        endPoint,
        queryParameters: queryParameters,
      );
      print("app dio =====>  ${response.data}");
      print("API CALL: $endPoint");
      print("Params: $queryParameters");
      // print("📡 Response Data: $data");

      return Right(response.data);
    } on DioException catch (e) {
      print("app dio error =====>  ${e.response}");
      return Left(
        e.response?.data['status_message'] ?? "Unknown error occurred",
      );
    }
  }
}
