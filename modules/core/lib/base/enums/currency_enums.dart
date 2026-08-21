enum CurrencyEnums {
  EGP(responseKey: "egp"),
  USD(responseKey: "usd"),
  EUR(responseKey: "eur"),
  GBP(responseKey: "gbp"),
  SAR(responseKey: "sar"),
  JPY(responseKey: "jpy");

  final String responseKey;
  const CurrencyEnums({required this.responseKey});
}
