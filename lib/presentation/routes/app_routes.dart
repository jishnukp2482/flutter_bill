import 'package:flutter_bill/presentation/pages/bill_page.dart';
import 'package:flutter_bill/presentation/pages/homepage.dart';
import 'package:flutter_bill/presentation/pages/splash.dart';
import 'package:flutter_bill/presentation/routes/app_pages.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static GoRouter router =
      GoRouter(initialLocation: AppPages.splashScreen, routes: [
    GoRoute(
      path: AppPages.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppPages.homePage,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppPages.billingPage,
      builder: (context, state) => const BillingPage(),
    ),
  ]);
}
