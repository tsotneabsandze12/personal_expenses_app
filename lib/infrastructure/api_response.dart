class ApiResponse<T> {
  final bool isSuccessful;
  final T? data;
  final int? statusCode;
  final String? message;

  ApiResponse({
    required this.isSuccessful,
    this.data,
    this.statusCode,
    this.message,
  });
}
