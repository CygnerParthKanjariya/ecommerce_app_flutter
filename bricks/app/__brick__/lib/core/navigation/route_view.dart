import 'routes.dart';
import 'package:flutter/material.dart';


extension RouteView on Routes {
  MaterialPageRoute route(RouteSettings settings) {
    Widget page;
    switch (this) {

    }
    return MaterialPageRoute(builder: (context) => page, settings: settings);
  }
}
