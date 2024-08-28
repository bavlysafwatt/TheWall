import 'package:flutter/material.dart';
import 'package:the_wall/pages/profile_page.dart';
import 'package:the_wall/pages/users_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.post_add_rounded,
                  size: 50,
                  color: Colors.grey.shade800,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: ListTile(
                  leading: Icon(
                    Icons.home_filled,
                    color: Colors.grey.shade800,
                  ),
                  title: Text(
                    'H O M E',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: ListTile(
                  leading: Icon(
                    Icons.person_rounded,
                    color: Colors.grey.shade800,
                  ),
                  title: Text(
                    'P R O F I L E',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: ListTile(
                  leading: Icon(
                    Icons.group_rounded,
                    color: Colors.grey.shade800,
                  ),
                  title: Text(
                    'U S E R S',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const UsersPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, bottom: 18),
            child: ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.grey.shade800,
              ),
              title: Text(
                'L O G O U T',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade800,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
