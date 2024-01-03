

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movie/data/network/base_api_services.dart';

import '../app_exceptions.dart';

class NetworkApiServices extends BaseApiServices {


  @override
  Future<dynamic> getApi(String url)async{

    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson ;
    try {

      final response = await http.get(Uri.parse(url),
          headers: {'Authorization':'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyOWIxNzNhZjZiYzMwMGJkYzBmM2VhZjFkM2I2ZmY0YSIsInN1YiI6IjY1NzJlZTEwOWEzNThkMDExZDUxNDcxNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kOPtWxx6olRgPhDcJuWZ1fuGxfJJa40vBT7_dBi4fP4',
      'accept': 'application/json'}).timeout( const Duration(seconds: 10));
      responseJson  = returnResponse(response) ;
    }on SocketException {
      throw InternetException('');
    }on RequestTimeOut {
      throw RequestTimeOut('');

    }
    print(responseJson);
    return responseJson ;

  }


  @override
  Future<dynamic> postApi(var data , String url)async{

    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson ;
    try {

      final response = await http.post(Uri.parse(url),
        body: data
      ).timeout( const Duration(seconds: 10));
      responseJson  = returnResponse(response) ;
    }on SocketException {
      throw InternetException('');
    }on RequestTimeOut {
      throw RequestTimeOut('');

    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson ;

  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;

      default :
        throw FetchDataException('Error accoured while communicating with server '+response.statusCode.toString()) ;
    }
  }

}