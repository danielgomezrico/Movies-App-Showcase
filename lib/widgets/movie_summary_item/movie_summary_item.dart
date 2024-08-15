import 'package:flutter/material.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/di/common_module.dart';
import 'package:movie_flutter/common/router/sites/movie_detail_site.dart';
import 'package:movie_flutter/widgets/image_container.dart';

// TODO: move this simple logic into viewmodel and test it
class MovieSummaryItem extends StatelessWidget {
  const MovieSummaryItem({
    super.key,
    required MovieSummary movieSummary,
  }) : _movieSummary = movieSummary;

  final MovieSummary _movieSummary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          final site = MovieDetailSite(_movieSummary);
          CommonModule.router().pushTo(site);
        },
        child: Stack(
          children: [
            _image(),
            _details(),
          ],
        ),
      ),
    );
  }

  Widget _details() {
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
              _movieSummary.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 16),
                const SizedBox(width: 5),
                Text(
                  _movieSummary.voteAverage.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _image() {
    return Transform.scale(
      scale: 1.1, // Slight zoom effect
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.3), // Shadow effect
          BlendMode.darken,
        ),
        child: ImageFrame(imageUrl: _movieSummary.url),
      ),
    );
  }
}
