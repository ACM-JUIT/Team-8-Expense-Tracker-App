import 'package:basecode/components/profile_tile.dart';
import 'package:basecode/features/auth/repository/auth_repository.dart';
import 'package:basecode/features/user_profile/screen/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<AuthRepository>(context).currentUid;
    final user = Provider.of<AuthRepository>(context).getUserData(uid);
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F2),
      body: StreamBuilder(
        stream: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(snapshot.data!.avatar),
                            ),
                            shape: BoxShape.circle),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        snapshot.data!.name,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        snapshot.data!.email,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        snapshot.data!.phoneNumber,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Divider(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 20),
                      UserProfileTile(
                        title: "UserProfile",
                        subTitle: "Change profile image, name, phone number,etc.",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                name: snapshot.data!.name,
                                phoneNumber: snapshot.data!.phoneNumber,
                                budget: snapshot.data!.budget,
                                limit: snapshot.data!.limit,
                              ),
                            ),
                          );
                        },
                        icon: Icons.account_circle,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Divider(
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                      const SizedBox(height: 10),
                      UserProfileTile(
                        title: "LogOut",
                        subTitle: "Log out, your data wil persist.",
                        onTap: () {
                          context.read<AuthRepository>().signOut(context);
                        },
                        icon: Icons.logout,
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
