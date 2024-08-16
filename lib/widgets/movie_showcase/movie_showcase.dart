import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_flutter/api/repositories/models/movie_sort.dart';
import 'package:movie_flutter/common/change_notifier/change_notifier_value.dart';
import 'package:movie_flutter/common/di/modules.dart';
import 'package:movie_flutter/widgets/drop_down_selector.dart';
import 'package:movie_flutter/widgets/movie_summary_item/movie_summary_item.dart';
import 'package:movie_flutter/widgets/movie_showcase/movie_showcase_view_model.dart';

class MovieShowcase extends StatefulWidget {
  const MovieShowcase({super.key});

  @override
  State<MovieShowcase> createState() => _MovieShowcaseState();
}

class _MovieShowcaseState extends State<MovieShowcase> {
  late MovieShowcaseViewModel _viewModel;
  late ScrollController _scrollController;

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
          return Center(child: Text('Error: ${viewModel.status.errorMessage}'));
        } else {
          return _body(viewModel);
        }
      },
    );
  }

  Widget _body(MovieShowcaseViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
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
          ListView.separated(
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: viewModel.status.items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, index) {
              final item = viewModel.status.items[index];
              return MovieSummaryItem(movieSummary: item);
            },
          ),
        ],
      ),
    );
  }

  void _onScroll() {
    var scrolledToEnd = _scrollController.position.pixels ==
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
