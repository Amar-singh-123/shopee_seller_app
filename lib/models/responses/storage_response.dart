class StorageResponse {
  bool success;
  dynamic error;
  int statusCode;
  String? url;

  StorageResponse({this.success = true,
    this.error,
    this.statusCode = 200,
    this.url
  });

}