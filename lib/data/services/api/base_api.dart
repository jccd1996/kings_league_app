import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

enum HttpMethod {
  get,
  post,
  patch,
  delete,
}

abstract class BaseApi {
  String? get baseUrl;

  http.Client get client => http.Client();

  Duration get timeOut => const Duration(seconds: 30);

  Future<T> getApi<T>(
    String url,
    T Function(dynamic value) mapperFunction, {
    Map<String, String>? headers,
  }) async {
    final BaseAPIRequest request = BaseAPIRequest(
      uri: Uri.parse(baseUrl! + url),
      requestMethod: HttpMethod.get,
    );
    return _callApi(request, mapperFunction);
  }

  Future<T> _callApi<T>(
    BaseAPIRequest request,
    T Function(dynamic value) mapperFunction, {
    Function? callBack,
  }) async {
    try {
      var response = await _processApi(request);
      if (callBack != null) {
        await callBack(response.statusCode);
      }
      return await _manageResponse(response, mapperFunction);
    } catch (error) {
      rethrow;
    }
  }

  Future<http.Response> _processApi(BaseAPIRequest request) async {
    late http.Response? response;
    final httpServices = {
      HttpMethod.get: await _getResponse(request),
      HttpMethod.post: await _postResponse(request),
      HttpMethod.patch: await _pathResponse(request),
      HttpMethod.delete: await _deleteResponse(request),
    };
    response = httpServices[request.requestMethod];
    return response!;
  }

  Future<http.Response> _getResponse(BaseAPIRequest request) async {
    return client.get(request.uri, headers: request.headers).timeout(timeOut);
  }

  Future<http.Response> _postResponse(BaseAPIRequest request) async {
    return client
        .post(request.uri, headers: request.headers, body: request.body)
        .timeout(timeOut);
  }

  Future<http.Response> _pathResponse(BaseAPIRequest request) async {
    return client
        .patch(request.uri, headers: request.headers, body: request.body)
        .timeout(timeOut);
  }

  Future<http.Response> _deleteResponse(BaseAPIRequest request) async {
    return client.get(request.uri, headers: request.headers).timeout(timeOut);
  }

  Future<T> _manageResponse<T>(
      http.Response response, Function(dynamic value) mapperFunction) async {
    _showLogs(response);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return mapperFunction(_getBody(response.bodyBytes));
    } else {
      throw Exception();
    }
  }

  dynamic _getBody(dynamic body) {
    String bodyString;
    if (body is String) {
      bodyString = body;
    } else {
      bodyString = utf8.decode(body);
    }
    try {
      return json.decode(bodyString);
    } catch (_) {
      return bodyString;
    }
  }

  void _showLogs(http.Response response) {
    JsonDecoder decoder = const JsonDecoder();
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    log(response.request!.url.toString(), name: 'url');
    log(response.request!.method, name: 'method');
    log(response.statusCode.toString(), name: 'statusCode');
    if (response is http.Response) {
      try {
        var object = decoder.convert(response.body);
        var prettyString = encoder.convert(object);
        log('''-----RESPONSE----
      $prettyString
      -----END RESPONSE----
      ''', name: 'responseBody');
      } catch (e) {
        log('NO RESPONSE');
      }
    }
  }
}

class BaseAPIRequest {
  final Uri uri;
  final HttpMethod requestMethod;
  final Map<String, String>? headers;
  final Object? body;

  BaseAPIRequest({
    required this.uri,
    required this.requestMethod,
    this.headers,
    this.body,
  });
}
