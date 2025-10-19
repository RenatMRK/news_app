import 'package:flutter/material.dart';
import 'package:news_app/common/constants/app_colors.dart';

/// 🌞 Светлая тема
ThemeData buildLightTheme() {
  final base = ColorScheme.fromSeed(
    seedColor: AppColors.primaryBlue,
    brightness: Brightness.light,
  );

  final scheme = base.copyWith(
    primary: AppColors.primaryBlue,
    onPrimary: AppColors.white,
    surface: AppColors.white,
    onSurface: AppColors.black,
    secondary: AppColors.grey,
    outline: AppColors.darkGrey,
    onSurfaceVariant: AppColors.darkGrey,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,

    textTheme: Typography.material2021(platform: TargetPlatform.android).black
        .copyWith(
          headlineLarge: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
          headlineMedium: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            height: 1.15,
          ),
          titleLarge: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: const TextStyle(fontSize: 16, height: 1.35),
          bodyMedium: const TextStyle(fontSize: 14, height: 1.35),
          labelLarge: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),

    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: scheme.onSurface,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),

    navigationBarTheme: NavigationBarThemeData(
      elevation: 8,
      indicatorColor: scheme.secondaryContainer,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      backgroundColor: scheme.surface,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.primary, width: 1.5),
      ),
      hintStyle: TextStyle(color: scheme.onSurface.withOpacity(0.6)),
    ),

    extensions: const <ThemeExtension<dynamic>>[AppSpacing(), AppRadius()],
  );
}

/// 🌙 Тёмная тема
ThemeData buildDarkTheme() {
  final base = ColorScheme.fromSeed(
    seedColor: AppColors.primaryBlue,
    brightness: Brightness.dark,
  );

  final scheme = base.copyWith(
    primary: AppColors.primaryBlue,
    onPrimary: AppColors.white,
    surface: AppColors.black,
    onSurface: AppColors.white,
    secondary: AppColors.grey,
    outline: AppColors.darkGrey,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,

    textTheme: Typography.material2021(platform: TargetPlatform.android).white
        .copyWith(
          headlineLarge: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
          headlineMedium: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            height: 1.15,
          ),
          titleLarge: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: const TextStyle(fontSize: 16, height: 1.35),
          bodyMedium: const TextStyle(fontSize: 14, height: 1.35),
          labelLarge: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),

    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      centerTitle: true,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),

    extensions: const <ThemeExtension<dynamic>>[AppSpacing(), AppRadius()],
  );
}

/// 🧱 Отступы
@immutable
class AppSpacing extends ThemeExtension<AppSpacing> {
  final double xs, s, m, l, xl;
  const AppSpacing({
    this.xs = 4,
    this.s = 8,
    this.m = 12,
    this.l = 16,
    this.xl = 24,
  });

  @override
  AppSpacing copyWith({
    double? xs,
    double? s,
    double? m,
    double? l,
    double? xl,
  }) => AppSpacing(
    xs: xs ?? this.xs,
    s: s ?? this.s,
    m: m ?? this.m,
    l: l ?? this.l,
    xl: xl ?? this.xl,
  );

  @override
  ThemeExtension<AppSpacing> lerp(
    ThemeExtension<AppSpacing>? other,
    double t,
  ) => this;
}

/// 🟦 Скругления
@immutable
class AppRadius extends ThemeExtension<AppRadius> {
  final BorderRadius small;
  final BorderRadius medium;
  final BorderRadius large;

  const AppRadius({
    this.small = const BorderRadius.all(Radius.circular(8)),
    this.medium = const BorderRadius.all(Radius.circular(12)),
    this.large = const BorderRadius.all(Radius.circular(16)),
  });

  @override
  AppRadius copyWith({
    BorderRadius? small,
    BorderRadius? medium,
    BorderRadius? large,
  }) => AppRadius(
    small: small ?? this.small,
    medium: medium ?? this.medium,
    large: large ?? this.large,
  );

  @override
  ThemeExtension<AppRadius> lerp(ThemeExtension<AppRadius>? other, double t) =>
      this;
}

// import 'package:flutter/material.dart';

// /// Базовый сид цвета для всего приложения (легко поменять в одном месте)
// const _seed = Colors.deepPurple;

// /// Светлая тема
// ThemeData buildLightTheme() {
//   final scheme = ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.light);

//   return ThemeData(
//     useMaterial3: true,
//     colorScheme: scheme,

//     // Типографика: акцент на заголовки новостей
//     textTheme: Typography.material2021(platform: TargetPlatform.android).black.copyWith(
//       headlineLarge: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, height: 1.1),
//       headlineMedium: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, height: 1.15),
//       titleLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//       bodyLarge: const TextStyle(fontSize: 16, height: 1.35),
//       bodyMedium: const TextStyle(fontSize: 14, height: 1.35),
//       labelLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//     ),

//     // AppBar — без теней, контентный цвет из схемы
//     appBarTheme: AppBarTheme(
//       backgroundColor: scheme.surface,
//       foregroundColor: scheme.onSurface,
//       elevation: 0,
//       centerTitle: true,
//       titleTextStyle: TextStyle(
//         color: scheme.onSurface,
//         fontSize: 18,
//         fontWeight: FontWeight.w700,
//       ),
//     ),

//     // Нижняя навигация (если используешь)
//     navigationBarTheme: NavigationBarThemeData(
//       elevation: 8,
//       indicatorColor: scheme.secondaryContainer,
//       labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
//       backgroundColor: scheme.surface,
//     ),

//     // Кнопки
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: scheme.primary,
//         foregroundColor: scheme.onPrimary,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//       ),
//     ),
//     // textButtonTheme: TextButtonThemeData(
//     //   style: TextButton.styleFrom(foregroundColor: scheme.primary),
//     // ),
//     // outlinedButtonTheme: OutlinedButtonThemeData(
//     //   style: OutlinedButton.styleFrom(
//     //     foregroundColor: scheme.primary,
//     //     side: BorderSide(color: scheme.outline),
//     //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//     //   ),
//     // ),

//     // Поля ввода — удобно для поисковой строки и форм
//     // inputDecorationTheme: InputDecorationTheme(
//     //   filled: true,
//     //   fillColor: scheme.surface.withOpacity(0.9),
//     //   isDense: true,
//     //   contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//     //   border: OutlineInputBorder(
//     //     borderRadius: BorderRadius.circular(12),
//     //     borderSide: BorderSide(color: scheme.outlineVariant),
//     //   ),
//     //   enabledBorder: OutlineInputBorder(
//     //     borderRadius: BorderRadius.circular(12),
//     //     borderSide: BorderSide(color: scheme.outlineVariant),
//     //   ),
//     //   focusedBorder: OutlineInputBorder(
//     //     borderRadius: BorderRadius.circular(12),
//     //     borderSide: BorderSide(color: scheme.primary, width: 1.5),
//     //   ),
//     //   hintStyle: TextStyle(color: scheme.onSurface.withOpacity(0.6)),
//     // ),

//     // Карточки статей
//     // cardTheme: CardTheme(
//     //   elevation: 0,
//     //   clipBehavior: Clip.antiAlias,
//     //   color: scheme.surface,
//     //   surfaceTintColor: scheme.surfaceTint,
//     //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//     //   margin: EdgeInsets.zero,
//     // ),

//     // Списки, разделители
//     // listTileTheme: ListTileThemeData(
//     //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     //   contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//     //   iconColor: scheme.onSurfaceVariant,
//     // ),
//     // dividerTheme: DividerThemeData(
//     //   color: scheme.outlineVariant,
//     //   thickness: 1,
//     //   space: 24,
//     // ),

//     // Снэкбары/прогресс
//     // snackBarTheme: SnackBarThemeData(
//     //   behavior: SnackBarBehavior.floating,
//     //   backgroundColor: scheme.inverseSurface,
//     //   contentTextStyle: TextStyle(color: scheme.onInverseSurface),
//     // ),
//     // progressIndicatorTheme: ProgressIndicatorThemeData(color: scheme.primary),

//     // Мелкие визуальные константы как ThemeExtension
//     // extensions: const <ThemeExtension<dynamic>>[
//     //   AppSpacing(),
//     //   AppRadius(),
//     // ],
//   );
// }

// /// Тёмная тема
// ThemeData buildDarkTheme() {
//   final scheme = ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark);

//   return ThemeData(
//     useMaterial3: true,
//     colorScheme: scheme,
//     textTheme: Typography.material2021(platform: TargetPlatform.android).white.copyWith(
//       headlineLarge: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, height: 1.1),
//       headlineMedium: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, height: 1.15),
//       titleLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//       bodyLarge: const TextStyle(fontSize: 16, height: 1.35),
//       bodyMedium: const TextStyle(fontSize: 14, height: 1.35),
//       labelLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//     ),
//     appBarTheme: AppBarTheme(
//       backgroundColor: scheme.surface,
//       foregroundColor: scheme.onSurface,
//       elevation: 0,
//       centerTitle: true,
//       titleTextStyle: TextStyle(
//         color: scheme.onSurface,
//         fontSize: 18,
//         fontWeight: FontWeight.w700,
//       ),
//     ),
//     navigationBarTheme: NavigationBarThemeData(
//       elevation: 0,
//       indicatorColor: scheme.secondaryContainer,
//       labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
//       backgroundColor: scheme.surface,
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: scheme.primary,
//         foregroundColor: scheme.onPrimary,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//       ),
//     ),
//     // textButtonTheme: TextButtonThemeData(
//     //   style: TextButton.styleFrom(foregroundColor: scheme.primary),
//     // ),
//     // outlinedButtonTheme: OutlinedButtonThemeData(
//     //   style: OutlinedButton.styleFrom(
//     //     foregroundColor: scheme.primary,
//     //     side: BorderSide(color: scheme.outline),
//     //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//     //   ),
//     // ),
//     // inputDecorationTheme: InputDecorationTheme(
//     //   filled: true,
//     //   fillColor: scheme.surface.withOpacity(0.9),
//     //   isDense: true,
//     //   contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//     //   border: OutlineInputBorder(
//     //     borderRadius: BorderRadius.circular(12),
//     //     borderSide: BorderSide(color: scheme.outlineVariant),
//     //   ),
//     //   enabledBorder: OutlineInputBorder(
//     //     borderRadius: BorderRadius.circular(12),
//     //     borderSide: BorderSide(color: scheme.outlineVariant),
//     //   ),
//     //   focusedBorder: OutlineInputBorder(
//     //     borderRadius: BorderRadius.circular(12),
//     //     borderSide: BorderSide(color: scheme.primary, width: 1.5),
//     //   ),
//     //   hintStyle: TextStyle(color: scheme.onSurface.withOpacity(0.6)),
//     // ),
//     // cardTheme: CardTheme(
//     //   elevation: 0,
//     //   clipBehavior: Clip.antiAlias,
//     //   color: scheme.surface,
//     //   surfaceTintColor: scheme.surfaceTint,
//     //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//     //   margin: EdgeInsets.zero,
//     // ),
//     // listTileTheme: ListTileThemeData(
//     //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     //   contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//     //   iconColor: scheme.onSurfaceVariant,
//     // ),
//     // dividerTheme: DividerThemeData(
//     //   color: scheme.outlineVariant,
//     //   thickness: 1,
//     //   space: 24,
//     // ),
//     // snackBarTheme: SnackBarThemeData(
//     //   behavior: SnackBarBehavior.floating,
//     //   backgroundColor: scheme.inverseSurface,
//     //   contentTextStyle: TextStyle(color: scheme.onInverseSurface),
//     // ),
//     // progressIndicatorTheme: ProgressIndicatorThemeData(color: scheme.primary),
//     // extensions: const <ThemeExtension<dynamic>>[
//     //   AppSpacing(),
//     //   AppRadius(),
//     // ],
//   );
// }

// /// Пример ThemeExtension для отступов
// @immutable
// class AppSpacing extends ThemeExtension<AppSpacing> {
//   final double xs, s, m, l, xl;
//   const AppSpacing({this.xs = 4, this.s = 8, this.m = 12, this.l = 16, this.xl = 24});

//   @override
//   AppSpacing copyWith({double? xs, double? s, double? m, double? l, double? xl}) =>
//       AppSpacing(xs: xs ?? this.xs, s: s ?? this.s, m: m ?? this.m, l: l ?? this.l, xl: xl ?? this.xl);

//   @override
//   ThemeExtension<AppSpacing> lerp(ThemeExtension<AppSpacing>? other, double t) => this;
// }

// /// Пример ThemeExtension для скруглений
// @immutable
// class AppRadius extends ThemeExtension<AppRadius> {
//   final BorderRadius small;
//   final BorderRadius medium;
//   final BorderRadius large;

//   const AppRadius({
//     this.small = const BorderRadius.all(Radius.circular(8)),
//     this.medium = const BorderRadius.all(Radius.circular(12)),
//     this.large = const BorderRadius.all(Radius.circular(16)),
//   });

//   @override
//   AppRadius copyWith({BorderRadius? small, BorderRadius? medium, BorderRadius? large}) =>
//       AppRadius(small: small ?? this.small, medium: medium ?? this.medium, large: large ?? this.large);

//   @override
//   ThemeExtension<AppRadius> lerp(ThemeExtension<AppRadius>? other, double t) => this;
// }
