// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:intl/intl.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:pinput/pinput.dart';
// import 'package:rimza/presentation/screens/home.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool isOtpScreen = false; // Toggle between phone & OTP screen
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController otpController = TextEditingController();
  
//   String get currentOtp => DateFormat('HHmm').format(DateTime.now());

// void showSnack(String message, [Color? color]) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: color ?? Colors.red,
//       ),
//     );
//   }

//    void handleSendOtp() {
//     final enteredPhone = phoneController.text.trim();

//     if (enteredPhone != '8754277347') {
//       showSnack("Only valid mobile number is allowed");
//       return;
//     }

//     print("OTP sent: $currentOtp"); // Debug only
//     setState(() {
//       isOtpScreen = true;
//     });
//   }

//  void handleVerifyOtp() {
//     final otp = otpController.text.trim();

//     if (otp.isEmpty) {
//       showSnack("Please enter the OTP");
//       return;
//     }

//     if (otp != currentOtp) {
//       showSnack("Invalid OTP");
//       return;
//     }

//    // ✅ OTP Verified - save session & navigate
//   final box = GetStorage();
//   box.write('isLoggedIn', true);

//   showSnack("OTP Verified Successfully", Colors.green);

//   Future.delayed(Duration(milliseconds: 500), () {
//     Get.offAll(() => DeviceListScreen()); // Navigate and remove history
//   });
//   }




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Phone Illustration
//               Image.asset(
//                 'assets/images/loginvector.png', // Replace with your asset
//                 height: 180,
//               ),
//               SizedBox(height: 20),

//               // Screen Toggle (Phone Input or OTP Screen)
//               isOtpScreen ? buildOtpScreen() : buildPhoneInputScreen(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Phone Input UI
//   Widget buildPhoneInputScreen() {
//     return Column(
//       children: [
//         Text(
//           "Enter Your Mobile Number",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 6),
//         Text(
//           "We will send you a confirmation code",
//           style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//         ),
//         SizedBox(height: 24),

//         // Phone Number Field
//         IntlPhoneField(
//           controller: phoneController,
//           decoration: InputDecoration(
//             labelText: "Phone number",
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(),
//             ),
//           ),
//           initialCountryCode: "IN",
//           keyboardType: TextInputType.phone,
//           onChanged: (phone) {
//             // Optional: format handling
//           },
//         ),
//         SizedBox(height: 24),

//         // Get OTP Button
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blue.shade900,
//             padding: EdgeInsets.symmetric(vertical: 14),
//             minimumSize: Size(double.infinity, 50),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(25),
//             ),
//           ),
//           onPressed: handleSendOtp,
//           child: Text(
//             "Get OTP",
//             style: TextStyle(fontSize: 16, color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }

//    // 🔐 OTP Input Screen
//   Widget buildOtpScreen() {
//     String obfuscatedPhone = phoneController.text.length >= 10
//         ? '******${phoneController.text.substring(6)}'
//         : '***';

//     return Column(
//       children: [
//         Text(
//           "Enter Verification Code",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 6),
//         Text(
//           "A 4-digit code has been sent to $obfuscatedPhone",
//           style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 24),

//         Pinput(
//           controller: otpController,
//           length: 4,
//           keyboardType: TextInputType.number,
//           defaultPinTheme: PinTheme(
//             width: 56,
//             height: 56,
//             textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.blue),
//             ),
//           ),
//         ),
//         SizedBox(height: 16),

//         TextButton(
//           onPressed: () {
//             showSnack("OTP resent: $currentOtp", Colors.orange);
//           },
//           child: Text("RESEND OTP", style: TextStyle(color: Colors.blue)),
//         ),
//         SizedBox(height: 24),

//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blue.shade900,
//             padding: EdgeInsets.symmetric(vertical: 14),
//             minimumSize: Size(double.infinity, 50),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(25),
//             ),
//           ),
//           onPressed: handleVerifyOtp,
//           child: Text(
//             "Verify",
//             style: TextStyle(fontSize: 16, color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
// }