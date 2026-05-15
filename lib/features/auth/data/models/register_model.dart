import '../../domain/entities/register.dart';

class RegisterModel extends Register {
    const RegisterModel() : super();

    factory RegisterModel.fromJson(Map<String, dynamic> json) {
      return RegisterModel();
    }

    Map<String, dynamic> toJson() {
      return {};
    }
}