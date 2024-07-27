import 'package:flutter/material.dart';

class EditProfileTile extends StatelessWidget {
  final String leading;
  final TextEditingController controller;
  const EditProfileTile({
    super.key,
    required this.leading,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(24),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
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
