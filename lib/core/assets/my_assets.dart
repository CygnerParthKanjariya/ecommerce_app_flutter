abstract class MyAssets {
  String get path;
}

enum MyImages implements MyAssets {
  blank("");
  @override
  final String path;

  const MyImages(this.path);
}

enum MySVGs implements MyAssets {
  blank("");
  @override
  final String path;

  const MySVGs(this.path);
}