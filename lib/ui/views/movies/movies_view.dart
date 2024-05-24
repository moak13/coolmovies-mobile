import 'package:coolmovies/ui/views/movie/movie_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/movies_cubit.dart';
import 'widgets/movie_card.dart';

class MoviesView extends StatefulWidget {
  final MoviesCubit? cubit;
  const MoviesView({
    super.key,
    this.cubit,
  });

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  late MoviesCubit _cubit;

  @override
  void initState() {
    _cubit = widget.cubit ?? MoviesCubit();
    _cubit.fetchMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'MOVIES',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<MoviesCubit, MoviesState>(
              bloc: _cubit,
              builder: (context, state) {
                if (state is FetchMoviesLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is FetchMoviesLoaded) {
                  return Builder(
                    builder: (context) {
                      if (state.movies?.isEmpty ??
                          false || state.movies == null) {
                        return const Expanded(
                          child: Center(
                            child: Text('No Movie(s) Available'),
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 16,
                            right: 16,
                          ),
                          itemCount: state.movies?.length ?? 0,
                          itemBuilder: (context, index) {
                            final movie = state.movies?.elementAt(index);
                            return MovieCard(
                              movie: movie!,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MovieView(
                                      movie: movie,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                        ),
                      );
                    },
                  );
                }
                if (state is FetchMoviesError) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          size: 35,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                          ),
                          child: Text(
                            state.message ?? '',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cubit.disposeState();
    super.dispose();
  }
}
