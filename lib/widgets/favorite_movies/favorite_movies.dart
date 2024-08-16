import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_flutter/common/change_notifier/change_notifier_value.dart';
import 'package:movie_flutter/common/di/modules.dart';
import 'package:movie_flutter/widgets/favorite_movies/favorite_movies_view_model.dart';
import 'package:movie_flutter/widgets/movie_summary_item/movie_summary_item.dart';
import 'package:movie_flutter/widgets/retry_error.dart';

class FavoriteMovies extends StatefulWidget {
  const FavoriteMovies({super.key});

  @override
  State<FavoriteMovies> createState() => _FavoriteMoviesState();
}

class _FavoriteMoviesState extends State<FavoriteMovies> {
  late FavoriteMoviesViewModel _viewModel;

  @override
  void initState() {
    _viewModel = ViewModelModule.favoriteMoviesViewModel();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _viewModel.onInit();
    });

    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        title: const Text('Favorite Movies'),
      ),
      body: ChangeNotifierValue(
        value: _viewModel,
        builder: (_, viewModel) {
          if (viewModel.status.isLoadingVisible) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.status.isEmptyVisible) {
            return const Center(child: Text('No favorite movies found :)'));
          } else if (viewModel.status.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: RetryError(
                  message: 'Error: ${viewModel.status.errorMessage}',
                  onRetry: viewModel.onInit,
                ),
              ),
            );
          } else {
            return movies(viewModel);
          }
        },
      ),
    );
  }

  Widget movies(FavoriteMoviesViewModel viewModel) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: viewModel.status.items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, index) {
        final item = viewModel.status.items[index];
        return MovieSummaryItem(movieSummary: item);
      },
    );
  }
}
