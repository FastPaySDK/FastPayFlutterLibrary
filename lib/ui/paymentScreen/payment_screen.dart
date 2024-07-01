import 'package:flutter/material.dart';

import '../widget/amount_dashboard.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
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
                    Container(
                      color: Colors.brown,
                      width: 128,
                      height: 55,
                    ),
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
          )
        ],
      ),
    ));
  }
}
