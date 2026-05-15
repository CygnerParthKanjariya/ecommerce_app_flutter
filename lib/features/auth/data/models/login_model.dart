import '../../domain/entities/login.dart';

class LoginModel extends Login {
    const LoginModel() : super();

    factory LoginModel.fromJson(Map<String, dynamic> json) {
      return LoginModel();
    }

    Map<String, dynamic> toJson() {
      return {};
    }
}