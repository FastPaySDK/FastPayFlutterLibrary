
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../fastpay_flutter_sdk.dart';
import '../widget/app_bar.dart';
import '../widget/text_style.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    FastpayFlutterSdk.instance.isTermsAndConditionPage = true;
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    FastpayFlutterSdk.instance.isTermsAndConditionPage = false;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return SafeArea(child: Scaffold(
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
                Text('Terms and Conditions', style: getTextStyle(fontColor: Color(0xFF636696), textSize: 20, fontWeight: FontWeight.w500),),
                SizedBox(height: 16,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 26),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color(0xFFEFF5F8),
                  ),
                  child: ScrollbarTheme(
                    data: ScrollbarThemeData(
                      radius: Radius.circular(6),
                      thickness: MaterialStateProperty.all(10.0),
                      thumbColor: MaterialStateProperty.all(Color(0xFFED0F69)),
                    ),
                    child: Scrollbar(
                        controller: controller,
                        thumbVisibility: true,
                        trackVisibility: true,
                        child: SingleChildScrollView(
                          child: Text('Here are a few examples:\n\n The Intellectual Property disclosure will inform users that the contents, logo and other visual media you created is your property and is protected by copyright laws.\n\n A Termination clause will inform that users’ accounts on your website and mobile app or users’ access to your website and mobile (if users can’t have an account with you) can be terminated in case of abuses or at your sole discretion. A Governing Law will inform users which laws govern the agreement. This should the country in which your company is headquartered or the country from which you operate your website and mobile app. A Links To Other Web Sites clause will inform users that you are not responsible for any third party websites that you link to. This kind of clause will generally inform users that they are responsible for reading and agreeing (or disagreeing) with the Terms and Conditions or Privacy Policies of these third parties.\n\n If your website or mobile app allows users to create content and make that content public to other users, a Content section will inform users that they own the rights to the content they have created. The “Content” clause usually mentions that users must give you (the website or mobile app developer) a license so that you can share this content on your website/mobile app and to make it available to other users.\n\n Because the content created by users is public to other users, a DMCA notice clause (or Copyright Infringement ) section is helpful to inform users and copyright authors that, if any content is found to be a copyright infringement, you will respond to any DMCA takedown notices received and you will take down the content. A Limit What Users Can Do clause can inform users that by agreeing to use your service, they’re also agreeing to not do certain things. This can be part of a very long and thorough list in your Terms and Conditions agreements so as to encompass the most amount of negative uses. Here’s how 500px lists its prohibited activities:',
                            style: getTextStyle(fontColor: Color(0xFF5F6AA0), textSize: 11, fontWeight: FontWeight.normal),),
                        )

                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
