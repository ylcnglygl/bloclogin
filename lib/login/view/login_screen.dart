import 'package:cubitlogin/constants.dart';
import 'package:cubitlogin/login/service/login_service.dart';
import 'package:cubitlogin/login/view/login_detail_view.dart';
import 'package:cubitlogin/login/viewmodel/login_cubit.dart';
import 'package:cubitlogin/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final baseUrl = 'https://reqres.in/api';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(formKey, emailController,
          passwordController, LoginService(Dio(BaseOptions(baseUrl: baseUrl)))),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LogimComplete) {
            state.navigate(context);
          }
        },
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  SafeArea buildScaffold(BuildContext context, LoginState state) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: Padding(
              padding:
                  const EdgeInsets.only(left: 48.0, right: 36.0, top: 64.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Form(
                    key: formKey,
                    autovalidateMode: autovalidateState(state),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          validator: (value) =>
                              (value ?? '').length > 6 ? null : 'Less than 5',
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              labelText: 'Email',
                              prefixIcon:
                                  Image.asset('assets/icons/Message.png')),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              labelText: 'Password',
                              prefixIcon:
                                  Image.asset('assets/icons/Password.png')),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        BlocConsumer<LoginCubit, LoginState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            // if (state is LogimComplete) {
                            //   return const Card(
                            //     child: Icon(Icons.check),
                            //   );
                            // }

                            return GestureDetector(
                              onTap: () {
                                context.read<LoginCubit>().postUserModel();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Colors.blue,
                                ),
                                child: const Center(child: Text("Sign in")),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}

extension LoginCompleteExtension on LogimComplete {
  void navigate(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginDetailView(
              model: model,
            )));
  }
}

AutovalidateMode autovalidateState(LoginState state) {
  return state is LoginValidateState
      ? (state.isValidate ? AutovalidateMode.always : AutovalidateMode.disabled)
      : AutovalidateMode.disabled;
}

   // child: GestureDetector(
                        //   onTap: () {
                        //     context.read<LoginCubit>().postUserModel();
                        //   },
                        //   child: Container(
                        //     width: MediaQuery.of(context).size.width,
                        //     height: MediaQuery.of(context).size.height * 0.06,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(16.0),
                        //       color: Colors.blue,
                        //     ),
                        //     child: const Center(child: Text("Sign in")),
                        //   ),
                        // ),