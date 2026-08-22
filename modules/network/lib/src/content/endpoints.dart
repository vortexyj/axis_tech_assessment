class EndPoints {
  EndPoints._();
  //authentication with Mobile Apis
  static const String login =
      'api/DynamicApp/v1/Authentication/LoginWithMobile';
  static const String forgotPassword =
      'api/DynamicApp/v1/Authentication/ResetPassword';
  static const String changePassword =
      'api/DynamicApp/v1/Authentication/ChangePassword';
  //verify and send otp for register Mobile
  static const String sendRegisterOtp =
      'api/DynamicApp/v1/Authentication/SendRegisterOtp';
  static const String sendDeleteAccountOtp =
      'api/DynamicApp/v1/Authentication/SendDeleteAccountOtp';
  static const String sendForgotPasswordOtp =
      'api/DynamicApp/v1/Authentication/SendForgotPasswordOtp';
  static const String verifyOtpDeleteAccount =
      'api/DynamicApp/v1/Authentication/VerifyOTPAndDeleteAccount';
  static const String verifyOtpForgotPassword =
      'api/DynamicApp/v1/Authentication/VerifyOTP';
  static const String verifyOtpRegister =
      'api/DynamicApp/v1/Authentication/VerifyAndRegister';

  //authentication with api key
  static const String getApiKey = 'api/DynamicApp/v1/Integration/Token';
  //RC MiddleWare Apis
  static const String items = 'api/DynamicApp/v2/Integration/Items';
  static const String wallet = 'api/DynamicApp/v1/Integration/Wallet';
  static const String itemDetails = 'api/DynamicApp/v1/Integration/ItemDetails';
  static const String purchase = 'api/DynamicApp/v1/Integration/purchase';
  static const String categories = 'api/DynamicApp/v1/Integration/categories';
  static const String pointsHistory =
      'api/DynamicApp/v1/Integration/PointsHistory';
  static const String purchaseHistory =
      'api/DynamicApp/v1/Integration/PurchasesHistory';
  static const String purchaseDetails =
      'api/DynamicApp/v1/Integration/PurchaseDetails';
  static const String brands = 'api/DynamicApp/v1/Integration/Brands';
  // branches
  static const String branches = 'api/DynamicApp/v1/Integration/GetBranches';
}
