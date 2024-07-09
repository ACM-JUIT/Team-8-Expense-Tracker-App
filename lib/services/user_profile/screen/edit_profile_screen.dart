import 'package:basecode/components/edit_profile_tile.dart';
import 'package:basecode/services/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<AuthRepository>(context).currentUid;
    final user = Provider.of<AuthRepository>(context).getUserData(uid);

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
            onPressed: () {},
            child: Text("Save",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),),
          )
        ],
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.18,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(snapshot.data!.avatar),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(height: 40),
                    EditProfileTile(
                      hint: snapshot.data!.name,
                      leading: "Name",
                      contoller: nameController,
                    ),
                    const SizedBox(height: 20),
                    EditProfileTile(
                      hint: snapshot.data!.phoneNumber,
                      leading: "Phone Number",
                      contoller: nameController,
                    ),
                    const SizedBox(height: 20),
                    EditProfileTile(
                      hint: snapshot.data!.name,
                      leading: "Budget",
                      contoller: nameController,
                    ),
                  ],
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
