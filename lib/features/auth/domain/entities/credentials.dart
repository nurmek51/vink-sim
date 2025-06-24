abstract class Credentials {}

class PhoneCredentials implements Credentials {
  final String phone;
  PhoneCredentials(this.phone);
}

class EmailCredentials implements Credentials {
  final String email;
  EmailCredentials(this.email);
}