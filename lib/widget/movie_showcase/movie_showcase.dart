import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_flutter/api/repositories/models/movie_category.dart';
import 'package:movie_flutter/api/repositories/models/movie_sort.dart';
import 'package:movie_flutter/common/change_notifier/change_notifier_value.dart';
import 'package:movie_flutter/common/di/modules.dart';
import 'package:movie_flutter/common/shadow_sliver_app_bar_delegate.dart';
import 'package:movie_flutter/widget/animated_icon_button.dart';
import 'package:movie_flutter/widget/drop_down_selector.dart';
import 'package:movie_flutter/widget/empty.dart';
import 'package:movie_flutter/widget/loading.dart';
import 'package:movie_flutter/widget/movie_showcase/movie_showcase_view_model.dart';
import 'package:movie_flutter/widget/movie_summary_item/movie_summary_item.dart';
import 'package:movie_flutter/widget/retry_error.dart';

class MovieShowcase extends StatefulWidget {
  const MovieShowcase({super.key});

  @override
  State<MovieShowcase> createState() => _MovieShowcaseState();
}

class _MovieShowcaseState extends State<MovieShowcase> {
  late MovieShowcaseViewModel _viewModel;
  late ScrollController _scrollController;

  bool _showMoviesOnGrid = false;
  bool _isSettingsVisible = false;
  bool _showShadowOnActions = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _viewModel = ViewModelModule.movieShowcaseViewModel();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _viewModel.onInit();
    });

    _scrollController.addListener(_onScroll);
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
        return _body(viewModel);
      },
    );
  }

  Widget _body(MovieShowcaseViewModel viewModel) {
    final theme = Theme.of(context);

    return SafeArea(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _appBar(theme),
          _actions(),
          if (_isSettingsVisible) _settings(viewModel),
          if (viewModel.status.isLoadingVisible)
            const SliverFillRemaining(child: Loading()),
          if (viewModel.status.isEmptyVisible)
            const SliverFillRemaining(child: Empty()),
          if (viewModel.status.errorMessage != null) _error(viewModel),
          _movies(viewModel),
        ],
      ),
    );
  }

  SliverAppBar _appBar(ThemeData theme) {
    return SliverAppBar(
      title: const Text('Movies'),
      floating: true,
      snap: true,
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: theme.colorScheme.surface,
    );
  }

  SliverPersistentHeader _actions() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: ShadowSliverAppBarDelegate(
        minHeight: 40,
        maxHeight: 40,
        isShadowEnabled: !_isSettingsVisible && _showShadowOnActions,
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                AnimatedIconButton(
                  animationType: _isSettingsVisible
                      ? AnimationType.giroRight
                      : AnimationType.giroLeft,
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    setState(() => _isSettingsVisible = !_isSettingsVisible);
                  },
                ),
                AnimatedIconButton(
                  animationType: AnimationType.rotate,
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

  Widget _settings(MovieShowcaseViewModel viewModel) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: ShadowSliverAppBarDelegate(
        minHeight: 40,
        maxHeight: 40,
        isShadowEnabled: true,
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      const Text('Category:'),
                      const SizedBox(width: 8),
                      DropDownSelector(
                        labels: MovieCategory.values
                            .map(_mapCategoryToLabel)
                            .toList(),
                        values: MovieCategory.values.toList(),
                        onSelected: viewModel.onCategoryChanged,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _error(MovieShowcaseViewModel viewModel) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: RetryError(
        message: 'Error: ${viewModel.status.errorMessage}',
        onRetry: viewModel.onInit,
      ),
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: MovieSummaryItem(movieSummary: item),
          );
        },
      );
    } else {
      return SliverList.separated(
        itemCount: viewModel.status.items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, index) {
          final item = viewModel.status.items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: MovieSummaryItem(movieSummary: item),
          );
        },
      );
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

  String _mapCategoryToLabel(MovieCategory category) {
    switch (category) {
      case MovieCategory.popular:
        return 'Popular';
      case MovieCategory.playingNow:
        return 'Playing now';
    }
  }

  void _onScroll() {
    if (_scrollController.offset > 0 && !_showShadowOnActions) {
      setState(() {
        _showShadowOnActions = true;
      });
    } else if (_scrollController.offset <= 0 && _showShadowOnActions) {
      setState(() {
        _showShadowOnActions = false;
      });
    }

    final scrolledToEnd = _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;

    if (scrolledToEnd) {
      _viewModel.onBottomReached();
    }
  }
}
