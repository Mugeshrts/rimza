
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:rimza/logic/bloc/login/bloc/login_event.dart';
import 'package:rimza/logic/bloc/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetStorage storage = GetStorage();

  LoginBloc() : super(LoginInitial()) {
    on<SendOtpEvent>((event, emit) {
      if (event.phone.trim() != '8754277347') {
        emit(LoginFailure("Only valid mobile number is allowed"));
      } else {
        emit(OtpSentState());
        print("OTP sent: ${_currentOtp()}");
      }
    });

    on<VerifyOtpEvent>((event, emit) {
      if (event.otp.trim().isEmpty) {
        emit(LoginFailure("Please enter the OTP"));
      } else if (event.otp.trim() != _currentOtp()) {
        emit(LoginFailure("Invalid OTP"));
      } else {
        storage.write('isLoggedIn', true);
        emit(LoginSuccess());
      }
    });

    on<ResendOtpEvent>((event, emit) {
      emit(OtpSentState());
      print("OTP resent: ${_currentOtp()}");
    });
  }

  String _currentOtp() => DateFormat('HHmm').format(DateTime.now());
}
