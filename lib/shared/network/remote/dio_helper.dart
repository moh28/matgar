import 'package:dio/dio.dart';
import '../local/cache_helper.dart';
class DioHelper{
  static  Dio? dio;
  static init(){
    dio =Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,

      ),
    );
  }
  static Future<Response> getData ({
    required String url,
     Map<String, dynamic>? query,
    String? lang='en',
    String? token})
  async{
    dio!.options.headers= {
      'lang':lang,
      'Authorization':CacheHelper.getData(key: 'token'),
      'Content-Type':'application/json'
    };
    return await  dio!.get(url, queryParameters: query);
  }
  static Future<Response> postData(
      {
        required String? url,
        required Map<String,dynamic>? data,
         Map<String,dynamic>? query,
        String? lang='en',
        String? token
      }
      )async
  {
    dio!.options.headers= {
      'lang':lang,
      'Authorization':CacheHelper.getData(key: 'token'),
      'Content-Type':'application/json'
    };
    //print("data "+data.toString());
    return await dio!.post(
        url!,
         queryParameters: query,
        data: data
    );


  }
  static Future<Response> putData(
      {
        required String? url,
        required Map<String,dynamic>? data,
        Map<String,dynamic>? query,
        String? lang='en',
        String? token
      }
      )async
  {
    dio!.options.headers= {
      'lang':lang,
      'Authorization':CacheHelper.getData(key: 'token'),
      'Content-Type':'application/json'
    };
    //print("data "+data.toString());
    return await dio!.put(
        url!,
        queryParameters: query,
        data: data
    );


  }
}