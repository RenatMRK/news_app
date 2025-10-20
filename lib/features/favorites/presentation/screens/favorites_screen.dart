import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/di/di.dart';
import 'package:news_app/features/favorites/presentation/logic/favorites_list_bloc.dart';
import 'package:news_app/features/favorites/presentation/logic/favorites_list_event.dart';
import 'package:news_app/features/favorites/presentation/logic/favorites_list_state.dart';
import 'package:news_app/features/shared/widgets/news_list_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme.outlineVariant;

    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (_) => sl<FavoritesListBloc>()..add(LoadFavoritesEvent()),
        child: BlocBuilder<FavoritesListBloc, FavoritesListState>(
          builder: (context, state) {
            if (state is FavoritesListLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is FavoritesListError) {
              return Center(
                child: Text(
                  'Ошибка загрузки: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is FavoritesListLoaded) {
              final articles = state.favorites;

              if (articles.isEmpty) {
                return const Center(
                  child: Text(
                    'Нет избранных новостей 💔',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return NewsListWidget(
                articles: articles,
                onTapArticle: (_) {},
                icon: Icon(Icons.star, color: scheme, size: 30),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
