import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:news_app/app/app.dart';
import 'package:news_app/app/di/di.dart';
import 'package:news_app/features/news/presentation/logic/news/news_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ru');

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<NewsBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}
