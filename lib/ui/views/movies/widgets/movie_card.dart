import 'package:cached_network_image/cached_network_image.dart';
import 'package:coolmovies/data_models/movie.dart';
import 'package:coolmovies/ui/widgets/busy_widget.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;
  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: movie.imgUrl ?? '',
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            placeholder: (context, url) {
              return const BusyWidget();
            },
            errorWidget: (context, url, error) {
              return const Center(
                child: Icon(
                  Icons.error_rounded,
                ),
              );
            },
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title ?? '--',
                style: theme.titleMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Released Date: ${movie.releaseDate}',
                style: theme.bodyMedium,
              ),
            ],
          )
        ],
      ),
    );
  }
}
