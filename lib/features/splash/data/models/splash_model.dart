import '../../domain/entities/splash.dart';

class SplashModel extends Splash {
    const SplashModel() : super();

    factory SplashModel.fromJson(Map<String, dynamic> json) {
      return SplashModel();
    }

    Map<String, dynamic> toJson() {
      return {};
    }
}