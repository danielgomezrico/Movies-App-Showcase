import 'package:flutter/material.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/change_notifier/change_notifier_watcher.dart';
import 'package:movie_flutter/common/di/modules.dart';
import 'package:movie_flutter/widget/image_frame.dart';
import 'package:movie_flutter/widget/movie_summary_item/movie_summary_item_view_model.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: InkWell(
            onTap: viewModel.onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  _image(viewModel),
                  _gradientOverlay(),
                  _details(viewModel, context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _gradientOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _details(MovieSummaryItemViewModel viewModel, BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            viewModel.status.title.toUpperCase(),
            style: textStyle.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 6),
              Text(
                viewModel.status.voteAverage,
                style: textStyle.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _image(MovieSummaryItemViewModel viewModel) {
    return Transform.scale(
      scale: 1.05, // Subtle zoom for a dynamic effect
      child: ImageFrame(
        imageUrl: viewModel.status.imageUrl,
      ),
    );
  }
}
