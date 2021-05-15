import 'package:cubitlogin/login/model/login_request_model.dart';
import 'package:cubitlogin/login/model/login_response.dart';
import 'package:cubitlogin/login/service/I_Login_Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  final ILoginService service;
  bool isLoginFail = false;
  bool isLoading = false;
  LoginCubit(
      this.formKey, this.emailController, this.passwordController, this.service)
      : super(LoginInitial());
  Future<void> postUserModel() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoadingView(isLoading);
      final data = await service.postUserLogin(LoginRequestModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim()));
      changeLoadingView(isLoading);
      if (data is LoginResponseModel) {
        emit(LogimComplete(data));
      }
    } else {
      isLoginFail = true;
      emit(LoginValidateState(isLoginFail));
    }
  }

  void changeLoadingView(bool state) {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LogimComplete extends LoginState {
  final LoginResponseModel model;

  LogimComplete(this.model);
}

class LoginValidateState extends LoginState {
  final bool isValidate;

  LoginValidateState(this.isValidate);
}

class LoginLoadingState extends LoginState {
  final bool isLoading;

  LoginLoadingState(this.isLoading);
}
