import 'package:flutter/material.dart';
Widget CustomLoadingDialog(){
  return Dialog(
    // The background color
    backgroundColor: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          // The loading indicator
          CircularProgressIndicator(),
          SizedBox(
            height: 15,
          ),
          // Some text
          Text('Loading...')
        ],
      ),
    ),
  );
}
void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomLoadingDialog();
    },
  );
}