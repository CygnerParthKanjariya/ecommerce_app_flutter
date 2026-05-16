import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 30),

          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.person, size: 50),
          ),

          const SizedBox(height: 16),

          const Text("Parth Kanjariya", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

          const SizedBox(height: 6),

          Text("parth@gmail.com", style: TextStyle(color: Colors.grey.shade700)),

          const SizedBox(height: 30),

          ListTile(
            leading: const Icon(Icons.shopping_bag_outlined),
            title: const Text("My Orders"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.location_on_outlined),
            title: const Text("Address"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text("Settings"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
