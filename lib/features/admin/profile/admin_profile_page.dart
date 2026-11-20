import 'package:flutter/material.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  static const Color navy = Color(0xFF173B63);
  static const Color blue = Color(0xFF397CC0);
  static const Color bg = Color(0xFF090B0F);
  static const Color card = Color(0xFF11151B);
  static const Color muted = Color(0xFF858D99);
  static const Color white = Color(0xFFF3F5F8);

  String adminName = 'Royal Hotel Admin';
  String adminRole = 'System & Hotel Administrator';
  String adminEmail = 'admin@royalhotel.com';
  String hotelBranch = 'Royal Hotel — Main Branch';
  String defaultCurrency = 'USD (\$)';

  void _editProfileDialog() {
    final nameCtrl = TextEditingController(text: adminName);
    final roleCtrl = TextEditingController(text: adminRole);
    final emailCtrl = TextEditingController(text: adminEmail);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: card,
          title: const Text(
            'Edit Admin Profile',
            style: TextStyle(
              color: white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                style: const TextStyle(color: white, fontSize: 12),
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: muted, fontSize: 11),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: roleCtrl,
                style: const TextStyle(color: white, fontSize: 12),
                decoration: const InputDecoration(
                  labelText: 'Role / Title',
                  labelStyle: TextStyle(color: muted, fontSize: 11),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailCtrl,
                style: const TextStyle(color: white, fontSize: 12),
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: TextStyle(color: muted, fontSize: 11),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: muted, fontSize: 12),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: blue,
                foregroundColor: white,
              ),
              onPressed: () {
                setState(() {
                  if (nameCtrl.text.trim().isNotEmpty) {
                    adminName = nameCtrl.text.trim();
                  }
                  if (roleCtrl.text.trim().isNotEmpty) {
                    adminRole = roleCtrl.text.trim();
                  }
                  if (emailCtrl.text.trim().isNotEmpty) {
                    adminEmail = emailCtrl.text.trim();
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: card,
          title: const Text(
            'Sign Out',
            style: TextStyle(
              color: white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to sign out of the Royal Hotel Admin session?',
            style: TextStyle(color: muted, fontSize: 12),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: muted, fontSize: 12),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE07A7A),
                foregroundColor: white,
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Color(0xFF161B22),
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      'Admin session signed out.',
                      style: TextStyle(color: Color(0xFF8DB9E5), fontSize: 12),
                    ),
                  ),
                );
              },
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  String get _initials {
    final parts = adminName.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return adminName.isNotEmpty ? adminName[0].toUpperCase() : 'AD';
  }

  Widget _infoTile(
    IconData icon,
    String title,
    String value, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF202832)),
        ),
        child: Row(
          children: [
            Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: navy.withOpacity(.45),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF8DB9E5),
                size: 19,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: muted, fontSize: 10.5),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(Icons.chevron_right, color: muted, size: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        iconTheme: const IconThemeData(color: white),
        title: const Text(
          'Admin Profile',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _editProfileDialog,
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF8DB9E5)),
            tooltip: 'Edit Profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF202832)),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: navy.withOpacity(.55),
                    child: Text(
                      _initials,
                      style: const TextStyle(
                        color: Color(0xFF8DB9E5),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    adminName,
                    style: const TextStyle(
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    adminRole,
                    style: const TextStyle(color: muted, fontSize: 11.5),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: blue.withOpacity(.16),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'ACTIVE ADMIN',
                      style: TextStyle(
                        color: Color(0xFF8DB9E5),
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _infoTile(
              Icons.email_outlined,
              'Email',
              adminEmail,
              onTap: _editProfileDialog,
            ),
            const SizedBox(height: 10),
            _infoTile(Icons.apartment_outlined, 'Property', hotelBranch),
            const SizedBox(height: 10),
            _infoTile(
              Icons.payments_outlined,
              'Default Currency',
              defaultCurrency,
              onTap: () {
                setState(() {
                  defaultCurrency =
                      defaultCurrency == 'USD (\$)' ? 'SLSH' : 'USD (\$)';
                });
              },
            ),
            const SizedBox(height: 10),
            _infoTile(
              Icons.verified_user_outlined,
              'Access Level',
              'Full Hotel Management',
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _editProfileDialog,
                icon: const Icon(Icons.edit_note_rounded, size: 20),
                label: const Text(
                  'Update Profile Info',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFE07A7A),
                  side: const BorderSide(color: Color(0xFF2B3440)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _confirmLogout,
                icon: const Icon(Icons.logout_rounded, size: 18),
                label: const Text(
                  'Sign Out',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}