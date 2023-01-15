import 'package:flutter/material.dart';
import 'package:shopping_app/app/di.dart';
import 'package:shopping_app/presentation/forgot_password/forgot_password_view/forgot_password_view.dart';
import 'package:shopping_app/presentation/login/login_view/login_view.dart';
import 'package:shopping_app/presentation/main/main_view.dart';
import 'package:shopping_app/presentation/onboarding/view/onboarding_view.dart';
import 'package:shopping_app/presentation/register/register_view.dart';
import 'package:shopping_app/presentation/resources/strings_manager.dart';
import 'package:shopping_app/presentation/splash/splash_view.dart';
import 'package:shopping_app/presentation/store_details/store_details_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String onBoardingRoute = "/onBoarding";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
      initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
      initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                // ignore: todo
                title: const Text(AppStrings.noRouteFound), 
              ),
              // ignore: todo
              body: const Center(child: Text(AppStrings.noRouteFound)), 
            ));
  }
}
