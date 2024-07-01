import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('LEZZO', style: TextStyle(color: Color(0xFF43466E), fontSize: 16, fontWeight: FontWeight.normal),),
                          Text('Order ID: 1234', style: TextStyle(color: Color(0xFF43466E), fontSize: 12, fontWeight: FontWeight.normal))
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  CustomPaint(
                    painter: DottedBorderPainter(),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                      child: Text('300008888 IQD', style: TextStyle(color: Color(0xFF090909), fontSize: 16, fontWeight: FontWeight.normal),),
                    ),
                  )
                ],
              ),
            ),
            QRViewWidget()
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
              Text('Pay via', style: TextStyle(color: Color(0xFF000000), fontSize: 12, fontWeight: FontWeight.normal),),
              SizedBox(width: 10,),
              Image.asset(AssetImage("assets/ic_logo.png").assetName, package: 'fastpay_flutter_sdk',width: 80, height: 80,),
            ],),
          Text('Mobile Number', style: TextStyle(color: Color(0xFF000000), fontSize: 12, fontWeight: FontWeight.normal),),
          SizedBox(height: 8,),
          TextField(
            maxLength: 12,
            minLines: 1,
            cursorColor: Color(0xFF000000),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              PhoneNumberTextInputFormatter()
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterText: '',
              prefix: const Text('+964 - ',style: TextStyle(color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.normal)),
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
          Text('Password', style: TextStyle(color: Color(0xFF000000), fontSize: 12, fontWeight: FontWeight.normal),),
          SizedBox(height: 8,),
          TextField(
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
                    TextSpan(text: 'I accept the ', style: TextStyle(color: Color(0xFF000000), fontSize: 12, fontWeight: FontWeight.normal)),
                    TextSpan(
                      text: 'terms and conditions',
                      style: TextStyle(
                        color: Color(0xFF2892D7),
                        decoration: TextDecoration.underline,
                          fontSize: 12, fontWeight: FontWeight.normal
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = (){},
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 35,),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color(0xFF2892D7),
            ),
            child: Center(child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 20),
              child: Text('Proceed to pay'.toUpperCase(), style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12, fontWeight: FontWeight.bold),),
            )),
          ),
          SizedBox(height: 20,),
          Center(child: Text('Or', style: TextStyle(color: Color(0xFF000000), fontSize: 13, fontWeight: FontWeight.normal),)),
          SizedBox(height: 20,),
          Center(child: Image.asset(AssetImage("assets/ic_scan.png").assetName, package: 'fastpay_flutter_sdk',width: 50, height: 47,)),
          SizedBox(height: 10,),
          Center(child: Text('Generate QR', style: TextStyle(color: Color(0xFF2892D7), fontSize: 14, fontWeight: FontWeight.normal),)),
          SizedBox(height: 50,),
          Text('Back', style: TextStyle(color: Color(0xFF2892D7), fontSize: 14, fontWeight: FontWeight.normal)),
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
              Text('Pay via', style: TextStyle(color: Color(0xFF000000), fontSize: 12, fontWeight: FontWeight.normal),),
              SizedBox(width: 10,),
              Image.asset(AssetImage("assets/ic_logo.png").assetName, package: 'fastpay_flutter_sdk',width: 80, height: 80,),
            ],),
          Center(child: Text('Use another mobile or\n let your friends & family help', style: TextStyle(color: Color(0xFF000000), fontSize: 12, fontWeight: FontWeight.normal),textAlign: TextAlign.center,)),
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
          Center(child: Text('Or', style: TextStyle(color: Color(0xFF000000), fontSize: 13, fontWeight: FontWeight.normal),)),
          SizedBox(height: 20,),
          Center(child: Text('Use Login Credential', style: TextStyle(color: Color(0xFF2892D7), fontSize: 14, fontWeight: FontWeight.normal),)),
          SizedBox(height: 50,),
        ],
      ),
    );
  }
}
