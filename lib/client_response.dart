class ClientResponse<T> {
  ClientResponse({
    this.result,
    this.statusCode,
    this.exception,
  });

  final T? result;
  final int? statusCode;
  final Exception? exception;
}
