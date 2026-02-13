import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// ---------------------- Profile Page ----------------------
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showPickOptionsDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Choose option"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // صورة البروفايل
            Center(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: _showPickOptionsDialog,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : AssetImage("assets/profile.jpg") as ImageProvider,
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: _showPickOptionsDialog,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Text(
              "Ibrahim Karam",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "ibrahim@gmail.com",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),

            SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditProfilePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Edit Profile", style: TextStyle(fontSize: 16)),
              ),
            ),

            SizedBox(height: 30),

            buildProfileItem(
              context,
              Icons.person,
              "Account Information",
              page: AccountInfoPage(),
            ),
            buildProfileItem(
              context,
              Icons.lock,
              "Change Password",
              page: ChangePasswordPage(),
            ),
            buildProfileItem(
              context,
              Icons.notifications,
              "Notifications",
              page: NotificationsPage(),
            ),
            buildProfileItem(
              context,
              Icons.security,
              "Privacy & Security",
              page: PrivacyPage(),
            ),
            buildProfileItem(
              context,
              Icons.help,
              "Help & Support",
              page: HelpPage(),
            ),
            buildProfileItem(
              context,
              Icons.logout,
              "Logout",
              color: Colors.red,
              logout: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(
    BuildContext context,
    IconData icon,
    String title, {
    Color? color,
    Widget? page,
    bool logout = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: color ?? Colors.green),
        title: Text(title, style: TextStyle(fontSize: 16)),
        trailing: Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () {
          if (logout) {
            // هنا ممكن تضع Navigator لتسجيل الخروج
            Navigator.pop(context);
          } else if (page != null) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => page));
          }
        },
      ),
    );
  }
}

// ---------------------- Edit Profile ----------------------
class EditProfilePage extends StatelessWidget {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: phoneCtrl,
              decoration: InputDecoration(labelText: "Phone"),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Profile Updated!")));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- Account Info ----------------------
class AccountInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Information"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: Ibrahim Karam", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Email: ibrahim@gmail.com", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Phone: 01012345678", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

// ---------------------- Change Password ----------------------
class ChangePasswordPage extends StatelessWidget {
  final TextEditingController oldPass = TextEditingController();
  final TextEditingController newPass = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: oldPass,
              obscureText: true,
              decoration: InputDecoration(labelText: "Old Password"),
            ),
            TextField(
              controller: newPass,
              obscureText: true,
              decoration: InputDecoration(labelText: "New Password"),
            ),
            TextField(
              controller: confirmPass,
              obscureText: true,
              decoration: InputDecoration(labelText: "Confirm Password"),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (newPass.text != confirmPass.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Passwords do not match")),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Password Changed Successfully")),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Update Password"),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- Notifications ----------------------
class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          SwitchListTile(
            value: true,
            onChanged: (v) {},
            title: Text("App Notifications"),
          ),
          SwitchListTile(
            value: false,
            onChanged: (v) {},
            title: Text("Email Notifications"),
          ),
        ],
      ),
    );
  }
}

// ---------------------- Privacy ----------------------
class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy & Security"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Here you can manage your privacy settings.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// ---------------------- Help ----------------------
class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help & Support"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Contact us at: support@yourapp.com",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
