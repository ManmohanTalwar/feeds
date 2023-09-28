import 'package:feeds/presentation/screens/error/no_internet_screen.dart';
import 'package:feeds/presentation/screens/home/home_page.dart';
import 'package:feeds/presentation/screens/search/search_page.dart';
import 'package:feeds/routes/route_list.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> getAll() => _routes;

  static Route getRouteGenerate(RouteSettings settings) =>
      _routeGenerate(settings);

  static final Map<String, WidgetBuilder> _routes = {
    RouteList.home: (context) => const HomePage(),
    RouteList.search: (context) => const SearchPage(),
    RouteList.errorScreen: (context) => const NoInternetScreen(),
  };

  static Route _routeGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RouteList.home:
        return _buildRouteFade(settings, const HomePage());
      default:
        return _errorRoute();
    }
  }

  static WidgetBuilder getWidgetRouteByName(String name) {
    if (_routes.containsKey(name) == false) {
      return _routes[RouteList.home]!;
    }
    return _routes[name]!;
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('Page not found'),
          ),
        );
      },
    );
  }

  static PageRouteBuilder _buildRouteFade(
      RouteSettings settings, Widget builder) {
    return _FadedTransitionRoute(
      settings,
      widget: builder,
    );
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget? widget;
  final RouteSettings settings;

  _FadedTransitionRoute(
    this.settings, {
    this.widget,
  }) : super(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget!;
          },
          transitionDuration: const Duration(milliseconds: 50),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeIn,
              ),
              child: child,
            );
          },
        );
}
