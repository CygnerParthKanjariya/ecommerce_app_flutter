import 'package:flutter/material.dart';
import 'routes.dart';

extension GoTo on BuildContext {
  Future<T?> pushNamed<T extends Object?>(Routes routes,
      {Object? arguments}) {
    return Navigator.pushNamed(this, routes.path, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T extends Object?>(Routes routes,
      {Object? arguments}) {
    return Navigator.pushReplacementNamed(this, routes.path,
        arguments: arguments);
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(Routes routes,
      {Object? arguments}) {
    return Navigator.pushNamedAndRemoveUntil(this, routes.path, (route) {
      return false;
    }, arguments: arguments);
  }

  void pop<T extends Object?>({T? arguments}) {
    return Navigator.pop(this, arguments);
  }
}
