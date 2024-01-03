

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors/app_color.dart';


class InterNetExceptionWidget extends StatefulWidget {
  final VoidCallback onPress ;
  const InterNetExceptionWidget({Key? key , required this.onPress}) : super(key: key);

  @override
  State<InterNetExceptionWidget> createState() => _InterNetExceptionWidgetState();
}

class _InterNetExceptionWidgetState extends State<InterNetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height ;
    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: height * .2 ,),
          Icon(Icons.cloud_off , color: AppColor.redColor,size: 80,),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(child: Text('Please, \n Check Your Internet Connection '.tr , textAlign: TextAlign.center,style: TextStyle(fontSize: 20),)),
          ),
          SizedBox(height: height * .1 ,),
          InkWell(
            onTap: widget.onPress,
            child: Container(
              height: 44,
              width: 160,
              decoration: BoxDecoration(
                color: AppColor.primaryColor ,
                borderRadius: BorderRadius.circular(50)
              ),
              child: Center(child: Text('Retry' , style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),)),
            ),
          )
        ],
      ),
    );
  }
}
