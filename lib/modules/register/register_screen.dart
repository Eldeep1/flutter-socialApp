import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/home_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    final FocusNode secondFieldFocus = FocusNode();
    final FocusNode thirdFieldFocus = FocusNode();
    final FocusNode fourthFieldFocus = FocusNode();
    String? errorMessage;

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            navigateAndNeverComeBack(context, HomeLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style:
                          Theme
                              .of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style:
                          Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            context: context,
                            controller: nameController,
                            prefixIcon: Icons.person_outline,
                            labelText: 'Name',
                            validation: true,
                            onFieldSubmitted: (text) {
                              FocusScope.of(context)
                                  .requestFocus(secondFieldFocus);
                            }),
                        SizedBox(
                          height: 15.0,
                        ),

                        defaultFormField(
                            context: context,
                            controller: emailController,
                            prefixIcon: Icons.email_outlined,
                            labelText: 'Email Address',
                            validation: true,
                            keyBoardType: TextInputType.emailAddress,
                            alertText: 'please enter your email address',
                            brightWhenSubmit: secondFieldFocus,
                            onFieldSubmitted: (text) {
                              FocusScope.of(context)
                                  .requestFocus(thirdFieldFocus);
                            }),
                        SizedBox(
                          height: 15.0,
                        ),

                        defaultFormField(
                          brightWhenSubmit: thirdFieldFocus,
                          onFieldSubmitted: (text) {
                            FocusScope.of(context)
                                .requestFocus(fourthFieldFocus);
                          },
                          context: context,
                          controller: passwordController,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: RegisterCubit
                              .get(context)
                              .suffix,
                          suffixClick: RegisterCubit
                              .get(context)
                              .changePasswordVisibility,
                          obscureText: RegisterCubit
                              .get(context)
                              .hidePassword,
                          labelText: 'Password',
                          validation: true,
                          keyBoardType: TextInputType.visiblePassword,
                          alertText: 'please enter your password',
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          keyBoardType: TextInputType.phone,
                          brightWhenSubmit: fourthFieldFocus,
                          onFieldSubmitted: (text) {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                            fourthFieldFocus.unfocus();
                          },
                          context: context,
                          controller: phoneController,
                          prefixIcon: Icons.phone,
                          labelText: 'Phone',
                          validation: true,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        if (state is RegisterErrorState)
                          Text('please check your internet connection'),
                        // else if(state is RegisterSuccessState&&state.loginModel!.status==false)
                        //   Text(state.loginModel!.message!),

                        if (state is RegisterLoadingState)
                          Center(child: CircularProgressIndicator())
                        else
                          defaultButton(
                              text: 'Register',
                              buttonColor: defaultColor,
                              function: () {
                                if (formKey.currentState!.validate())
                                  RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );

                              }),

                        textbutton(
                            text: 'already have an account ? ',
                            coloredText: 'Login now',
                            function: () {
                              navigateTo(context, LoginScreen());
                            },
                            mainAlignment: MainAxisAlignment.center),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
