class ClientResponse<T> {
  ClientResponse({
    this.result,
    required this.statusCode,
  });

  final T? result;
  final int statusCode;
}
