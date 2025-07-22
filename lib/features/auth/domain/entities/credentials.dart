abstract class Credentials {}

class PhoneCredentials implements Credentials {
  final String phoneNumber;
  final String? verificationId;
  final String? smsCode;
  
  PhoneCredentials({
    required this.phoneNumber,
    this.verificationId,
    this.smsCode,
  });
}

class EmailCredentials implements Credentials {
  final String email;
  EmailCredentials(this.email);
}

class FirebaseEmailCredentials implements Credentials {
  final String email;
  final String password;
  final bool isSignUp;

  FirebaseEmailCredentials({
    required this.email,
    required this.password,
    this.isSignUp = false,
  });
}
