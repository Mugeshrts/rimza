abstract class OtpEvent {}

class SendOtp extends OtpEvent {
  final String mobile;
  SendOtp(this.mobile);
}

class VerifyOtp extends OtpEvent {
  final String enteredOtp;
  VerifyOtp(this.enteredOtp);
}

class ResendOtp extends OtpEvent {}

class Tick extends OtpEvent {}
