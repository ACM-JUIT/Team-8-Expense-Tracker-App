import 'package:flutter/material.dart';

class UserProfileTile extends StatelessWidget {
  final String title;
  final String? subTitle;
  final void Function()? onTap;
  final IconData icon;
  const UserProfileTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      tileColor: Colors.white,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(icon),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w800),
      ),
      subtitle: Text(
        subTitle.toString(),
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}
