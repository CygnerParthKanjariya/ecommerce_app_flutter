enum Flavor {
  dev(apiHost: ""),
  production(apiHost: ""),
  local(apiHost: "");

  final String apiHost;

  const Flavor({required this.apiHost});
}
