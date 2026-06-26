import 'package:carrefour/library/library.dart';
import 'package:dio/dio.dart';

enum DioType { auth, offline }

class DioManager {
  static final DioManager _singleton = DioManager._internal();

  factory DioManager() {
    return _singleton;
  }

  final _connectTimeout = const Duration(seconds: 60);
  final _receiveTimeout = const Duration(seconds: 60);
  static const _appVersionHeaderKey = 'X-App-Version';
  static const _appPlatformHeaderKey = 'X-App-Platform';
  static const _appTokenHeaderKey = 'X-device-token';

  final _headers = {
    Headers.acceptHeader: Headers.jsonContentType,
    Headers.contentTypeHeader: Headers.jsonContentType,
  };

  BaseOptions get option => BaseOptions(
        baseUrl: domain,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        headers: _headers,
      );

  late Dio mainDio;
  late Dio customDio;

  DioManager._internal() {
    mainDio = Dio(option);
    mainDio.transformer = CustomTransformer();
    customDio = Dio(option);
    customDio.transformer = CustomTransformer();
    addAppVersionInterceptor();
    addMainInterceptor();
  }

  void addAppVersionInterceptor() {
    final addHeaders = (options) async {
      options.headers[_appVersionHeaderKey] = await HelperManager.version;
      options.headers[_appPlatformHeaderKey] = HelperManager.os;
      options.headers[_appTokenHeaderKey] = HelperManager.appToken;
    };
    customDio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          await addHeaders(options);
          handler.next(options);
        },
      ),
    );
  }

  addMainInterceptor() async {
    final addAppHeaders = (options) async {
      options.headers[_appVersionHeaderKey] = await HelperManager.version;
      options.headers[_appPlatformHeaderKey] = HelperManager.os;
      options.headers[_appTokenHeaderKey] = HelperManager.appToken;
    };
    mainDio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          await addAppHeaders(options);
          if (HelperManager.isLogged) {
            if (HelperManager.token.isExpired) {
              final response = await CustomerApi().getAccessToken(
                refresh: HelperManager.token.refresh,
              );
              if (response.json.exist('access')) {
                final token = TokenModel.fromJson(response.json);
                // token. = response.json['access'].stringValue;
                await UserStoreManager.shared.write(kToken, token.toMap());
                options.headers['Authorization'] =
                    'Bearer ${HelperManager.token.access}';
                handler.next(options);
              } else {}
            } else {
              options.headers['Authorization'] =
                  'Bearer ${HelperManager.token.access}';
              handler.next(options);
            }
          } else {
            handler.next(options);
          }
        },
        // onError: (err, handler) async {
        //   if (err.response?.statusCode == 401) {
        //     final response = await CustomerApi().refreshToken(
        //       refresh: HelperManager.token.refresh,
        //     );
        //     if (response.json.exist('access')) {
        //       final token = Helper.token;
        //       token.access = response.json['access'].stringValue;
        //       await UserStoreManager.shared.write(kToken, token.toMap());

        //       try {
        //         RequestOptions requestOptions = err.requestOptions;
        //         handler.resolve(
        //           await mainDio.request(
        //             requestOptions.path,
        //             options: Options(method: requestOptions.method),
        //             data: requestOptions.data,
        //             queryParameters: requestOptions.queryParameters,
        //           ),
        //         );
        //       } on DioException catch (e) {
        //         handler.next(e);
        //       }
        //     } else {
        //       handler.next(err);
        //     }
        //   } else {
        //     handler.next(err);
        //   }
        // },
      ),
    );
  }
}

class CustomTransformer extends BackgroundTransformer {
  @override
  Future<String> transformRequest(RequestOptions options) async {
    options.path = Uri.decodeFull(options.path);
    return super.transformRequest(options);
  }
}
