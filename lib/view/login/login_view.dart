import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movie/view/login/widgets/input_email_widget.dart';
import 'package:movie/view/login/widgets/input_password_widget.dart';
import 'package:movie/view/login/widgets/login_button_widget.dart';

import '../../res/colors/app_color.dart';
import '../../res/components/round_button.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/login/login_view_model.dart';



class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final loginVM = Get.put(LoginViewModel()) ;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;

    return WillPopScope(
      onWillPop: () async{
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login',style: TextStyle(color: AppColor.blackColor)),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height* 0.1),
                  child: Container(
                    width: width * .8,
                    height: height * .25,
                    child: Image.asset('assets/images/user.png',alignment: Alignment.center,fit: BoxFit.fill),
                  ),
                ),
                SizedBox(height: height*0.05,),
                Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width*0.05),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter Username',
                              border: OutlineInputBorder(borderSide: BorderSide(color: AppColor.enableTextFieldBorderColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: AppColor.enableTextFieldBorderColor,)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: AppColor.focusTextFieldBorderColor,)
                              ),
                            ),
                            keyboardType: TextInputType.name,
                            controller: loginVM.emailController.value,
                            focusNode: loginVM.emailFocusNode.value,
                            validator: (value) {
                              if(value!.isEmpty){
                                Utils.snackBar('Username', 'Enter Username');
                              }
                            },
                            onFieldSubmitted: (value) {
                              Utils.fieldFocusChange(context, loginVM.emailFocusNode.value, loginVM.passwordFocusNode.value);
                            },
                          ),
                        ),
                        SizedBox(height: height*0.03,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width*0.05),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter Password',
                              border: OutlineInputBorder(borderSide: BorderSide(color: AppColor.enableTextFieldBorderColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: AppColor.enableTextFieldBorderColor,)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: AppColor.focusTextFieldBorderColor,)
                              ),
                            ),
                            keyboardType: TextInputType.name,
                            obscureText: true,
                            controller: loginVM.passwordController.value,
                            focusNode: loginVM.passwordFocusNode.value,
                            validator: (value) {
                              if(value!.isEmpty){
                                Utils.snackBar('Password', 'Enter Password');
                              }
                            },
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: height*0.04,),
                Obx(() => RoundButton(
                    height: height*0.06,
                    width: width*.4,
                    buttonColor: AppColor.redColor,
                    loading: loginVM.loading.value,
                    title: 'Login', onPress: (){
                  if(_formkey.currentState!.validate()){
                    loginVM.loginApi();
                  }else{
                    Utils.snackBar('Error', 'Please Enter all fields');
                  }
                }),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

