import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'dart:async';
 
class LoggingInterceptor implements InterceptorContract {
  @override
   Future<bool> shouldInterceptRequest() async {
    return Future.value(true);
  }

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    print('Request');
    print('url: ${request.url}');
    print('headers: ${request.headers}');
    //print('body: ${request.body}');
    return request;
  }

  @override
    Future<bool> shouldInterceptResponse() async {
    return Future.value(true);
  }

  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) async {
    print('Response');
    print('status code: ${response.statusCode}');
    print('headers: ${response.headers}');
    if (response is http.StreamedResponse) {
      final responseBody = await response.stream.bytesToString();
      print('body: $responseBody');
    }
    return response;
  }
}
