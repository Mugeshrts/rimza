import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rimza/logic/bloc/login/bloc/login_event.dart';
import 'package:rimza/logic/bloc/login/bloc/login_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  Timer? _timer;
  DateTime? _otpStartTime;
  final box = GetStorage();

  OtpBloc() : super(OtpState.initial()) {
    on<SendOtp>(_onSendOtp);
    on<Tick>(_onTick);
    on<VerifyOtp>(_onVerifyOtp);
    on<ResendOtp>(_onResendOtp);
  }

  String get currentOtp => DateFormat('HHmm').format(DateTime.now());

  void _onSendOtp(SendOtp event, Emitter<OtpState> emit) {
    if (event.mobile != '8754277347') {
      emit(state.copyWith(error: 'Only valdi number is allowed'));
      return;
    }

    _otpStartTime = DateTime.now();
    _startTimer();
    emit(state.copyWith(
      otpSent: true,
      phoneLocked: true,
      otpExpired: false,
      timeLeft: Duration(minutes: 5),
      error: '',
    ));

    print('Static OTP: $currentOtp');
  }

  void _onTick(Tick event, Emitter<OtpState> emit) {
    final expiry = _otpStartTime!.add(Duration(minutes: 5));
    final remaining = expiry.difference(DateTime.now());

    if (remaining.isNegative) {
      _timer?.cancel();
      emit(state.copyWith(otpExpired: true, timeLeft: Duration.zero));
    } else {
      emit(state.copyWith(timeLeft: remaining));
    }
  }

  void _onVerifyOtp(VerifyOtp event, Emitter<OtpState> emit) {
    if (state.otpExpired) {
      emit(state.copyWith(error: 'OTP expired'));
      return;
    }

    if (event.enteredOtp == currentOtp) {
      _timer?.cancel();
      box.write('isLoggedIn', true);
      emit(state.copyWith(otpVerified: true, error: ''));
    } else {
      emit(state.copyWith(error: 'Invalid OTP'));
    }
  }

  void _onResendOtp(ResendOtp event, Emitter<OtpState> emit) {
    add(SendOtp('8754277347'));
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (_) => add(Tick()));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
