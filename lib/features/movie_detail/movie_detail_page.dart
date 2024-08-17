import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/change_notifier/change_notifier_value.dart';
import 'package:movie_flutter/common/di/modules.dart';
import 'package:movie_flutter/features/movie_detail/movie_detail_status.dart';
import 'package:movie_flutter/features/movie_detail/movie_detail_view_model.dart';
import 'package:movie_flutter/widgets/image_frame.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({required this.movieSummary, super.key});

  final MovieSummary movieSummary;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late MovieDetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ViewModelModule.movieDetailViewModel(widget.movieSummary);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _viewModel.onInit();
    });
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
      builder: (_, __) {
        final status = _viewModel.status;
        final textTheme = Theme.of(context).textTheme;

        return Scaffold(
          body: PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (didPop) return;
              _viewModel.onBackTap();
            },
            child: CustomScrollView(
              slivers: [
                _appBar(status, textTheme),
                _detail(status),
              ],
            ),
          ),
        );
      },
    );
  }

  SliverAppBar _appBar(MovieDetailStatus status, TextTheme textTheme) {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      iconTheme: const IconThemeData(color: Colors.white),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: _viewModel.onBackTap,
      ),
      actions: [
        if (_viewModel.status.isFavoriteVisible)
          IconButton(
            icon: _viewModel.status.isFavorite ?? false
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: _viewModel.onSaveFavorite,
          ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          status.title,
          style: textTheme.titleSmall?.copyWith(color: Colors.white),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            ImageFrame(imageUrl: status.imageUrl),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverList _detail(MovieDetailStatus status) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _body(status, context),
                const SizedBox(height: 16),
                if (status.isLoadingVisible)
                  const Center(child: CircularProgressIndicator())
                else
                  _MovieSummary(status: status),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _body(MovieDetailStatus status, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 24),
        const SizedBox(width: 4),
        Text(status.voteAverage ?? '---', style: textTheme.bodyMedium),
        const SizedBox(width: 8),
        Text(
          status.voteCount != null ? status.voteCount! : 'Unknown votes',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _MovieSummary extends StatelessWidget {
  const _MovieSummary({required this.status});

  final MovieDetailStatus status;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Genres', style: textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: status.genres.map((genre) {
            return Chip(
              label: Text(genre),
              backgroundColor: Colors.deepPurpleAccent.withOpacity(0.7),
              labelStyle: textTheme.labelLarge?.copyWith(color: Colors.white),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Text('Overview', style: textTheme.titleSmall),
        const SizedBox(height: 8),
        Text(
          status.overview != null ? status.overview! : '---',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          status.releaseDate != null
              ? status.releaseDate!
              : 'Release Date: Unknown',
          style: textTheme.labelSmall,
        ),
        const SizedBox(height: 8),
        Text(
          status.language != null
              ? 'Languages: ${status.language}'
              : 'Languages: Unknown',
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
}
