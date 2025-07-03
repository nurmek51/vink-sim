class Country {
  final String name;
  final String code;
  final String dialCode;
  final String flag;

  const Country({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is Country &&
        other.name == name &&
        other.code == code &&
        other.dialCode == dialCode &&
        other.flag == flag;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        code.hashCode ^
        dialCode.hashCode ^
        flag.hashCode;
  }
}
