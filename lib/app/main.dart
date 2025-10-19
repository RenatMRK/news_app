import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/features/news/data/datasources/news_remote_data_source.dart';
import 'package:news_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:news_app/features/news/domain/usecases/get_news.dart';

import 'package:news_app/app/app.dart';
import 'package:news_app/features/news/presentation/logic/news_bloc.dart';

void main() {
  final client = http.Client();

  // ✅ Data source (передаём ключ сюда)
  final remoteDataSource = NewsRemoteDataSourceImpl(
    httpClient: client,
    apiKey: 'ad5bf4b1609e4315b6d5f17cfe28138e', // ← вот сюда вставь ключ
  );

  // Repository
  final repository = NewsRepositoryImpl(remoteDataSource);

  // Use case
  final getNews = GetNews(repository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NewsBloc(getNews),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
