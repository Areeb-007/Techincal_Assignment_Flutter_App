class APIResponse<T> {
  T? data;
  bool error;
  String errorMessage = '';

  APIResponse({this.data, required this.errorMessage, this.error = false});
}
