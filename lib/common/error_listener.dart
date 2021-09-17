import 'package:crypto_info/common/bloc/error_handler_bloc/error_handler_state.dart';
import 'package:flutter/material.dart';

class ErrorListener {
  void listener(BuildContext context, ErrorHandlerState state) {
    if (state is TimeoutErrorState) {
      const errorSnackBar = SnackBar(
        content: Text(
          'Server connection timeout. Please try again.',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      return;
    }
    if (state is ValidationErrorState) {
      const errorSnackBar = SnackBar(
        content: Text(
          'Server has returned an error. Please verify all information you have entered.',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      return;
    }
    if (state is NotFoundErrorState) {
      const errorSnackBar = SnackBar(
        content: Text(
          'Server has returned the 404 error. Our team is already working on it!',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      return;
    }
    if (state is InternalServerErrorState) {
      const errorSnackBar = SnackBar(
        content: Text(
          'Server has returned the 500 error. Our team is already working on it!',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      return;
    }
    if (state is UnknownErrorState) {
      const errorSnackBar = SnackBar(
        content: Text(
          'An unknown error has occurred. Our team is already working on it!',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      return;
    }
  }
}
