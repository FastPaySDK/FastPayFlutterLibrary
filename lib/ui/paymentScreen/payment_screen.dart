import 'dart:async';

import 'package:fastpay_merchant/models/fastpay_payment_response.dart';
import 'package:fastpay_merchant/models/request/payment_send_otp_request.dart';
import 'package:fastpay_merchant/models/response/payment_initiation_response.dart';
import 'package:fastpay_merchant/ui/otpScreen/otp_verification_screen.dart';
import 'package:fastpay_merchant/ui/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../fastpay_flutter_sdk.dart';
import '../../services/fastpay_sdk_controller.dart';
import '../termsAndConditionScreen/terms_and_condition_screen.dart';
import '../widget/CustomCheckbox.dart';
import '../widget/PhoneNumberTextInputFormatter.dart';
import '../widget/amount_dashboard.dart';

class PaymentScreen extends StatefulWidget {
  PaymentInitiationResponse _paymentInitiationResponse;
  PaymentScreen(this._paymentInitiationResponse, {super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool? isSelected = false;
  String phoneNumber = '';
  String password = '';
  String errorMesg = '';
  bool showQrCode = false;
  int viewType = 1; //1 = payment, 2 = qr, 3 = success,, 4 = error
  bool isPaymentCompleted = false;

  PaymentSendOtpRequest? _paymentSendOtpRequest;
  PaymentInitiationResponse? paymentInitiationResponse;

  bool shouldEnableButton() {
    return phoneNumber.length == 12 && password.isNotEmpty && isSelected == true;
  }

  @override
  void initState() {
    super.initState();
    paymentInitiationResponse = widget._paymentInitiationResponse;
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void _showProgressDialog(){
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        child: Center(
          child: CircularProgressIndicator(color: Color(0xFF2892D7),),
        ),
      ),
    );
    showDialog(
      //prevent outside touch
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(onWillPop: () async => false, child: alert);
      },
    );
  }

  void _callPaymentSendOtpApi(){
    _paymentSendOtpRequest = PaymentSendOtpRequest(
        mobileNumber: '+964${phoneNumber.replaceAll(' ', '')}',
        orderId: FastpayFlutterSdk.instance.fastpayPaymentRequest?.orderID??'',
        password: password,
        token: FastpayFlutterSdk.instance.apiToken
    );
    _showProgressDialog();
    FastpaySdkController.instance.sendOtp(
        _paymentSendOtpRequest!
        ,(response) async{
      Navigator.pop(context);
      var result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => OtpVerificationScreen(response)));
      debugPrint('PRINT_STACK_TRACE.....................: $result');
      FastpayFlutterSdk.instance.context = context;
      if(result.toString().isEmpty){
        Navigator.pop(context);
        errorMesg = 'Invalid Otp';
        setState(() {
          viewType = 4;
        });
      }else
        _callPaywithOtp(result.toString());
    },
        onFailed: (code,message){
          Navigator.pop(context);
          errorMesg = message;
          setState(() {
            viewType = 4;
          });
        }
    );
  }

  void _callPaywithOtp(String otpCode) {
    _paymentSendOtpRequest?.otp = otpCode;
    _showProgressDialog();
    FastpaySdkController.instance.payWithOtp(
        _paymentSendOtpRequest!
        ,(response) async{
      Navigator.pop(context);
      setState(() {
        viewType = 3;
      });
      isPaymentCompleted = true;
      Future.delayed(Duration(seconds: 5),(){
        var fastpayResult = FastpayPaymentResponse("success", response.summary?.invoiceId, _paymentSendOtpRequest?.orderId??'', FastpayFlutterSdk.instance.fastpayPaymentRequest?.amount, "IQD", response.summary?.recipient?.name, response.summary?.recipient?.mobileNumber, DateTime.now().microsecondsSinceEpoch.toString());
        FastpayFlutterSdk.instance.dispose(fastpayResult);
        FastpayFlutterSdk.instance.fastpayPaymentRequest?.callback?.call(SDKStatus.SUCCESS,'Payment success',result:fastpayResult);
      });
    },
        onFailed: (code,message){
          Navigator.pop(context);
          debugPrint('PRINT_STACK_TRACE.....................: $message');
          var result = FastpayPaymentResponse("failed", null, FastpayFlutterSdk.instance.fastpayPaymentRequest?.orderID, FastpayFlutterSdk.instance.fastpayPaymentRequest?.amount, "IQD",FastpayFlutterSdk.instance.paymentInitiationResponse?.storeName, null, DateTime.now().microsecondsSinceEpoch.toString());
          FastpayFlutterSdk.instance.fastpayPaymentRequest?.callback?.call(SDKStatus.FAILED,message,result:result);
          setState(() {
            errorMesg = message;
            viewType = 4;
          });
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return PopScope(
      onPopInvoked: (value){
        if(!isPaymentCompleted) {
          FastpayFlutterSdk.instance.fastpayPaymentRequest?.callback?.call(SDKStatus.CANCEL,'Fastpay payment canceled');
        }
      },
      child: SafeArea(child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              if(viewType != 4)
                Container(
                  height: MediaQuery.of(context).size.height/4,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xFFECF2F5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          paymentInitiationResponse?.storeLogo != null?
                          Image.network(
                            paymentInitiationResponse?.storeLogo,
                            width: 128, height: 55,
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ):Image.asset(const AssetImage("asset/ic_logo.png").assetName, package: 'fastpay_merchant',width: 128, height: 55,),
                          const SizedBox(width: 16,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(paymentInitiationResponse?.storeName??'', style: getTextStyle( fontColor: Color(0xFF43466E), textSize: 16, fontWeight: FontWeight.normal),),
                                Text(
                                  'Order ID: ${paymentInitiationResponse?.orderId??''}', style: getTextStyle(fontColor: Color(0xFF43466E), textSize: 12, fontWeight: FontWeight.normal),
                                  maxLines: 2, // Limit to 2 lines
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      CustomPaint(
                        painter: DottedBorderPainter(),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                          child: Text('${paymentInitiationResponse?.billAmount??''} ${paymentInitiationResponse?.currency??''}', style: getTextStyle(fontColor: Color(0xFF090909), textSize: 16, fontWeight: FontWeight.normal),),
                        ),
                      )
                    ],
                  ),
                ),
              _viewCondition()
            ],
          ),
        ),
      )),
    );
  }

  Widget _viewCondition(){
    switch(viewType){
      case 1:
        return paymentViewWidget();
      case 2:
        return QRViewWidget();
      case 3:
        return paymentSuccessWidget();
      case 4:
        return paymentFailedWidget();
    }
    return Container();
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
              Image.asset(AssetImage("asset/ic_logo.png").assetName, package: 'fastpay_merchant',width: 80, height: 80,),
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
              _callPaymentSendOtpApi();
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OtpVerificationScreen()),
              );*/
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
                viewType = 2;
              });
            },
            child: Column(
              children: [
                Center(child: Image.asset(AssetImage("asset/ic_scan.png").assetName, package: 'fastpay_merchant',width: 50, height: 47,)),
                SizedBox(height: 10,),
                Center(child: Text('Generate QR', style: getTextStyle(fontColor: Color(0xFF2892D7), textSize: 14, fontWeight: FontWeight.w500),)),            ],
            ),
          ),
          SizedBox(height: 50,),

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
              Image.asset(AssetImage("asset/ic_logo.png").assetName, package: 'fastpay_merchant',width: 80, height: 80,),
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
            child: Image.network(
              'https://api.qrserver.com/v1/create-qr-code/?size=300x350&data=${paymentInitiationResponse?.qrToken}',
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
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
              child: InkWell(
                  onTap: (){
                    setState(() {
                      viewType = 1;
                    });
                  },
                  child: Center(child: Text('Use Login Credential', style: getTextStyle(fontColor: Color(0xFF2892D7), textSize: 14, fontWeight: FontWeight.normal),)))
          ),
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
          const SizedBox(height: 20,),
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
            child: Image.asset(AssetImage("asset/success.gif").assetName, package: 'fastpay_merchant',width: 80, height: 80,),
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
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetImage("asset/ic_error.png").assetName, package: 'fastpay_merchant',width: 123, height: 101,),
          SizedBox(height: 32,),
          Text(errorMesg,textAlign: TextAlign.center ,style: getTextStyle(fontColor: Color(0xFF636696), textSize: 18, fontWeight: FontWeight.w500),),
          SizedBox(height: 12,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1218),
                border: Border.all(
                  color: const Color(0xFF2892D7),
                  width: 2,
                )
            ),
            child: InkWell(
                onTap: (){
                  setState(() {
                    viewType = 1;
                  });
                },
                child: Text('RETRY', style: getTextStyle(fontColor: Color(0xFF2892D7), textSize: 12, fontWeight: FontWeight.bold),)
            ),
          ),
        ],
      ),
    );
  }
}
