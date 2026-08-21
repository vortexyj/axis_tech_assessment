enum CurrencyEnums {
  EGP(responseKey: "egp", displayName: "Egyptian Pound"),
  USD(responseKey: "usd", displayName: "US Dollar"),
  EUR(responseKey: "eur", displayName: "Euro"),
  GBP(responseKey: "gbp", displayName: "British Pound"),
  SAR(responseKey: "sar", displayName: "Saudi Riyal"),
  JPY(responseKey: "jpy", displayName: "Japanese Yen");

  final String responseKey;
  final String displayName;
  const CurrencyEnums({required this.responseKey, required this.displayName});
}
