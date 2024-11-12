enum ProfileFieldType {
  email,
  name;

  String get fieldName => switch (this) {
        ProfileFieldType.email => "이메일",
        ProfileFieldType.name => "이름",
      };
}
