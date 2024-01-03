
import 'package:get/get.dart';
import 'package:movie/models/all_movies_model.dart';
import 'package:movie/models/tv_list_model.dart';

import '../../../data/response/status.dart';
import '../../../repository/home_repository/hone_repository.dart';

class HomeController extends GetxController {

  final _api = HomeRepository();


  final rxRequestStatus = Status.LOADING.obs ;
  final rxRequestStatusTv = Status.LOADING.obs ;
  final rxRequestStatusTop = Status.LOADING.obs ;
  final rxRequestStatusUpcomingMovies = Status.LOADING.obs ;
  final rxRequestStatusTopRatedMovies = Status.LOADING.obs ;
  final rxRequestStatusPopularTvSeries = Status.LOADING.obs ;
  final moviesList =AllMoviesModel().obs ;
  final tvList =TvListModel().obs ;
  final topRatedList =AllMoviesModel().obs ;
  final upcomingMoviesList =AllMoviesModel().obs ;
  final topRatedMoviesList =AllMoviesModel().obs ;
  final popularTvSeriesList =AllMoviesModel().obs ;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setRxRequestStatusTv(Status _value) => rxRequestStatusTv.value = _value ;
  void setRxRequestStatusTop(Status _value) => rxRequestStatusTop.value = _value ;
  void setRxRequestStatusUpcomingMovies(Status _value) => rxRequestStatusUpcomingMovies.value = _value ;
  void setRxRequestStatusTopRatedMovies(Status _value) => rxRequestStatusTopRatedMovies.value = _value ;
  void setRxRequestStatusPopularTvSeries(Status _value) => rxRequestStatusPopularTvSeries.value = _value ;
  void setMoviesList(AllMoviesModel _value) => moviesList.value = _value ;
  void setTvList(TvListModel _value) => tvList.value = _value ;
  void setTopRatedList(AllMoviesModel _value) => topRatedList.value = _value ;
  void setUpcomingMoviesList(AllMoviesModel _value) => upcomingMoviesList.value = _value ;
  void setTopRatedMoviesList(AllMoviesModel _value) => topRatedMoviesList.value = _value ;
  void setPopularTvSeriesList(AllMoviesModel _value) => popularTvSeriesList.value = _value ;
  void setError(String _value) => error.value = _value ;


  void moviesListApi(){
   setRxRequestStatus(Status.LOADING);
    _api.moviesListApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      setMoviesList(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
      print(error.toString());
    });
  }

  void tvListApi(){
    setRxRequestStatusTv(Status.LOADING);
    _api.tvListApi().then((value){
      setRxRequestStatusTv(Status.COMPLETED);
      setTvList(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      setRxRequestStatusTv(Status.ERROR);
      print(error.toString());
    });
  }

  void topRatedListApi(){
    setRxRequestStatusTop(Status.LOADING);
    _api.topRatedListApi().then((value){
      setRxRequestStatusTop(Status.COMPLETED);
      setTopRatedList(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      setRxRequestStatusTop(Status.ERROR);
      print(error.toString());
    });
  }

  void upcomingMoviesListApi(){
    setRxRequestStatusUpcomingMovies(Status.LOADING);
    _api.upcomingMoviesListApi().then((value){
      setRxRequestStatusUpcomingMovies(Status.COMPLETED);
      setUpcomingMoviesList(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      setRxRequestStatusUpcomingMovies(Status.ERROR);
      print(error.toString());
    });
  }

  void topRatedMoviesListApi(){
    setRxRequestStatusTopRatedMovies(Status.LOADING);
    _api.topRatedMoviesListApi().then((value){
      setRxRequestStatusTopRatedMovies(Status.COMPLETED);
      setTopRatedMoviesList(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      setRxRequestStatusTopRatedMovies(Status.ERROR);
      print(error.toString());
    });
  }

  void popularTvSeriesListApi(){
    setRxRequestStatusPopularTvSeries(Status.LOADING);
    _api.popularTvSeriesListApi().then((value){
      setRxRequestStatusPopularTvSeries(Status.COMPLETED);
      setPopularTvSeriesList(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      setRxRequestStatusPopularTvSeries(Status.ERROR);
      print(error.toString());
    });
  }

  void refreshApi(){

      setRxRequestStatus(Status.LOADING);

    _api.moviesListApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      setMoviesList(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
      print(error.toString());
    });
  }

  void refreshTvListApi(){
    setRxRequestStatusTv(Status.LOADING);
    _api.tvListApi().then((value){
      setRxRequestStatusTv(Status.COMPLETED);
      setTvList(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      setRxRequestStatusTv(Status.ERROR);
      print(error.toString());
    });
  }

  void refreshTopRatedListApi(){
    setRxRequestStatusTop(Status.LOADING);
    _api.topRatedListApi().then((value){
      setRxRequestStatusTop(Status.COMPLETED);
      setTopRatedList(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      setRxRequestStatusTop(Status.ERROR);
      print(error.toString());
    });
  }

  void refreshUpcomingMoviesListApi(){
    setRxRequestStatusUpcomingMovies(Status.LOADING);
    _api.upcomingMoviesListApi().then((value){
      setRxRequestStatusUpcomingMovies(Status.COMPLETED);
      setUpcomingMoviesList(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      setRxRequestStatusUpcomingMovies(Status.ERROR);
      print(error.toString());
    });
  }

  void refreshTopRatedMoviesListApi(){
    setRxRequestStatusTopRatedMovies(Status.LOADING);
    _api.topRatedMoviesListApi().then((value){
      setRxRequestStatusTopRatedMovies(Status.COMPLETED);
      setTopRatedMoviesList(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      setRxRequestStatusTopRatedMovies(Status.ERROR);
      print(error.toString());
    });
  }

  void refreshPopularTvSeriesListApi(){
    setRxRequestStatusPopularTvSeries(Status.LOADING);
    _api.popularTvSeriesListApi().then((value){
      setRxRequestStatusPopularTvSeries(Status.COMPLETED);
      setPopularTvSeriesList(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      setRxRequestStatusPopularTvSeries(Status.ERROR);
      print(error.toString());
    });
  }
}