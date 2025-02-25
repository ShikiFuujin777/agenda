import 'model/business_error.dart';

class BusinessException implements Exception {
  final BusinessError error;

  const BusinessException(
    this.error,
  );

  factory BusinessException.basic({
    required String message,
    String? code,
  }) =>
      BusinessException(
        BusinessError(
          message: message,
          code: code,
        ),
      );
}
