import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/commands/core/app_key.dart';
import 'package:myapp/domain/api_client/api_config.dart';
import 'package:myapp/domain/api_client/interceptor/auth_interceptor.dart';
import 'package:myapp/domain/api_client/interceptor/dio_cache_interceptor.dart';
import 'package:myapp/config/env.dart';
import 'package:myapp/shared/helps/spref.dart';

const title = 'ApiUtils';

Dio get apiUtils => ApiUtils().apiClient;

class ApiUtils {
  ApiUtils._internal();
  static final ApiUtils _apiUtils = ApiUtils._internal();
  Dio _dio = Dio();
  Dio get apiClient => _dio;

  intialize() async {
    String xToken = await SPref.instance.get(AppKey.xToken);
    _dio = Dio()
      ..options.baseUrl = dotenv.env[EnvKeys.baseUrl]!
      ..options.headers = {
        'Content-Type': 'application/json',
        'Authorization': xToken
      }
      ..options.connectTimeout = ApiConfig.connectionTimeout
      ..options.receiveTimeout = ApiConfig.receiveTimeout
      ..options.responseType = ResponseType.json
      ..interceptors.addAll([
        AuthLogInterceptor(),
        DioCacheInterceptor(options: CacheInterceptor.options),
      ])
      ..options.validateStatus = (status) => status != null;
  }

  setToken(String token) {
    _dio.options = _dio.options.copyWith(headers: {
      'Authorization': 'Bearer $token',
      'content-Type': 'application/json',
    });
  }

  factory ApiUtils() {
    return _apiUtils;
  }

  getFormattedError() {
    return {'error': 'Error'};
  }

  getNetworkError() {
    return 'No Internet Connection.';
  }
}
