import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget AppbarWidget(Function onClick) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Row(
      children: [
        IconButton(
          onPressed: () {
            onClick();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        Image.asset(AssetImage("asset/ic_logo.png").assetName, package: 'fastpay_merchant',width: 95, height: 25,),
      ],
    ),
  );
}