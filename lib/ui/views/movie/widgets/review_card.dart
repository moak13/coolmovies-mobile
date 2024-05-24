import 'package:coolmovies/data_models/review.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final Review? review;
  const ReviewCard({
    super.key,
    this.review,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.grey,
        child: Column(
          children: [
            Text(
              'Rating',
              style: theme.bodyLarge?.copyWith(
                fontSize: 10,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              review?.rating?.toString() ?? '--',
              style: theme.bodySmall?.copyWith(
                fontSize: 15,
                color: Colors.white38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      title: Text(
        review?.title ?? '--',
        style: theme.titleMedium,
      ),
      subtitle: Text(
        review?.body ?? '--',
        style: theme.bodySmall,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
