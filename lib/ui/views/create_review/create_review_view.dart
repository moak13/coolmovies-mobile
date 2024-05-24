import 'package:coolmovies/data_models/data_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/create_review_cubit.dart';
import 'widgets/widgets.dart';

class CreateReviewView extends StatefulWidget {
  final Movie? movie;
  final CreateReviewCubit? cubit;
  const CreateReviewView({
    super.key,
    this.movie,
    this.cubit,
  });

  @override
  State<CreateReviewView> createState() => _CreateReviewViewState();
}

class _CreateReviewViewState extends State<CreateReviewView> {
  late CreateReviewCubit _cubit;
  final TextEditingController _reviewTitleController = TextEditingController();
  final TextEditingController _reviewBodyController = TextEditingController();
  final FocusNode _reviewTitleFocusNode = FocusNode();
  final FocusNode _reviewBodyFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late int rating;

  @override
  void initState() {
    _cubit = widget.cubit ?? CreateReviewCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.movie?.title ?? ''} Review'),
      ),
      body: BlocListener<CreateReviewCubit, CreateReviewState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is CreateReviewLoaded) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog.adaptive(
                  title: const Text('INFO'),
                  content: const Text('Movie Review Added Successfully'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context, true);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: BlocBuilder<CreateReviewCubit, CreateReviewState>(
          bloc: _cubit,
          builder: (context, state) {
            return OverlayLoader(
              isBusy: state is CreateReviewLoading,
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 10,
                  ),
                  children: [
                    TextFormField(
                      controller: _reviewTitleController,
                      focusNode: _reviewTitleFocusNode,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      decoration: const InputDecoration(
                        labelText: 'Review Title',
                        hintText: 'Enter your review title',
                      ),
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          _reviewBodyFocusNode.requestFocus();
                        }
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return 'Title cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: _reviewBodyController,
                      focusNode: _reviewBodyFocusNode,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Review Body',
                        hintText: 'Enter your review body',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return 'Body cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Select Rating',
                      style: theme.titleLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RateOptions(
                      rates: _cubit.ratings,
                      onSelected: (rate) {
                        rating = rate;
                      },
                      validator: (value) {
                        if (value == null || value == 0) {
                          return 'Kindly select a rating';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      onPressed: _onNext,
                      color: Colors.black,
                      child: Text(
                        'Submit',
                        style: theme.titleSmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onNext() {
    if (_formKey.currentState?.validate() ?? false) {
      MovieReviewRequest movieReview = MovieReviewRequest(
        title: _reviewTitleController.text.trim(),
        body: _reviewBodyController.text.trim(),
        movieId: widget.movie?.id ?? '',
        rating: rating,
        userReviewerId: widget.movie?.userCreatorId ?? '',
      );
      _cubit.postMovieReview(movieReview);
    }
  }

  @override
  void dispose() {
    _reviewBodyController.dispose();
    _reviewTitleController.dispose();
    _reviewBodyFocusNode.dispose();
    _reviewTitleFocusNode.dispose();
    _cubit.disposeState();
    super.dispose();
  }
}
