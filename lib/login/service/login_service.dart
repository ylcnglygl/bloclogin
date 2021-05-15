import 'dart:io';

import 'package:cubitlogin/login/model/login_response.dart';
import 'package:cubitlogin/login/model/login_request_model.dart';
import 'package:cubitlogin/login/service/I_Login_Service.dart';
import 'package:dio/src/dio.dart';

class LoginService extends ILoginService {
  LoginService(Dio dio) : super(dio);

  @override
  Future<LoginResponseModel?> postUserLogin(LoginRequestModel model) async {
    final response = await dio.post(loginPath, data: model);
    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
