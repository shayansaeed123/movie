import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MoviesDetailsScreen extends StatefulWidget {
  const MoviesDetailsScreen({super.key,
    required this.movieTitle,
    required this.movieImage,
    required this.movieDescription,
    required this.movieDate});


  final String movieTitle, movieImage,movieDescription,movieDate;

  @override
  State<MoviesDetailsScreen> createState() => _MoviesDetailsScreenState();
}

class _MoviesDetailsScreenState extends State<MoviesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Details",style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: height * .45,
              width: width,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.movieImage,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            Container(
              height: height * .6,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  )
              ),
              margin: EdgeInsets.only(top: height * .4),
              padding: EdgeInsets.all(height * 0.05),
              child: ListView(
                children: [
                  Text('Movie Name :  ${widget.movieTitle}',
                      style: GoogleFonts.poppins()
                          .copyWith(
                          // color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500)
                  ),
                  SizedBox(height: height * 0.03,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Release Date:',
                            style: GoogleFonts.poppins()
                                .copyWith(
                                // color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                      Text(widget.movieDate,
                          style: GoogleFonts.poppins()
                              .copyWith(
                              // color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w300)
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.03,),
                  Text('Overview : ',
                      style: GoogleFonts.poppins()
                          .copyWith(
                          // color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500)
                  ),
                  Text('${widget.movieDescription}',
                      style: GoogleFonts.poppins()
                          .copyWith(
                        // color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)
                  ),
                  SizedBox(height: height * 0.03,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
