import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getTextStyle({double textSize = 12,FontStyle fontStyle = FontStyle.normal,FontWeight fontWeight = FontWeight.w600,Color fontColor = Colors.black}){
  return GoogleFonts.montserrat(
      fontSize: textSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      color: fontColor);
}
