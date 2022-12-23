import 'package:flutter/material.dart';

class CustomEditTextForm extends StatefulWidget {
  const CustomEditTextForm(
      {Key? key,
      required this.label,
      required this.hint,
      required this.isSecret,
      required this.onSaved})
      : super(key: key);
  final String label;
  final String hint;
  final bool isSecret;
  final FormFieldSetter onSaved;

  @override
  State<CustomEditTextForm> createState() => _CustomEditTextFormState();
}

class _CustomEditTextFormState extends State<CustomEditTextForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${widget.label}",
              style: TextStyle(
                fontFamily: "EchoDream",
                fontWeight: FontWeight.w600,
                fontSize: 16,
              )),
          SizedBox(height: 10),
          TextFormField(
            obscureText: widget.isSecret,
            decoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff5f66f2), width: 2),
                borderRadius: BorderRadius.circular(25),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff5f66f2), width: 2),
                borderRadius: BorderRadius.circular(25),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff5f66f2), width: 2),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff5f66f2), width: 2),
                borderRadius: BorderRadius.circular(25),
              ),
              hintText: "${widget.hint}",
              hintStyle: TextStyle(
                  color: Color(0xffbdbdbd),
                  fontSize: 15,
                  fontFamily: "EchoDream",
                  fontWeight: FontWeight.w400),
            ),
            onSaved: widget.onSaved,
          ),
        ],
      ),
    );
  }
}
