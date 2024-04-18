class AuthResponse{
  final int statusCode;
  final bool success;
  final dynamic error;
  final String? uid;
  AuthResponse({required this.statusCode, required this.success, this.error, this.uid});
}