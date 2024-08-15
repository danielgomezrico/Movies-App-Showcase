import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/change_notifier/change_notifier_value.dart';
import 'package:movie_flutter/common/di/modules.dart';
import 'package:movie_flutter/features/movie_detail/movie_detail_status.dart';
import 'package:movie_flutter/features/movie_detail/movie_detail_view_model.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movieSummary});

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

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _appBar(status),
              _detail(status),
            ],
          ),
        );
      },
    );
  }

  SliverList _detail(MovieDetailStatus status) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _body(status),
                const SizedBox(height: 16.0),
                status.isLoadingVisible
                    ? const Center(child: CircularProgressIndicator())
                    : _MovieSummary(status: status),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _body(MovieDetailStatus status) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 24.0),
        const SizedBox(width: 4.0),
        Text(
          status.voteAverage ?? '---',
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          status.voteCount != null ? status.voteCount! : 'Unknown votes',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  SliverAppBar _appBar(MovieDetailStatus status) {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      iconTheme: const IconThemeData(
        color: Colors.white
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(status.title,
            style: const TextStyle(fontSize: 16.0, color: Colors.white)),
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(imageUrl: status.imageUrl, fit: BoxFit.cover),
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
}

class _MovieSummary extends StatelessWidget {
  const _MovieSummary({required this.status});

  final MovieDetailStatus status;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: status.genres.map((genre) {
            return Chip(
              label: Text(genre),
              backgroundColor: Colors.deepPurpleAccent.withOpacity(0.7),
              labelStyle: const TextStyle(color: Colors.white),
            );
          }).toList(),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Overview',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          status.overview != null ? status.overview! : '---',
          style: TextStyle(
            fontSize: 16.0,
            height: 1.5,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          status.releaseDate != null
              ? status.releaseDate!
              : 'Release Date: Unknown',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          status.language != null
              ? 'Languages: ${status.language}'
              : 'Languages: Unknown',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
