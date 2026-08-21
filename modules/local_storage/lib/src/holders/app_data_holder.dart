class AppDataHolder {
  // Private constructor
  AppDataHolder._internal();

  // The single shared instance
  static final AppDataHolder instance = AppDataHolder._internal();

  String? token;

  // Methods
  void setToken(String? token) => this.token = token;

  void clear() {
    token = null;
  }
}
