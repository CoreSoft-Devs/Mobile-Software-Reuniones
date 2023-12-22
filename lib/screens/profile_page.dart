import 'package:flutter/material.dart';
import '../widgets/profile_info.dart';

class ProfilePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String role;

  ProfilePage({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double coverHeight = 280;
  double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    coverHeight = screenHeight * 0.4;
    profileHeight = screenHeight * 0.18;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: profileHeight / 2),
                ProfileInfo(
                  label: 'Nombre',
                  value: '${widget.firstName} ${widget.lastName}',
                  leading: const Icon(Icons.person),
                ),
                ProfileInfo(
                  label: 'Email',
                  value: widget.email,
                  leading: const Icon(Icons.email),
                ),
                ProfileInfo(
                  label: 'Rol',
                  value: widget.role,
                  leading: const Icon(Icons.work),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        buildCoverImage(),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          'assets/images/background_image.jpg',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: const AssetImage('assets/images/user.png'),
      );
}
