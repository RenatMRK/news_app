import 'package:go_router/go_router.dart';
import 'package:news_app/common/constants/app_routes.dart';
import 'package:news_app/app/widgets/bottom_nav.dart';
import 'package:news_app/features/news/presentation/pages/news_page.dart';
import 'package:news_app/features/favorites/presentation/screens/favorites_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.news,
  routes: [
    ShellRoute(
      builder: (context, state, child) => ScaffoldWithBottomNav(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.news,
          name: AppRoutes.newsName,
          builder: (context, state) => const NewsScreen(),
        ),
        GoRoute(
          path: AppRoutes.favorites,
          name: AppRoutes.favoritesName,
          builder: (context, state) => const FavoritesScreen(),
        ),
      ],
    ),
  ],
);
