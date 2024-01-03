import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie/res/app_url/app_url.dart';
import 'package:movie/res/colors/app_color.dart';
import 'package:movie/utils/utils.dart';
import 'package:movie/view/details/details_screen.dart';

import '../../data/response/status.dart';
import '../../res/components/general_exception.dart';
import '../../res/components/internet_exceptions_widget.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/home/home_view_models.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key,}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final homeController = Get.put(HomeController());

  UserPreference userPreference = UserPreference();

  final dateFormat = DateFormat('MMMM dd, yyyy');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.moviesListApi();
      homeController.tvListApi();
      homeController.topRatedListApi();
      homeController.upcomingMoviesListApi();
      homeController.topRatedMoviesListApi();
      homeController.popularTvSeriesListApi();
    });

  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return  WillPopScope(
      onWillPop: ()async {
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Movies', style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              userPreference.removeUser().then((value){
                Get.toNamed(RouteName.loginView);
              });
            }, icon: const Icon(Icons.logout,color: Colors.black,))
          ],
        ),
        body: Container(
          height: height,
          width: width,
          child: Obx((){
            switch(homeController.rxRequestStatus.value){
              case Status.LOADING:
                return Center(child: spinKit);
              case Status.ERROR:
                if(homeController.error.value =='No internet'){
                  return InterNetExceptionWidget(onPress: () {
                    homeController.refreshApi();
                  },);
                }else {
                  return GeneralExceptionWidget(onPress: (){
                    homeController.refreshApi();
                  });
                }
              case Status.COMPLETED:
                return ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .02,vertical: height*.02),
                      child: Text('Trending Movies',style: TextStyle(color: AppColor.secondaryTextColor, fontSize: AppColor.heading1,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      height: height*.5,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeController.moviesList.value.results!.length,
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: (){
                                DateTime date = DateTime.parse(homeController.moviesList.value.results![index].releaseDate!);
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return MoviesDetailsScreen(
                                    movieTitle: homeController.moviesList.value.results![index].title.toString(),
                                    movieImage: AppUrl.imageUrl+homeController.moviesList.value.results![index].backdropPath.toString(),
                                    movieDescription: homeController.moviesList.value.results![index].overview.toString(),
                                    movieDate: dateFormat.format(date));
                                },)
                                );
                              },
                              child: SizedBox(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: height * 0.5,
                                      width: width * 0.9,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: height * .02,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: AppUrl.imageUrl+homeController.moviesList.value.results![index].posterPath.toString(),
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) => spinKit,
                                          errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red),
                                        ),
                                      ),
                                    ),
                                    // Positioned(
                                    //   bottom: 20,
                                    //   child: Card(
                                    //     elevation: 5,
                                    //     shape: RoundedRectangleBorder(
                                    //       borderRadius: BorderRadius.circular(11),
                                    //     ),
                                    //     child: Container(
                                    //       alignment: Alignment.bottomCenter,
                                    //       height: height * .22,
                                    //       padding: EdgeInsets.all(width*.03),
                                    //       child: Column(
                                    //         mainAxisAlignment: MainAxisAlignment.center,
                                    //         crossAxisAlignment: CrossAxisAlignment.center,
                                    //         children: [
                                    //           // Container(
                                    //           // width: width * 0.7,
                                    //           // child: Text(
                                    //           // snapshot.data!.articles![index].title.toString(),
                                    //           // maxLines: 2,
                                    //           // overflow: TextOverflow.ellipsis,
                                    //           // style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.w700, color: Colors.black),
                                    //           // ),
                                    //           // ),
                                    //           // Spacer(),
                                    //           // Container(
                                    //           // width: width * 0.7,
                                    //           // child: Row(
                                    //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //           // children: [
                                    //           // Text(
                                    //           // snapshot.data!.articles![index].source!.name.toString(),
                                    //           // maxLines: 2,
                                    //           // overflow: TextOverflow.ellipsis,
                                    //           // style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600, color: Colors.black),
                                    //           // ),
                                    //           // Text(
                                    //           // dateFormat.format(date),
                                    //           // maxLines: 2,
                                    //           // overflow: TextOverflow.ellipsis,
                                    //           // style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w500, color: Colors.black),
                                    //           // ),
                                    //           // ],
                                    //           // ),
                                    //           // )
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .02,vertical: height*.02),
                      child: Text('Trending Tv',style: TextStyle(color: AppColor.secondaryTextColor, fontSize: AppColor.heading1,fontWeight: FontWeight.bold),),
                    ),
                    Obx(() {
                      switch(homeController.rxRequestStatusTv.value){
                        case Status.LOADING:
                          return const Center(child: spinKit,);
                        case Status.ERROR:
                          if(homeController.error.value =='No internet'){
                            return InterNetExceptionWidget(onPress: () {
                              homeController.refreshTvListApi();
                            },);
                          }else {
                            return GeneralExceptionWidget(onPress: (){
                              homeController.refreshTvListApi();
                            });
                          }
                        case Status.COMPLETED:
                          return Container(
                            height: height * .25,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeController.tvList.value.results!.length,
                                itemBuilder: (context, index){
                                  // DateTime date = DateTime.parse(homeController.moviesList.value.results![index].releaseDate.toString());
                                  return InkWell(
                                    onTap: (){
                                      DateTime date = DateTime.parse(homeController.tvList.value.results![index].firstAirDate!);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return MoviesDetailsScreen(
                                            movieTitle: homeController.tvList.value.results![index].name.toString(),
                                            movieImage: AppUrl.imageUrl+homeController.tvList.value.results![index].backdropPath.toString(),
                                            movieDescription: homeController.tvList.value.results![index].overview.toString(),
                                            movieDate: dateFormat.format(date));
                                      },)
                                      );
                                    },
                                    child: SizedBox(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: height * 0.25,
                                            width: width * 0.4,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: height * .01,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: AppUrl.imageUrl+homeController.tvList.value.results![index].posterPath.toString(),
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) => spinKit,
                                                errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          );
                      }
                    }),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .02,vertical: height*.02),
                      child: Text('Top Rated Tv Series',style: TextStyle(color: AppColor.secondaryTextColor, fontSize: AppColor.heading1,fontWeight: FontWeight.bold),),
                    ),
                    Obx(() {
                      switch(homeController.rxRequestStatusTop.value){
                        case Status.LOADING:
                          return Center(child: spinKit,);
                        case Status.ERROR:
                          if(homeController.error.value =='No internet'){
                            return InterNetExceptionWidget(onPress: () {
                              homeController.refreshTopRatedListApi();
                            },);
                          }else {
                            return GeneralExceptionWidget(onPress: (){
                              homeController.refreshTopRatedListApi();
                            });
                          }
                        case Status.COMPLETED:
                          return Container(
                            height: height * .25,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeController.topRatedList.value.results!.length,
                                itemBuilder: (context, index){
                                  // DateTime date = DateTime.parse(homeController.moviesList.value.results![index].releaseDate.toString());
                                  return InkWell(
                                    onTap: (){
                                      DateTime date = DateTime.parse(homeController.topRatedList.value.results![index].firstAirDate!);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return MoviesDetailsScreen(
                                            movieTitle: homeController.topRatedList.value.results![index].name.toString(),
                                            movieImage: AppUrl.imageUrl+homeController.topRatedList.value.results![index].backdropPath.toString(),
                                            movieDescription: homeController.topRatedList.value.results![index].overview.toString(),
                                            movieDate: dateFormat.format(date));
                                      },)
                                      );
                                    },
                                    child: SizedBox(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: height * 0.25,
                                            width: width * 0.4,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: height * .01,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: AppUrl.imageUrl+homeController.topRatedList.value.results![index].posterPath.toString(),
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) => spinKit,
                                                errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          );
                      }
                    }),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .02,vertical: height*.02),
                      child: Text('UpComing Movies',style: TextStyle(color: AppColor.secondaryTextColor, fontSize: AppColor.heading1,fontWeight: FontWeight.bold),),
                    ),
                    Obx(() {
                      switch(homeController.rxRequestStatusUpcomingMovies.value){
                        case Status.LOADING:
                          return Center(child: spinKit,);
                        case Status.ERROR:
                          if(homeController.error.value =='No internet'){
                            return InterNetExceptionWidget(onPress: () {
                              homeController.refreshUpcomingMoviesListApi();
                            },);
                          }else {
                            return GeneralExceptionWidget(onPress: (){
                              homeController.refreshUpcomingMoviesListApi();
                            });
                          }
                        case Status.COMPLETED:
                          return Container(
                            height: height * .25,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeController.upcomingMoviesList.value.results!.length,
                                itemBuilder: (context, index){
                                  // DateTime date = DateTime.parse(homeController.moviesList.value.results![index].releaseDate.toString());
                                  return InkWell(
                                    onTap: (){
                                      DateTime date = DateTime.parse(homeController.upcomingMoviesList.value.results![index].releaseDate!);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return MoviesDetailsScreen(
                                            movieTitle: homeController.upcomingMoviesList.value.results![index].title.toString(),
                                            movieImage: AppUrl.imageUrl+homeController.upcomingMoviesList.value.results![index].backdropPath.toString(),
                                            movieDescription: homeController.upcomingMoviesList.value.results![index].overview.toString(),
                                            movieDate: dateFormat.format(date));
                                      },)
                                      );
                                    },
                                    child: SizedBox(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: height * 0.25,
                                            width: width * 0.4,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: height * .01,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: AppUrl.imageUrl+homeController.upcomingMoviesList.value.results![index].posterPath.toString(),
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) => spinKit,
                                                errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          );
                      }
                    }),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .02,vertical: height*.02),
                      child: Text('Top Rated Movies',style: TextStyle(color: AppColor.secondaryTextColor, fontSize: AppColor.heading1,fontWeight: FontWeight.bold),),
                    ),
                    Obx(() {
                      switch(homeController.rxRequestStatusTopRatedMovies.value){
                        case Status.LOADING:
                          return Center(child: spinKit,);
                        case Status.ERROR:
                          if(homeController.error.value =='No internet'){
                            return InterNetExceptionWidget(onPress: () {
                              homeController.refreshTopRatedMoviesListApi();
                            },);
                          }else {
                            return GeneralExceptionWidget(onPress: (){
                              homeController.refreshTopRatedMoviesListApi();
                            });
                          }
                        case Status.COMPLETED:
                          return Container(
                            height: height * .25,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeController.topRatedMoviesList.value.results!.length,
                                itemBuilder: (context, index){
                                  // DateTime date = DateTime.parse(homeController.moviesList.value.results![index].releaseDate.toString());
                                  return InkWell(
                                    onTap: (){
                                      DateTime date = DateTime.parse(homeController.topRatedMoviesList.value.results![index].releaseDate!);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return MoviesDetailsScreen(
                                            movieTitle: homeController.topRatedMoviesList.value.results![index].title.toString(),
                                            movieImage: AppUrl.imageUrl+homeController.topRatedMoviesList.value.results![index].backdropPath.toString(),
                                            movieDescription: homeController.topRatedMoviesList.value.results![index].overview.toString(),
                                            movieDate: dateFormat.format(date));
                                      },)
                                      );
                                    },
                                    child: SizedBox(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: height * 0.25,
                                            width: width * 0.4,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: height * .01,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: AppUrl.imageUrl+homeController.topRatedMoviesList.value.results![index].posterPath.toString(),
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) => spinKit,
                                                errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          );
                      }
                    }),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .02,vertical: height*.02),
                      child: Text('Popular Tv Series',style: TextStyle(color: AppColor.secondaryTextColor, fontSize: AppColor.heading1,fontWeight: FontWeight.bold),),
                    ),
                    Obx(() {
                      switch(homeController.rxRequestStatusPopularTvSeries.value){
                        case Status.LOADING:
                          return Center(child: spinKit,);
                        case Status.ERROR:
                          if(homeController.error.value =='No internet'){
                            return InterNetExceptionWidget(onPress: () {
                              homeController.refreshPopularTvSeriesListApi();
                            },);
                          }else {
                            return GeneralExceptionWidget(onPress: (){
                              homeController.refreshPopularTvSeriesListApi();
                            });
                          }
                        case Status.COMPLETED:
                          return Container(
                            height: height * .25,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeController.popularTvSeriesList.value.results!.length,
                                itemBuilder: (context, index){
                                  // DateTime date = DateTime.parse(homeController.moviesList.value.results![index].releaseDate.toString());
                                  return InkWell(
                                    onTap: (){
                                      DateTime date = DateTime.parse(homeController.popularTvSeriesList.value.results![index].firstAirDate!);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return MoviesDetailsScreen(
                                            movieTitle: homeController.popularTvSeriesList.value.results![index].title.toString(),
                                            movieImage: AppUrl.imageUrl+homeController.popularTvSeriesList.value.results![index].backdropPath.toString(),
                                            movieDescription: homeController.popularTvSeriesList.value.results![index].overview.toString(),
                                            movieDate: dateFormat.format(date));
                                      },)
                                      );
                                    },
                                    child: SizedBox(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: height * 0.25,
                                            width: width * 0.4,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: height * .01,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: AppUrl.imageUrl+homeController.popularTvSeriesList.value.results![index].posterPath.toString(),
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) => spinKit,
                                                errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          );
                      }
                    }),
                  ],
                );
            }
          }),
        )


        // ListView(
        //   children: [
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: width * .02,vertical: height*.02),
            //   child: Text('Trending Movies',style: TextStyle(color: AppColor.secondaryTextColor, fontSize: AppColor.heading1,fontWeight: FontWeight.bold),),
            // ),
            // Obx((){
            //   switch(homeController.rxRequestStatus.value){
            //     case Status.LOADING:
            //       return Center(child: Utils.spinkit());
            //     case Status.ERROR:
            //       if(homeController.error.value =='No internet'){
            //         return InterNetExceptionWidget(onPress: () {
            //           homeController.refreshApi();
            //         },);
            //       }else {
            //         return GeneralExceptionWidget(onPress: (){
            //           homeController.refreshApi();
            //         });
            //       }
            //     case Status.COMPLETED:
            //       return Container(
            //         height: height*.5,
            //         child: ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             itemCount: homeController.moviesList.value.results!.length,
            //             itemBuilder: (context, index){
            //               // DateTime date = DateTime.parse(homeController.moviesList.value.results![index].releaseDate.toString());
            //               return InkWell(
            //                 onTap: (){
            //                   // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //                   // return NewsDetailsScreen(
            //                   // newsTitle: snapshot.data!.articles![index].title.toString(),
            //                   // newsImage: snapshot.data!.articles![index].urlToImage.toString(),
            //                   // nwsContent: snapshot.data!.articles![index].content.toString(),
            //                   // newsSource: snapshot.data!.articles![index].source!.name.toString(),
            //                   // newsDescription: snapshot.data!.articles![index].description.toString(),
            //                   // newsAuthor: snapshot.data!.articles![index].author.toString(),
            //                   // newsDate: dateFormat.format(date));
            //                   // },)
            //                   // );
            //                 },
            //                 child: SizedBox(
            //                   child: Stack(
            //                     alignment: Alignment.center,
            //                     children: [
            //                       Container(
            //                         height: height * 0.5,
            //                         width: width * 0.9,
            //                         padding: EdgeInsets.symmetric(
            //                           horizontal: height * .02,
            //                         ),
            //                         child: ClipRRect(
            //                           borderRadius: BorderRadius.circular(15),
            //                           child: CachedNetworkImage(
            //                             imageUrl: AppUrl.imageUrl+homeController.moviesList.value.results![index].posterPath.toString(),
            //                             fit: BoxFit.fill,
            //                             // placeholder: (context, url) => spinKit,
            //                             errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red),
            //                           ),
            //                         ),
            //                       ),
            //                       // Positioned(
            //                       //   bottom: 20,
            //                       //   child: Card(
            //                       //     elevation: 5,
            //                       //     shape: RoundedRectangleBorder(
            //                       //       borderRadius: BorderRadius.circular(11),
            //                       //     ),
            //                       //     child: Container(
            //                       //       alignment: Alignment.bottomCenter,
            //                       //       height: height * .22,
            //                       //       padding: EdgeInsets.all(width*.03),
            //                       //       child: Column(
            //                       //         mainAxisAlignment: MainAxisAlignment.center,
            //                       //         crossAxisAlignment: CrossAxisAlignment.center,
            //                       //         children: [
            //                       //           // Container(
            //                       //           // width: width * 0.7,
            //                       //           // child: Text(
            //                       //           // snapshot.data!.articles![index].title.toString(),
            //                       //           // maxLines: 2,
            //                       //           // overflow: TextOverflow.ellipsis,
            //                       //           // style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.w700, color: Colors.black),
            //                       //           // ),
            //                       //           // ),
            //                       //           // Spacer(),
            //                       //           // Container(
            //                       //           // width: width * 0.7,
            //                       //           // child: Row(
            //                       //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                       //           // children: [
            //                       //           // Text(
            //                       //           // snapshot.data!.articles![index].source!.name.toString(),
            //                       //           // maxLines: 2,
            //                       //           // overflow: TextOverflow.ellipsis,
            //                       //           // style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600, color: Colors.black),
            //                       //           // ),
            //                       //           // Text(
            //                       //           // dateFormat.format(date),
            //                       //           // maxLines: 2,
            //                       //           // overflow: TextOverflow.ellipsis,
            //                       //           // style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w500, color: Colors.black),
            //                       //           // ),
            //                       //           // ],
            //                       //           // ),
            //                       //           // )
            //                       //         ],
            //                       //       ),
            //                       //     ),
            //                       //   ),
            //                       // )
            //                     ],
            //                   ),
            //                 ),
            //               );
            //             }
            //         ),
            //       );
            //   }
            // }),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: width * .02,vertical: height*.02),
            //   child: Text('Trending Tv',style: TextStyle(color: AppColor.secondaryTextColor, fontSize: AppColor.heading1,fontWeight: FontWeight.bold),),
            // ),
            // Obx((){
            //   switch(homeController.rxRequestStatusTv.value){
            //     case Status.LOADING:
            //       return Center(child: Utils.spinkit());
            //     case Status.ERROR:
            //       if(homeController.error.value =='No internet'){
            //         return InterNetExceptionWidget(onPress: () {
            //           homeController.refreshApi();
            //         },);
            //       }else {
            //         return GeneralExceptionWidget(onPress: (){
            //           homeController.refreshApi();
            //         });
            //       }
            //     case Status.COMPLETED:
            //       return Container(
            //         height: height*0.25,
            //         child: ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             itemCount: homeController.tvList.value.results!.length,
            //             itemBuilder: (context, index){
            //               // DateTime date = DateTime.parse(homeController.moviesList.value.results![index].releaseDate.toString());
            //               return InkWell(
            //                 onTap: (){
            //                   // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //                   // return NewsDetailsScreen(
            //                   // newsTitle: snapshot.data!.articles![index].title.toString(),
            //                   // newsImage: snapshot.data!.articles![index].urlToImage.toString(),
            //                   // nwsContent: snapshot.data!.articles![index].content.toString(),
            //                   // newsSource: snapshot.data!.articles![index].source!.name.toString(),
            //                   // newsDescription: snapshot.data!.articles![index].description.toString(),
            //                   // newsAuthor: snapshot.data!.articles![index].author.toString(),
            //                   // newsDate: dateFormat.format(date));
            //                   // },)
            //                   // );
            //                 },
            //                 child: SizedBox(
            //                   child: Stack(
            //                     alignment: Alignment.center,
            //                     children: [
            //                       Container(
            //                         height: height * 0.25,
            //                         width: width * 0.4,
            //                         padding: EdgeInsets.symmetric(
            //                           horizontal: height * .01,
            //                         ),
            //                         child: ClipRRect(
            //                           borderRadius: BorderRadius.circular(15),
            //                           child: CachedNetworkImage(
            //                             imageUrl: AppUrl.imageUrl+homeController.tvList.value.results![index].posterPath.toString(),
            //                             fit: BoxFit.fill,
            //                             placeholder: (context, url) => Utils.spinkit(),
            //                             errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red),
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               );
            //             }
            //         ),
            //       );
            //   }
            // }),
        //   ],
        // )
      ),
    );
  }
}
const spinKit = SpinKitWave(
  color: Colors.black,
  size: 25,
);