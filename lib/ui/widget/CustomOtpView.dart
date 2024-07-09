import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomOtpView extends StatefulWidget {
  final TextEditingController otpController;
  final bool autoFocus;
  final bool isFirst;
  final bool isLast;

  CustomOtpView(
      {required this.otpController,
        required this.autoFocus,
        this.isFirst = false,
        this.isLast = false});

  @override
  _CustomOtpViewState createState() => _CustomOtpViewState();
}

class _CustomOtpViewState extends State<CustomOtpView> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width / 7.5,
      child: Center(
        child: TextFormField(
          controller: widget.otpController,
          focusNode: _focusNode,
          autofocus: widget.autoFocus,
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          obscureText: true,
          obscuringCharacter: '⚫',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xFFDEF1FA),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.5
              ),
            ),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
          onChanged: (value) {
            if (value.length == 1) {
              if (!widget.isLast) {
                FocusScope.of(context).nextFocus();
              } else {
                FocusScope.of(context).unfocus();
              }
            } else if (value.isEmpty) {
              if (!widget.isFirst) {
                FocusScope.of(context).previousFocus();
              } else {
                FocusScope.of(context).unfocus();
              }
            }
          },
        ),
      ),
    );
  }
}
