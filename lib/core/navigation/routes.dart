enum Routes {
  dashboard("/dashboard"),
  register("/register"),
  login("/login"),
  splash("/");

  final String path;

  const Routes(this.path);
}
