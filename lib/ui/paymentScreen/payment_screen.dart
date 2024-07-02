import 'package:fastpay_flutter_sdk/ui/otpScreen/otp_verification_screen.dart';
import 'package:fastpay_flutter_sdk/ui/widget/text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../termsAndConditionScreen/terms_and_condition_screen.dart';
import '../widget/CustomCheckbox.dart';
import '../widget/PhoneNumberTextInputFormatter.dart';
import '../widget/amount_dashboard.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool? isSelected = false;
  String phoneNumber = '';
  String password = '';
  bool showQrCode = false;

  bool shouldEnableButton() {
    return phoneNumber.length == 12 && password.isNotEmpty && isSelected == true;
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/4,
              color: const Color(0xFFECF2F5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AssetImage("assets/ic_logo.png").assetName, package: 'fastpay_flutter_sdk',width: 128, height: 55,),
                      const SizedBox(width: 16,),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('LEZZO', style: getTextStyle( fontColor: Color(0xFF43466E), textSize: 16, fontWeight: FontWeight.normal),),
                          Text('Order ID: 1234', style: getTextStyle(fontColor: Color(0xFF43466E), textSize: 12, fontWeight: FontWeight.normal))
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  CustomPaint(
                    painter: DottedBorderPainter(),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                      child: Text('300008888 IQD', style: getTextStyle(fontColor: Color(0xFF090909), textSize: 16, fontWeight: FontWeight.normal),),
                    ),
                  )
                ],
              ),
            ),
            (showQrCode)? QRViewWidget() : paymentViewWidget()
          ],
        ),
      ),
    ));
  }

  Widget paymentViewWidget() {
    return Container(
      padding:const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Pay via', style: getTextStyle(fontColor: Color(0xFF000000), textSize: 12, fontWeight: FontWeight.w400),),
              SizedBox(width: 10,),
              Image.asset(AssetImage("assets/ic_logo.png").assetName, package: 'fastpay_flutter_sdk',width: 80, height: 80,),
            ],),
          Text('Mobile Number', style: getTextStyle(fontColor: Color(0xFF000000), textSize: 12, fontWeight: FontWeight.w500),),
          SizedBox(height: 8,),
          TextField(
            onChanged: (value) {
              setState(() {
                phoneNumber = value;
              });
            },
            maxLength: 12,
            minLines: 1,
            cursorColor: Color(0xFF000000),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              PhoneNumberTextInputFormatter(),
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterText: '',
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 20), // Adjust padding to fit design
                child: Text(
                  '+964 - ',
                  style: getTextStyle(fontColor: Color(0xFF000000), textSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(
                  color: Color(0xFFC4C4C4),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(
                  color: Color(0xFF2892D7),
                  width: 1,
                ),
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 20), // Ensure padding does not overlap with prefix
            ),
          )
          ,
          SizedBox(height: 20,),
          Text('Password', style: getTextStyle(fontColor: Color(0xFF000000), textSize: 12, fontWeight: FontWeight.w500),),
          SizedBox(height: 8,),
          TextField(
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            obscureText: true,
            minLines: 1,
            cursorColor: Color(0xFF000000),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                // Rounded border radius
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(
                    color: Color(0xFFC4C4C4),
                    width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(
                    color: Color(0xFF2892D7), width: 1),
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 20),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              CustomCheckbox(
                value: isSelected!,
                onChanged: (value) {
                  setState(() {
                    isSelected = value!;
                  });
                },
              ),
              SizedBox(width: 10,),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(text: 'I accept the ', style: getTextStyle(fontColor: Color(0xFF000000), textSize: 12, fontWeight: FontWeight.w500)),
                    TextSpan(
                      text: 'terms and conditions',
                      style: TextStyle(
                        color: Color(0xFF2892D7),
                        decoration: TextDecoration.underline,
                          fontSize: 12, fontWeight: FontWeight.w500
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TermsAndConditionScreen()),
                          );
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 35,),
          InkWell(
            onTap: shouldEnableButton() ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OtpVerificationScreen()),
              );
            } : null,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: shouldEnableButton() ? Color(0xFF2892D7) : Colors.grey,
              ),
              child: Center(child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 20),
                child: Text('Proceed to pay'.toUpperCase(), style: getTextStyle(fontColor: Color(0xFFFFFFFF), textSize: 12, fontWeight: FontWeight.bold),),
              )),
            ),
          ),
          SizedBox(height: 20,),
          Center(child: Text('Or', style: getTextStyle(fontColor: Color(0xFF000000), textSize: 13, fontWeight: FontWeight.normal),)),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              setState(() {
                showQrCode = true;
              });
            },
            child: Column(
              children: [
                Center(child: Image.asset(AssetImage("assets/ic_scan.png").assetName, package: 'fastpay_flutter_sdk',width: 50, height: 47,)),
                SizedBox(height: 10,),
                Center(child: Text('Generate QR', style: getTextStyle(fontColor: Color(0xFF2892D7), textSize: 14, fontWeight: FontWeight.w500),)),            ],
            ),
          ),
          SizedBox(height: 50,),
          Text('Back', style: getTextStyle(fontColor: Color(0xFF2892D7), textSize: 14, fontWeight: FontWeight.normal)),
          SizedBox(height: 30,),
        ],
      ),
    );
  }

  Widget QRViewWidget() {
    return Container(
      padding:const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text('Pay via', style: getTextStyle(fontColor: Color(0xFF000000), textSize: 12, fontWeight: FontWeight.normal),),
              SizedBox(width: 10,),
              Image.asset(AssetImage("assets/ic_logo.png").assetName, package: 'fastpay_flutter_sdk',width: 80, height: 80,),
            ],),
          Center(child: Text('Use another mobile or\n let your friends & family help', style: getTextStyle(fontColor: Color(0xFF000000), textSize: 12, fontWeight: FontWeight.w500),textAlign: TextAlign.center,)),
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width/1.5,
            height: MediaQuery.of(context).size.height/3.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color(0xFFE9EEF2),
                width: 1,
              )
            ),
          ),
          SizedBox(height: 20,),
          Center(child: Text('Or', style: getTextStyle(fontColor: Color(0xFF000000), textSize: 13, fontWeight: FontWeight.normal),)),
          SizedBox(height: 20,),
          InkWell(
              onTap: (){
                setState(() {
                  showQrCode = false;
                });
              },
              child: Center(child: Text('Use Login Credential', style: getTextStyle(fontColor: Color(0xFF2892D7), textSize: 14, fontWeight: FontWeight.normal),))),
          SizedBox(height: 50,),
        ],
      ),
    );
  }

  Widget paymentSuccessWidget() {
    return Container(
      padding:const EdgeInsets.only(top: 60, left: 24, right: 24),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Payment successful', style: getTextStyle(fontColor: Color(0xFF636696), textSize: 20, fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width/1.5,
            height: MediaQuery.of(context).size.height/3.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color(0xFFE9EEF2),
                width: 1,
              )
            ),
          ),
          SizedBox(height: 20,),
          Center(child: Text('Please wait while we take you back.', style: getTextStyle(fontColor: Color(0xFF636696), textSize: 16, fontWeight: FontWeight.normal),)),
        ],
      ),
    );
  }

  Widget paymentFailedWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetImage("assets/ic_error.png").assetName, package: 'fastpay_flutter_sdk',width: 123, height: 101,),
          SizedBox(height: 32,),
          Text('Something went wrong!', style: getTextStyle(fontColor: Color(0xFF636696), textSize: 18, fontWeight: FontWeight.w500),),
          SizedBox(height: 12,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1218),
              border: Border.all(
                color: Color(0xFF2892D7),
                width: 2,
              )
            ),
            child: Text('RETRY', style: getTextStyle(fontColor: Color(0xFF2892D7), textSize: 12, fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}
