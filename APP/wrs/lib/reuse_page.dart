import 'package:flutter/material.dart';


TextField reuseableTextField(String name, IconData iconData, bool isPassword,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    
    enableSuggestions: !isPassword, // Enables or disables text suggestions
    autocorrect: !isPassword,
    
    decoration: InputDecoration(
      prefixIcon: Icon(
        
        iconData,
        color: Colors.black,
      ),
      labelText: name,
      border: OutlineInputBorder(
        
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 0, style: BorderStyle.solid)),
    ),
  );
}


