import 'dart:io';

import 'package:basecode/components/edit_profile_tile.dart';
import 'package:basecode/model/user_model.dart';
import 'package:basecode/features/auth/repository/auth_repository.dart';
import 'package:basecode/features/user_profile/repository/storage_repository.dart';
import 'package:basecode/features/user_profile/repository/user_profile_repository.dart';
import 'package:basecode/utils/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final double budget;
  final double limit;
  const EditProfileScreen({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.budget,
    required this.limit,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController limitController = TextEditingController();
  File? profileFile;

  void saveChanges(
      UserModel user, File? profileFile, BuildContext context) async {
    if (profileFile != null) {
      final res = await context.read<StorageRepository>().storeFile(
            path: 'user/profile',
            id: context.read<AuthRepository>().currentUid,
            file: profileFile,
            context: context,
          );
      context.read<UserProfileRepository>().editProfile(
          user.copyWith(
            name: nameController.text,
            phoneNumber: phoneController.text,
            budget: double.parse(budgetController.text),
            limit: double.parse(limitController.text),
            avatar: res,
          ),
          context);
    } else {
      context.read<UserProfileRepository>().editProfile(
          user.copyWith(
            name: nameController.text,
            phoneNumber: phoneController.text,
            budget: double.parse(budgetController.text),
          ),
          context);
    }
  }

  void selecteProfileImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        profileFile = File(res.files.first.path!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    phoneController.text = widget.phoneNumber;
    budgetController.text = widget.budget.toString();
    limitController.text = widget.limit.toString();
  }

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<AuthRepository>(context).currentUid;
    final user = Provider.of<AuthRepository>(context).getUserData(uid);

    return StreamBuilder(
      stream: user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: const Color(0xFFF0F0F2),
            appBar: AppBar(
              backgroundColor: const Color(0xFFF0F0F2),
              title: Text(
                "Edit profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    saveChanges(snapshot.data!, profileFile, context);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: selecteProfileImage,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(snapshot.data!.avatar),
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    EditProfileTile(
                      leading: "Name",
                      contoller: nameController,
                    ),
                    const SizedBox(height: 20),
                    EditProfileTile(
                      leading: "Phone Number",
                      contoller: phoneController,
                    ),
                    const SizedBox(height: 20),
                    EditProfileTile(
                      leading: "Budget",
                      contoller: budgetController,
                    ),
                    const SizedBox(height: 20),
                    EditProfileTile(
                      leading: "limit",
                      contoller: limitController,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
