

import 'dart:ui';
import 'package:movie/models/all_movies_model.dart';
import 'package:movie/models/tv_list_model.dart';

import '../../data/network/network_api_services.dart';
import '../../res/app_url/app_url.dart';

class HomeRepository {

  final _apiService  = NetworkApiServices() ;

  //trending movies
  Future<AllMoviesModel> moviesListApi() async{
    dynamic response = await _apiService.getApi(AppUrl.allMoviesListApi);
    return AllMoviesModel.fromJson(response) ;
  }

  //tv trending
  Future<TvListModel> tvListApi() async{
    dynamic response = await _apiService.getApi(AppUrl.tvListApiUrl);
    return TvListModel.fromJson(response) ;
  }

  //top rated Tv Series
  Future<AllMoviesModel> topRatedListApi() async{
    dynamic response = await _apiService.getApi(AppUrl.topRatedListApiUrl);
    return AllMoviesModel.fromJson(response) ;
  }

  //UpComing Movies
  Future<AllMoviesModel> upcomingMoviesListApi() async{
    dynamic response = await _apiService.getApi(AppUrl.upcomingMoviesListApiUrl);
    return AllMoviesModel.fromJson(response) ;
  }

  //Top Rated Movies
  Future<AllMoviesModel> topRatedMoviesListApi() async{
    dynamic response = await _apiService.getApi(AppUrl.topRatedMoviesListApiUrl);
    return AllMoviesModel.fromJson(response) ;
  }

  //Popular Tv Series
  Future<AllMoviesModel> popularTvSeriesListApi() async{
    dynamic response = await _apiService.getApi(AppUrl.popularTvListApiUrl);
    return AllMoviesModel.fromJson(response) ;
  }

}