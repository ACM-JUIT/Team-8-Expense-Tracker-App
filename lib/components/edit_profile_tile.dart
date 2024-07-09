import 'package:flutter/material.dart';

class EditProfileTile extends StatelessWidget {
  final String hint;
  final String leading;
  final TextEditingController contoller;
  const EditProfileTile({
    super.key,
    required this.hint,
    required this.leading,
    required this.contoller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: contoller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(24),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        hintText: hint,
        prefixIcon: TextButton(
          onPressed: () {},
          child: Text(
            leading,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
