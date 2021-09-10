import 'package:crypto_info/common/bloc/error_handler_bloc/error_handler_event.dart';
import 'package:crypto_info/common/bloc/error_handler_bloc/error_handler_state.dart';
import 'package:crypto_info/common/logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorHandlerBloc extends Bloc<ErrorHandlerEvent, ErrorHandlerState> {
  ErrorHandlerBloc(this._logger) : super(InitialErrorHandlerState());

  final Logger _logger;

  @override
  Stream<ErrorHandlerState> mapEventToState(ErrorHandlerEvent event) async* {
    if (event is HandleErrorEvent && event.error is DioError) {
      yield* _handleDioError(event.error as DioError, event.stackTrace);
    } else if (event is HandleErrorEvent) {
      yield* _handleUnknownError(event.error, event.stackTrace);
    }
  }

  Stream<ErrorHandlerState> _handleDioError(
    DioError error,
    StackTrace stackTrace,
  ) async* {
    if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.receiveTimeout ||
        error.type == DioErrorType.sendTimeout) {
      yield TimeoutErrorState();
    } else if (error.type == DioErrorType.response) {
      yield* _handleDioResponseError(error, stackTrace);
    } else {
      yield* _handleUnknownError(error, stackTrace);
    }
  }

  Stream<ErrorHandlerState> _handleDioResponseError(
    DioError error,
    StackTrace stackTrace,
  ) async* {
    final statusCode = error.response?.statusCode;
    switch (statusCode) {
      case 400:
        yield ValidationErrorState();
        break;
      case 403:
        yield ForbiddenErrorState();
        break;
      case 404:
        yield NotFoundErrorState();
        break;
      case 500:
        yield InternalServerErrorState();
        break;
      default:
        yield* _handleUnknownError(error, stackTrace);
    }
  }

  Stream<ErrorHandlerState> _handleUnknownError(
    Object error,
    StackTrace stackTrace,
  ) async* {
    _logger.e(
      message: 'Unknown error handled in ErrorHandlerBloc',
      error: error,
      stackTrace: stackTrace,
    );
    yield UnknownErrorState();
  }
}
