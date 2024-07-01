class EndPoints {
  const EndPoints._();
  static const _base = "https://api.tezda.tech/auth/t";

  static const _baseUser = "https://api.tezda.tech/user/t";

  static const createUser = "$_base/createUser";

  static const sendOTP = "$_base/sendOtp";

  static const verifyOTP = "$_base/verifyOtp";

  static const login = "$_base/login";

  static  socket(String userId) => "wss://wss.tezda.me?userId=$userId";

  static const createContacts = "$_baseUser/syncContactList";
}