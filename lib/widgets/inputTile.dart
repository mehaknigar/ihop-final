import 'package:flutter/material.dart';

class InputTile extends StatelessWidget {
  final String labelName, hintText;
  final TextEditingController controller;

  InputTile(this.labelName, this.hintText, this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Text(
              labelName,
              style: TextStyle(color: Colors.black87, fontSize: 20.0),
            ),
          ),
          TextFormField(
            controller: controller,
            validator: (String value) {
              if (value.isEmpty) {
                return "Enter $labelName";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(),
              ),
            ),
            keyboardType: TextInputType.text,
            style: TextStyle(fontFamily: "Poppins", fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
