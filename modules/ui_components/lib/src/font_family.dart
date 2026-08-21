class FontFamily {
  static final FontFamily _instance = FontFamily.internal();

  FontFamily.internal();

  factory FontFamily() => _instance;

  String cairo = 'Cairo';
}
