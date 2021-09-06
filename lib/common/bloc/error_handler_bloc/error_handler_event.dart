abstract class ErrorHandlerEvent {}

class HandleErrorEvent extends ErrorHandlerEvent {
  HandleErrorEvent(this.error, this.stackTrace);

  final Object error;
  final StackTrace stackTrace;

  @override
  String toString() => 'HandleErrorEvent { error: $error }';
}
