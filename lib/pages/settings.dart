import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                // Handle back button tap
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.black, size: 20),
                            SizedBox(width: 2),
                            Text(
                              '5.0',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Aness',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      '0656765434',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    // Navigate to Profile page
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                        )
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/pic.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 20), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Account'),
              _buildCategoryRow(
                icon: Icons.person,
                title: 'Personal Information',
                onTap: () {
                  // Navigate to Personal Information page
                },
              ),
              _buildCategoryRow(
                icon: Icons.notifications,
                title: 'Notifications',
                onTap: () {
                  // Navigate to Notifications page
                },
              ),
              _buildCategoryRow(
                icon: Icons.payment,
                title: 'Payment Methods',
                onTap: () {
                  // Navigate to Payment Methods page
                },
              ),
              _buildCategoryRow(
                icon: Icons.location_on,
                title: 'Address Book',
                onTap: () {
                  // Navigate to Address Book page
                },
              ),
              _buildSectionTitle('Additional'),
              _buildCategoryRow(
                icon: Icons.language,
                title: 'Language',
                onTap: () {
                  // Navigate to Language page
                },
              ),
              _buildCategoryRow(
                icon: Icons.history,
                title: 'History',
                onTap: () {
                  // Navigate to History page
                },
              ),
              _buildCategoryRow(
                icon: Icons.logout,
                title: 'Log out',
                onTap: () {
                  // Perform log out action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 19,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          height: 1.53,
          letterSpacing: 0,
        ),
      ),
    );
  }

  Widget _buildCategoryRow({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFD9D9D9),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(icon),
            ),
            Text(title),
            Spacer(),
            GestureDetector(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
