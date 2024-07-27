import 'package:fastpay_merchant/ui/paymentScreen/payment_screen.dart';
import 'package:fastpay_merchant/ui/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../fastpay_flutter_sdk.dart';
import '../widget/CustomOtpView.dart';
import '../widget/app_bar.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String message;
  const OtpVerificationScreen(this.message,{super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Add listener to each controller to check for changes
    _fieldOne.addListener(_checkAllFieldsFilled);
    _fieldTwo.addListener(_checkAllFieldsFilled);
    _fieldThree.addListener(_checkAllFieldsFilled);
    _fieldFour.addListener(_checkAllFieldsFilled);
    _fieldFive.addListener(_checkAllFieldsFilled);
    _fieldSix.addListener(_checkAllFieldsFilled);
  }

  // Function to check if all fields are filled
  void _checkAllFieldsFilled() {
    if (allFieldsFilled()) {
      Navigator.pop(context, _getOtp());
    }
  }

  String _getOtp(){
    return '${_fieldOne.text}${_fieldTwo.text}${_fieldThree.text}${_fieldFour.text}${_fieldFive.text}${_fieldSix.text}';
  }

  bool allFieldsFilled() {
    return _fieldOne.text.isNotEmpty &&
        _fieldTwo.text.isNotEmpty &&
        _fieldThree.text.isNotEmpty &&
        _fieldFour.text.isNotEmpty &&
        _fieldFive.text.isNotEmpty &&
        _fieldSix.text.isNotEmpty;
  }

  @override
  void dispose() {
    // Clean up controllers
    _fieldOne.dispose();
    _fieldTwo.dispose();
    _fieldThree.dispose();
    _fieldFour.dispose();
    _fieldFive.dispose();
    _fieldSix.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AppbarWidget((){
              Navigator.pop(context);
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Confirm Transaction via Email OTP', style: getTextStyle(fontColor: Color(0xFF000000), textSize: 18, fontWeight: FontWeight.w500),),
                  SizedBox(height: 10,),
                  Text(widget.message, style: getTextStyle(fontColor: Color(0xFF000000), textSize: 14, fontWeight: FontWeight.normal),),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomOtpView(otpController: _fieldOne,autoFocus : true,isFirst: true,),
                      CustomOtpView(otpController:_fieldTwo, autoFocus : false),
                      CustomOtpView(otpController:_fieldThree,autoFocus : false),
                      CustomOtpView(otpController:_fieldFour, autoFocus : false),
                      CustomOtpView(otpController:_fieldFive, autoFocus : false),
                      CustomOtpView(otpController:_fieldSix, autoFocus: false,isLast:true),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
