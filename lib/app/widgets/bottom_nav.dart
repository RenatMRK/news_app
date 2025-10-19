import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/common/constants/app_icons.dart';
import 'package:news_app/common/constants/app_routes.dart';
import 'package:news_app/common/extensions/media_query_values.dart';

enum BottomNavItem {
  news(AppIcons.news, AppRoutes.news, 0.85),
  favorites(AppIcons.favorites, AppRoutes.favorites, 1.0);

  final String icon;
  final String route;
  final double scale;
  const BottomNavItem(this.icon, this.route, this.scale);
}

class ScaffoldWithBottomNav extends StatefulWidget {
  final Widget child;
  const ScaffoldWithBottomNav({super.key, required this.child});

  @override
  State<ScaffoldWithBottomNav> createState() => _ScaffoldWithBottomNavState();
}

class _ScaffoldWithBottomNavState extends State<ScaffoldWithBottomNav> {
  int _locationToIndex(String location) {
    final index = BottomNavItem.values.indexWhere(
      (item) => location.startsWith(item.route),
    );
    return (index == -1) ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);
    final items = BottomNavItem.values;

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CustomBottomNavBar(
        items: items,
        currentIndex: currentIndex,
        onTap: (i) => context.go(items[i].route),
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final List<BottomNavItem> items;
  final int currentIndex;
  final void Function(int index) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Container(
        height: context.scaleH(84),
        margin: EdgeInsets.fromLTRB(
          context.scaleW(16),
          context.scaleH(8),
          context.scaleW(16),
          context.scaleH(10),
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(color: theme.colorScheme.outlineVariant,width: context.scaleW(0.5)),
        ),
        child: Row(
          children: List.generate(items.length, (i) {
            final item = items[i];
            final selected = i == currentIndex;

            return Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => onTap(i),
                child: Center(
                  child: SvgPicture.asset(
                    item.icon,
                    width: context.scaleW(36 * item.scale),
                    height: context.scaleH(36 * item.scale),
                    colorFilter: ColorFilter.mode(
                      selected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
