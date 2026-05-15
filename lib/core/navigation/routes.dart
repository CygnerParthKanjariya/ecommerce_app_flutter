enum Routes {
  register("/register"),
  login("/login"),
  splash("/");

  final String path;

  const Routes(this.path);
}
