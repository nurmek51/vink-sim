enum ConfirmMethod {
  byPhone,
  byEmail,
}

extension ConfirmMethodExtension on ConfirmMethod {
  String get path {
    switch (this) {
      case ConfirmMethod.byPhone:
        return 'by-phone';
      case ConfirmMethod.byEmail:
        return 'by-email';
    }
  }
}