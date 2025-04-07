class OtpState {
  final bool otpSent;
  final bool otpVerified;
  final bool otpExpired;
  final bool phoneLocked;
  final Duration timeLeft;
  final String error;

  OtpState({
    required this.otpSent,
    required this.otpVerified,
    required this.otpExpired,
    required this.phoneLocked,
    required this.timeLeft,
    required this.error,
  });

  factory OtpState.initial() => OtpState(
        otpSent: false,
        otpVerified: false,
        otpExpired: false,
        phoneLocked: false,
        timeLeft: Duration.zero,
        error: '',
      );

  OtpState copyWith({
    bool? otpSent,
    bool? otpVerified,
    bool? otpExpired,
    bool? phoneLocked,
    Duration? timeLeft,
    String? error,
  }) {
    return OtpState(
      otpSent: otpSent ?? this.otpSent,
      otpVerified: otpVerified ?? this.otpVerified,
      otpExpired: otpExpired ?? this.otpExpired,
      phoneLocked: phoneLocked ?? this.phoneLocked,
      timeLeft: timeLeft ?? this.timeLeft,
      error: error ?? '',
    );
  }
}
