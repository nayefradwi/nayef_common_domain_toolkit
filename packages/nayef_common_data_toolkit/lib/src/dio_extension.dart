import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart' show MediaType;

mixin MultiPartDio on DioMixin {
  Future<dynamic> postMultipartData(
    String requestUrl, {
    required Map<String, dynamic> data,
    File? file,
    String attachmentKey = 'file',
    Map<String, dynamic>? queryParameters,
    bool useOriginalFileName = false,
  }) async {
    final multipartFile = _generateMultiPartFile(
      file,
      useOriginalFileName: useOriginalFileName,
    );
    data[attachmentKey] = multipartFile;
    final formData = FormData.fromMap(data);
    final response = await post<dynamic>(
      requestUrl,
      data: formData,
      queryParameters: queryParameters,
      options: options.asOptions(
        contentType: 'multipart/form-data',
      ),
    );
    return response;
  }

  MultipartFile? _generateMultiPartFile(
    File? file, {
    bool useOriginalFileName = false,
  }) {
    if (file == null) return null;
    final fileName = file.path.split('/').last;
    final subType = fileName.split('.').last;
    return MultipartFile.fromFileSync(
      file.path,
      filename: useOriginalFileName ? fileName : 'file',
      contentType: MediaType(
        'image',
        subType,
      ),
    );
  }
}

mixin FormUrlEncodedDio on DioMixin {
  Future<dynamic> postFormUrlEncoded(
    String requestUrl, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await super.post<dynamic>(
      requestUrl,
      data: data,
      queryParameters: queryParameters,
      options: options.asOptions(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    return response;
  }
}

extension BaseOptionsToOptions on BaseOptions {
  Options asOptions({
    String? method,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? headers,
    ResponseType? responseType,
    String? contentType,
    bool Function(int?)? validateStatus,
    bool? receiveDataWhenStatusError,
    bool? followRedirects,
    int? maxRedirects,
    RequestEncoder? requestEncoder,
    ResponseDecoder? responseDecoder,
    ListFormat? listFormat,
  }) {
    return Options(
      method: method ?? this.method,
      sendTimeout: sendTimeout ?? this.sendTimeout,
      receiveTimeout: receiveTimeout ?? this.receiveTimeout,
      extra: extra ?? this.extra,
      headers: headers ?? this.headers,
      responseType: responseType ?? ResponseType.json,
      contentType: contentType ?? this.contentType,
      validateStatus: validateStatus ?? this.validateStatus,
      receiveDataWhenStatusError:
          receiveDataWhenStatusError ?? this.receiveDataWhenStatusError,
      followRedirects: followRedirects ?? this.followRedirects,
      maxRedirects: maxRedirects ?? this.maxRedirects,
      requestEncoder: requestEncoder ?? this.requestEncoder,
      responseDecoder: responseDecoder ?? this.responseDecoder,
      listFormat: listFormat ?? this.listFormat,
    );
  }
}
