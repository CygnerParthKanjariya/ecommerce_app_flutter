
import '../util/constants.dart';

enum Apis implements AppConstants {

  categories("categories");

  @override
  final String value;
  final String version;
  final String host;

  const Apis(
    this.value, {
    this.host = "https://dummyjson.com",
    this.version = "products",
  });
}

extension Api on Apis {
  String get url => "$host/$version/$value";

  String productsByCategory(String categoryName) {
    return "$host/$version/category/$categoryName";
  }
}
