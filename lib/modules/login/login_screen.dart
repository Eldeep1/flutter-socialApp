import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/home_layout.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController=TextEditingController();
    TextEditingController passwordController=TextEditingController();
    var formKey=GlobalKey<FormState>();
    String? errorMessage;
    final FocusNode secondFieldFocus = FocusNode();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener: (context, state) {
          if(state is LoginErrorState){
            showToast(msg: state.error, color: Colors.red);
          }
          if(state is LoginSuccessState){
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndNeverComeBack(context, HomeLayout());
            });

          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(

          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black,

                        ),

                      ),
                      Text(
                        'Login now to communicate with friends',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(context: context,
                          controller: emailController,
                          prefixIcon: Icons.email_outlined,
                          labelText: 'Email Address',
                          validation: true,
                          keyBoardType: TextInputType.emailAddress,
                          alertText: 'please enter your email address',
                          onFieldSubmitted: (text){
                            FocusScope.of(context).requestFocus(secondFieldFocus);
                          }
                      ),
                      SizedBox(
                        height: 15.0,
                      ),

                      defaultFormField(
                          brightWhenSubmit: secondFieldFocus,
                          context: context,
                          controller: passwordController,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: LoginCubit.get(context).suffix,
                          suffixClick: LoginCubit.get(context).changePasswordVisibility,
                          obscureText: LoginCubit.get(context).hidePassword,
                          labelText: 'Password',
                          validation: true,
                          keyBoardType: TextInputType.visiblePassword,
                          alertText: 'please enter your password',
                          onFieldSubmitted: (ss){
                            if(formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,password: passwordController.text
                              );
                            }
                            secondFieldFocus.unfocus();
                          }


                      ),
                      SizedBox(
                        height: 30.0,
                      ),

                      if(state is LoginErrorState)
                        Text('please check your internet connection'),
                      // else if(state is LoginSuccessState&&state.loginModel!.status==false)
                      //   Text(state.loginModel!.message!),

                      if(state is LoginLoadingState)
                        Center(
                            child: CircularProgressIndicator()
                        )
                      else
                        defaultButton(
                            text: 'Login',
                            buttonColor: defaultColor,
                            function:(){
                              if(formKey.currentState!.validate())
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,password: passwordController.text
                                );
                            } ),



                      textbutton(text: 'don\'t have an account ? ', coloredText: 'register now', function: (){navigateTo(context, RegisterScreen());},mainAlignment: MainAxisAlignment.center),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
