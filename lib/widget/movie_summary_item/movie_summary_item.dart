import 'package:flutter/material.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/change_notifier/change_notifier_watcher.dart';
import 'package:movie_flutter/common/di/modules.dart';
import 'package:movie_flutter/widget/image_frame.dart';
import 'package:movie_flutter/widget/movie_summary_item/movie_summary_item_view_model.dart';

// TODO(danielgomezrico): move this simple logic into viewmodel and test it
class MovieSummaryItem extends StatelessWidget {
  const MovieSummaryItem({
    required MovieSummary movieSummary,
    super.key,
  }) : _movieSummary = movieSummary;

  final MovieSummary _movieSummary;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierWatcher(
      create: () => ViewModelModule.moveSummaryItemViewModel(_movieSummary),
      builder: (_, viewModel) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: viewModel.onTap,
            child: Stack(
              children: [
                _image(viewModel),
                _details(viewModel, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _details(MovieSummaryItemViewModel viewModel, BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              viewModel.status.title,
              style: textStyle.titleSmall?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 16),
                const SizedBox(width: 5),
                Text(
                  viewModel.status.voteAverage,
                  style: textStyle.bodySmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _image(MovieSummaryItemViewModel viewModel) {
    return Transform.scale(
      scale: 1.1, // Slight zoom effect
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.3), // Shadow effect
          BlendMode.darken,
        ),
        child: ImageFrame(imageUrl: viewModel.status.imageUrl),
      ),
    );
  }
}
