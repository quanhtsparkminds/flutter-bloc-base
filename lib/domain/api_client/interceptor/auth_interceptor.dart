import 'package:dio/dio.dart';
import 'package:myapp/commands/bootstrap_command.dart';
import 'package:myapp/domain/api_client/api_config.dart';
import 'package:myapp/shared/widgets/dialog_custom.dart';

const title = 'AuthLogInterceptor';

/// [AuthLogInterceptor] is used to print logs during network requests.
/// It's better to add [AuthLogInterceptor] to the tail of the interceptor queue,
/// otherwise the changes made in the interceptor behind A will not be printed out.
/// This is because the execution of interceptors is in the order of addition.
///
class AuthLogInterceptor extends Interceptor {
  AuthLogInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
    this.logPrint = print,
  });

  bool request;
  bool requestHeader;
  bool requestBody;
  bool responseBody;
  bool responseHeader;
  bool error;

  void Function(Object object) logPrint;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logPrint('************************* Request ************************');
    printKV('uri', options.uri);

    if (request) {
      printKV('method', options.method);
      // printKV('path', options.path);
      printKV('responseType', options.responseType.toString());
      printKV('extra', options.extra);
    }
    if (requestHeader) {
      logPrint('headers:');
      options.headers.forEach((key, v) => printKV(' $key', v));
    }
    if (requestBody) {
      logPrint('requestBodyData:');
      printAll(options.data);
    }

    logPrint('*************************************************');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logPrint('************************ Response ************************');
    printKV('uri', response.requestOptions.uri);
    _printResponse(response);

    if (response.requestOptions.path == ApiConfig.loginWithEmail) {
      if (response.statusCode == 200) {}
    } else if (response.requestOptions.path == '/auth/login/phone') {
    } else {
      if (response.statusCode == 401 &&
          response.requestOptions.path != '/auth/logout') {}
    }
    logPrint('*************************************************');
    // return handler.next(response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (error) {
      logPrint('************************ DioError ************************');
      logPrint('uri: ${err.requestOptions.uri}');
      // logPrint('path: ${err.requestOptions.path}');
      logPrint('$err');
      if (err.response != null) {
        _printResponse(err.response!);
      } else {
        showMessageDialog(BootstrapCommand().mainNavigator!,
            title: 'Connection Failed',
            message:
                'The system is under maintenance, Please try again in a few seconds');
      }
      logPrint('*************************************************');
    }
    return handler.next(err);
  }

  void _printResponse(Response response) {
    printKV('statusCode', response.statusCode!);
    if (responseHeader) {
      if (response.isRedirect == true) {
        printKV('redirect', response.realUri);
      }
      logPrint('headers:');
      response.headers.forEach((key, v) => printKV(' $key', v.join(',')));
    }
    if (responseBody) {
      logPrint('Response Text:');
      //printAll(response.toString());

      final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      pattern
          .allMatches(response.toString())
          .forEach((match) => printAll(match.group(0)));
    }
  }

  void printKV(String key, Object v) {
    logPrint('$key: $v');
  }

  void printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }
}
