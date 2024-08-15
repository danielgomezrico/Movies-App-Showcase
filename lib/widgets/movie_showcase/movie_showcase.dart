import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_flutter/common/change_notifier/change_notifier_value.dart';
import 'package:movie_flutter/common/di/modules.dart';
import 'package:movie_flutter/widgets/movie_item/movie_summary_item.dart';
import 'package:movie_flutter/widgets/movie_showcase/movie_showcase_view_model.dart';

class MovieShowcase extends StatefulWidget {
  const MovieShowcase({super.key});

  @override
  State<MovieShowcase> createState() => _MovieShowcaseState();
}

class _MovieShowcaseState extends State<MovieShowcase> {
  late MovieShowcaseViewModel _viewModel;

  @override
  void initState() {
    _viewModel = ViewModelModules.movieShowcaseViewModel();

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
    return ChangeNotifierValue(
      value: _viewModel,
      builder: (_, viewModel) {
        return ListView.separated(
          itemCount: viewModel.status.items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (_, index) {
            final item = viewModel.status.items[index];
            return MovieSummaryItem(movieSummary: item);
          },
        );
      },
    );
  }
}
