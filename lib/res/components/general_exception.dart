

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors/app_color.dart';


class GeneralExceptionWidget extends StatefulWidget {
  final VoidCallback onPress ;
  const GeneralExceptionWidget({Key? key , required this.onPress}) : super(key: key);

  @override
  State<GeneralExceptionWidget> createState() => _GeneralExceptionWidgetState();
}

class _GeneralExceptionWidgetState extends State<GeneralExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height ;
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: height * .20 ,),
          Icon(Icons.cloud_off , color: AppColor.redColor,size: 50,),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(child: Text('something went wrong please, \n try Again'.tr , textAlign: TextAlign.center,style: TextStyle(fontSize: 20))),
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
