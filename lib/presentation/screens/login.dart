// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pinput/pinput.dart';
// import 'package:rimza/logic/bloc/login/bloc/login_bloc.dart';
// import 'package:rimza/logic/bloc/login/bloc/login_event.dart';
// import 'package:rimza/logic/bloc/login/bloc/login_state.dart';
// import 'package:rimza/presentation/screens/home.dart';

// class OTPPage extends StatelessWidget {
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => OtpBloc(),
//       child: BlocConsumer<OtpBloc, OtpState>(
//         listener: (context, state) {
//           if (state.otpVerified) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => DeviceListScreen()),
//             );
//           }

//           if (state.error.isNotEmpty) {
//             ScaffoldMessenger.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(SnackBar(content: Text(state.error)));
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             backgroundColor: Color(0xFFF5F6FA),
//             body: Center(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Form(
//                   key: formKey,
//                   child: Container(
//                     padding: EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 10,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           'OTP Verification',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.indigo,
//                           ),
//                         ),
//                         SizedBox(height: 24),
//                         TextFormField(
//                           controller: phoneController,
//                           enabled: !state.phoneLocked,
//                           keyboardType: TextInputType.phone,
//                           inputFormatters: [
//                             FilteringTextInputFormatter.digitsOnly,
//                             LengthLimitingTextInputFormatter(10),
//                           ],
//                           decoration: InputDecoration(
//                             labelText: 'Mobile Number',
//                             prefixIcon: Icon(Icons.phone),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Enter mobile number';
//                             }
//                             if (!RegExp(r'^\d{10}$').hasMatch(value)) {
//                               return 'Enter valid 10-digit number';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height: 16),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor:
//                                 state.phoneLocked ? Colors.grey : Colors.indigo,
//                             padding: EdgeInsets.symmetric(vertical: 14),
//                             minimumSize: Size(double.infinity, 48),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           onPressed:
//                               (!state.phoneLocked)
//                                   ? () {
//                                     if (formKey.currentState!.validate()) {
//                                       context.read<OtpBloc>().add(
//                                         SendOtp(phoneController.text),
//                                       );
//                                     }
//                                   }
//                                   : null, // Disable button
//                           child: Text('Send OTP',style: TextStyle(color: Colors.white),),
//                         ),
//                         if (state.otpSent) ...[
//                           SizedBox(height: 24),
//                           Pinput(
//                             controller: otpController,
//                             length: 4,
//                             keyboardType: TextInputType.number,
//                             defaultPinTheme: PinTheme(
//                               width: 56,
//                               height: 56,
//                               textStyle: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.indigo),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 12),
//                           Text(
//                             state.otpExpired
//                                 ? 'OTP expired'
//                                 : 'Valid for ${state.timeLeft.inMinutes}:${(state.timeLeft.inSeconds % 60).toString().padLeft(2, '0')}',
//                             style: TextStyle(
//                               color:
//                                   state.otpExpired ? Colors.red : Colors.green,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(height: 16),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.indigo,
//                               padding: EdgeInsets.symmetric(vertical: 14),
//                               minimumSize: Size(double.infinity, 48),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             onPressed:
//                                 state.otpExpired
//                                     ? null
//                                     : () => context.read<OtpBloc>().add(
//                                       VerifyOtp(otpController.text),
//                                     ),
//                             child: Text(
//                               'Verify OTP',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed:
//                                 state.otpExpired
//                                     ? () {
//                                       otpController.clear();
//                                       context.read<OtpBloc>().add(ResendOtp());
//                                     }
//                                     : null,
//                             child: Text(
//                               'Resend OTP',
//                               style: TextStyle(
//                                 color: Colors.indigo,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
