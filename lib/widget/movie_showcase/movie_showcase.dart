import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_flutter/api/repositories/models/movie_sort.dart';
import 'package:movie_flutter/common/change_notifier/change_notifier_value.dart';
import 'package:movie_flutter/common/di/modules.dart';
import 'package:movie_flutter/widget/drop_down_selector.dart';
import 'package:movie_flutter/widget/movie_showcase/movie_showcase_view_model.dart';
import 'package:movie_flutter/widget/movie_summary_item/movie_summary_item.dart';
import 'package:movie_flutter/widget/retry_error.dart';

import '../../common/shadow_sliver_app_bar_delegate.dart';

class MovieShowcase extends StatefulWidget {
  const MovieShowcase({super.key});

  @override
  State<MovieShowcase> createState() => _MovieShowcaseState();
}

class _MovieShowcaseState extends State<MovieShowcase> {
  late MovieShowcaseViewModel _viewModel;
  late ScrollController _scrollController;
  bool _showMoviesOnGrid = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _viewModel = ViewModelModule.movieShowcaseViewModel();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _viewModel.onInit();
    });

    _scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _viewModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierValue(
      value: _viewModel,
      builder: (_, viewModel) {
        if (viewModel.status.isEmptyVisible) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewModel.status.isEmptyVisible) {
          return const Center(child: Text('No movies found'));
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
          return _body(viewModel);
        }
      },
    );
  }

  Widget _body(MovieShowcaseViewModel viewModel) {
    return SafeArea(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _appBar(),
          _actions(viewModel),
          _movies(viewModel),
        ],
      ),
    );
  }

  SliverPersistentHeader _actions(MovieShowcaseViewModel viewModel) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: ShadowSliverAppBarDelegate(
        minHeight: 40,
        maxHeight: 40,
        isShadowEnabled: true,
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surface,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      const Text('Sort by:'),
                      const SizedBox(width: 8),
                      DropDownSelector(
                        labels: MovieSort.values.map(_mapToLabel).toList(),
                        values: MovieSort.values.toList(),
                        onSelected: viewModel.onSortChanged,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: _showMoviesOnGrid
                      ? const Icon(Icons.view_list_rounded)
                      : const Icon(Icons.grid_on),
                  onPressed: () {
                    setState(() => _showMoviesOnGrid = !_showMoviesOnGrid);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverAppBar _appBar() {
    return const SliverAppBar(
      title: Text('Movies'),
      floating: true,
      snap: true,
      shadowColor: Colors.black,
    );
  }

  Widget _movies(MovieShowcaseViewModel viewModel) {
    if (_showMoviesOnGrid) {
      return SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: viewModel.status.items.length,
        itemBuilder: (_, index) {
          final item = viewModel.status.items[index];
          return MovieSummaryItem(movieSummary: item);
        },
      );
    } else {
      return SliverList.separated(
        itemCount: viewModel.status.items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, index) {
          final item = viewModel.status.items[index];
          return MovieSummaryItem(movieSummary: item);
        },
      );
    }
  }

  void _onScroll() {
    final scrolledToEnd = _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;

    if (scrolledToEnd) {
      _viewModel.onBottomReached();
    }
  }

  String _mapToLabel(MovieSort sort) {
    switch (sort) {
      case MovieSort.titleAsc:
        return 'Title (A-Z)';
      case MovieSort.titleDesc:
        return 'Title (Z-A)';
      case MovieSort.releaseDateAsc:
        return 'Newest first';
      case MovieSort.releaseDateDesc:
        return 'Oldest first';
    }

    throw Exception('Unknown sort: $sort');
  }
}
