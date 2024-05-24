import 'package:cached_network_image/cached_network_image.dart';
import 'package:coolmovies/data_models/data_models.dart';
import 'package:coolmovies/ui/views/create_review/create_review_view.dart';
import 'package:coolmovies/ui/widgets/busy_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/movie_cubit.dart';
import 'widgets/review_card.dart';

class MovieView extends StatefulWidget {
  final Movie? movie;
  final MovieCubit? cubit;
  const MovieView({
    super.key,
    this.movie,
    this.cubit,
  });

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  late MovieCubit _cubit;

  @override
  void initState() {
    _cubit = widget.cubit ?? MovieCubit();
    _cubit.fetchMovieReviews(widget.movie?.id ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              final result = await Navigator.of(context).push<bool>(
                MaterialPageRoute(
                  builder: (context) => CreateReviewView(
                    movie: widget.movie,
                  ),
                ),
              );
              if (result == true) {
                _cubit.fetchMovieReviews(widget.movie?.id ?? '');
              }
            },
            child: Text(
              'Leave a Review',
              style: theme.labelLarge?.copyWith(
                color: Colors.blueGrey,
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                CachedNetworkImage(
                  imageUrl: widget.movie?.imgUrl ?? '',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
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
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    widget.movie?.title ?? '--',
                    style: theme.titleLarge,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: RichText(
                    text: TextSpan(
                      text: 'Created By:',
                      style: theme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: widget.movie?.userByUserCreatorId?.name ?? '--',
                          style: theme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: RichText(
                    text: TextSpan(
                      text: 'Released Date:',
                      style: theme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: widget.movie?.releaseDate ?? '--',
                          style: theme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'REVIEWS',
                    style: theme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
          SliverLayoutBuilder(
            builder: (context, constraints) {
              return BlocBuilder<MovieCubit, MovieState>(
                bloc: _cubit,
                builder: (context, state) {
                  if (state is FetchMovieReviewsLoading) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is FetchMovieReviewsLoaded) {
                    return SliverLayoutBuilder(
                      builder: (context, constraints) {
                        if (state.reviews?.isEmpty ??
                            false || state.reviews == null) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text(
                                  'No Reviews Available for ${widget.movie?.title ?? "--"}'),
                            ),
                          );
                        }
                        return SliverList.separated(
                          itemCount: state.reviews?.length,
                          itemBuilder: (context, index) {
                            final review = state.reviews?.elementAt(index);
                            return ReviewCard(
                              review: review,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                        );
                      },
                    );
                  }

                  if (state is FetchMovieReviewsError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(state.message ?? ''),
                      ),
                    );
                  }

                  return const SliverToBoxAdapter(
                    child: SizedBox.shrink(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cubit.disposeState();
    super.dispose();
  }
}
