import 'dart:io';

import 'package:basecode/components/edit_profile_tile.dart';
import 'package:basecode/model/user_model.dart';
import 'package:basecode/features/auth/repository/auth_repository.dart';
import 'package:basecode/features/user_profile/repository/storage_repository.dart';
import 'package:basecode/features/user_profile/repository/user_profile_repository.dart';
import 'package:basecode/utils/pick_image.dart';
import 'package:elegant_notification/elegant_notification.dart';
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

  Future<void> saveChanges(
      UserModel user, File? profileFile, BuildContext context) async {
    try {
      if (profileFile != null) {
        final res = await context.read<StorageRepository>().storeFile(
              path: 'user/profile',
              id: context.read<AuthRepository>().currentUid,
              file: profileFile,
              context: context,
            );
        await context.read<UserProfileRepository>().editProfile(
            user.copyWith(
              name: nameController.text,
              phoneNumber: phoneController.text,
              budget: double.parse(budgetController.text),
              limit: double.parse(limitController.text),
              avatar: res,
            ),
            context);
      } else {
        ElegantNotification.info(
          description: Text("Profile Updating..."),
        );
        await context.read<UserProfileRepository>().editProfile(
            user.copyWith(
              name: nameController.text,
              phoneNumber: phoneController.text,
              budget: double.parse(budgetController.text),
              limit: double.parse(limitController.text),
            ),
            context);
      }
      ElegantNotification.success(
        description: Text("Profile updated"),
      );

      await Future.delayed(Duration(seconds: 2));

      Navigator.of(context).pop();
    } catch (e) {
      ElegantNotification.error(
        description: Text("Failed to update profile: $e"),
      );
    }
  }

  void selectProfileImage() async {
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
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    budgetController.dispose();
    limitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<AuthRepository>(context).currentUid;
    final userStream = Provider.of<AuthRepository>(context).getUserData(uid);

    return StreamBuilder<UserModel>(
      stream: userStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data!;
          return Scaffold(
            backgroundColor: const Color(0xFFF0F0F2),
            appBar: AppBar(
              backgroundColor: const Color(0xFFF0F0F2),
              title: const Text(
                "Edit profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    saveChanges(user, profileFile, context);
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
                      onTap: selectProfileImage,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: profileFile != null
                                ? FileImage(profileFile!)
                                : NetworkImage(user.avatar) as ImageProvider,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    EditProfileTile(
                      leading: "Name",
                      controller: nameController,
                    ),
                    const SizedBox(height: 20),
                    EditProfileTile(
                      leading: "Phone Number",
                      controller: phoneController,
                    ),
                    const SizedBox(height: 20),
                    EditProfileTile(
                      leading: "Budget",
                      controller: budgetController,
                    ),
                    const SizedBox(height: 20),
                    EditProfileTile(
                      leading: "Limit",
                      controller: limitController,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
