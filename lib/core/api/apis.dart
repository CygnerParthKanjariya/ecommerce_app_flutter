
import '../util/constants.dart';

enum Apis implements AppConstants {

  test("test");

  @override
  final String value;
  final String version;
  final String host;

  const Apis(
    this.value, {
    this.host = "https://host.com",
    this.version = "api/v1",
  });
}

extension Api on Apis {
  String get url => "$host/$version/$value";
}
