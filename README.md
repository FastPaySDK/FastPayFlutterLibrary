



# FastPay Flutter SDK
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)    
[![Pub Points](https://img.shields.io/pub/points/fastpay_merchant)](https://pub.dev/packages/fastpay_merchant/score) [![pub package](https://img.shields.io/pub/v/fastpay_merchant.svg)](https://pub.dev/packages/fastpay_merchant)

## FastPay Developers Arena

Accept payments with FastPay's APIs. Our simple and easy-to-integrate APIs allow for less effort in processing payments. This is an official support channel, but our APIs support both Android and iOS.

### SDK flow
![alt text](https://raw.githubusercontent.com/Fast-Solution-Inc/FastPay-Android-SDK/main/flow.png)

### Screenshots

| ![Screenshot 1](https://raw.githubusercontent.com/Fast-Solution-Inc/FastPay-Android-SDK/main/1.jpg?raw=true) | ![Screenshot 2](https://raw.githubusercontent.com/Fast-Solution-Inc/FastPay-Android-SDK/main/2.jpg?raw=true) | ![Screenshot 3](https://raw.githubusercontent.com/Fast-Solution-Inc/FastPay-Android-SDK/main/3.jpg?raw=true) | | :---: | :---: | :---: |
## Quick Glance

- This plugin is official. [FastPay Developers Portal](https://developer.fast-pay.iq/).
- You need to contact FastPay to get a storeID and Password.

## Installation

```yaml dependencies:    
fastpay_merchant: ^1.2.0
#To handle callbacks (Redirection) from fastpay wallet application.
app_links: ^4.0.0  
```   
> :warning: **iOS only supports real device you can't test it on simulator because FastPay SDK not support simulator**

___   
### Initiate FastPaySDK

- __Store ID__ : Merchant’s Store Id to initiate transaction
- __Store Password__ : Merchant’s Store password to initiate transaction
- __Order ID__ : Order ID/Bill number for the transaction, this value should be unique in every transaction
- __Amount__ : Payable amount in the transaction ex: “1000”
- __IOS callback URI__ : IOS callback URI for getting payment info when user pay with Fastpay application.
- **Callback( Sdk status, message, FastpayResult):** There are four sdk status (e.g. *FastpayRequest.SDKStatus.INIT*) , status message show scurrent status of the SDK and the result is fastpay SDK payment result.

```dart     
  enum SDKStatus{    
	INIT,
	PAYMENT_WITH_FASTPAY_SDK,
	PAYMENT_WITH_FASTPAY_APP, 
	CANCEL, 
	SUCCESS, 
	FAILED
}   
```   
## Examples
1. Initiate payment in init method of your flutter widget:
```dart 
import 'package:fastpay_merchant/fastpay_flutter_sdk.dart'; 
import 'package:fastpay_merchant/models/fastpay_payment_request.dart';    
 /* * * Add this code on init method */ 
FastpayFlutterSdk.instance.fastpayPaymentRequest = FastpayPaymentRequest(
      "******STORE ID*****",       // (Required) Replace with your actual store ID
      "******STORE PASSWORD****",   // (Required) Replace with your actual store password
      "450",                      // AMOUNT
      "YOUR ORDER ID",             // Order ID (replace with your actual order ID)
      "CallBack_URI_Ios",           //IOS callback URI e.g appfpclientFastpayFlutterSdk
      false,                      // isProduction (set to true for production environment)
      (status, message, result) {  // Callback handler
        debugPrint('MESSAGE: $message');
        debugPrint('RESULT: ${result.toString()}');
      },
    );
``` 
2. Start the journey by navigating the app to the SDK:
```dart 
/* * * Use this code to navigate to flutter SDK. Set the context same as the Navigator is using. If you are using the Getx navigation try to use "Get.context" */ 
FastpayFlutterSdk.instance.context = context; 
Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SdkInitializeScreen()));   
```   

## SDK callback Uri (IOS only, ___OPTIONAL___)
> **Warning**
> This will reinitiate the whole application with applinks data from the top page of the navigation queue. Thats means, after payment from the fastpay app, it will redirect to your app with the data.
```dart
//Using app_links
import 'package:app_links/app_links.dart';
Future<void> _handleIncomingIntent() async {
    final _appLinks = AppLinks();
    final appLink = await _appLinks.getInitialAppLink();
      if (appLink != null) {
        var uri = Uri.parse(appLink.toString());
        debugPrint(' here you can redirect from url as per your need ');
      }
      _linkSubscription = _appLinks.uriLinkStream.listen((uriValue) {
        debugPrint('Redirect URI:.................$uriValue');
      },onError: (err){
        debugPrint('====>>> error : $err');
      },onDone: () {
        _linkSubscription?.cancel();
      },);
  }
```

#### IOS setup
Add the callback uri to the manifest file as shown below.

- Create URI Create a URI with a unique name (our suggestion is to provide your app name with prefix text "appfpclientFastpayFlutterSdk", for example, if your app name is "FaceLook", your URI should be appfpclientFaceLook)
- Add URI to your `info.plist` Now add this URI to your app info.plist file
```yaml
  <key>CFBundleURLTypes</key>
  <array>
  <dict>
  <key>CFBundleURLSchemes</key>
  <array>
  < string>appfpclientFastpayFlutterSdk</string> //Your given URI from SDK initialization request
  </array>
  </dict>
  </array>
```

### Callback Uri via app deeplinks results.

```java
callback URI pattern (SUCCESS): appfpclientFastpayFlutterSdk/further/paths?status=success&transaction_id=XXXX&order_id=XXXX&amount=XXX&currency=XXX&mobile_number=XXXXXX&time=XXXX&name=XXXX
callback URI pattern (FAILED): appfpclientFastpayFlutterSdk/further/paths?status=failed&order_id=XXXXX
```

## Payment Result
__FastpayPaymentResponse__ class contains these params:
- __isSuccess__ : return true for a successful transaction else false.
- __errorMessage__ : if transaction failed return failed result
- __transactionStatus__ : Payment status weather it is success / failed.
- __transactionId__ : If payment is successful then a transaction id will be available.
- __orderId__ : Unique Order ID/Bill number for the transaction which was passed at initiation time.
- __paymentAmount__ : Payment amount for the transaction. “1000”
- __paymentCurrency__ : Payment currency for the transaction. (IQD)
- __payeeName__ : Payee name for a successful transaction.
- __payeeMobileNumber__ :  Number: Payee name for a successful transaction.
- __paymentTime__ : Payment occurrence time as the timestamp.