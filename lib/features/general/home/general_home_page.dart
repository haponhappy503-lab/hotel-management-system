import 'dart:ui';
import 'package:flutter/material.dart';
import '../about/about_page.dart';
import '../services/services_page.dart';
import '../contact/contact_us_page.dart';
import '../../customer/welcome_page.dart';
import '../../admin/dashboard/admin_dashboard.dart';

const Color darkNavy = Color(0xFF0D0F14);
const Color cardBg = Color(0xFF1E222D);
const Color primaryBlue = Color(0xFF5356FF);
const Color accentPurple = Color(0xFF8B8FD8);
const Color goldAccent = Color(0xFFC6A15B);

// Liiska akoonnada ee wadaagga ah (waxaa ku jira admin iyo customer, waxaana ku dara Register)
final Map<String, String> registeredUsers = {
  'admin': '1234',
  'customer': '1234',
};

class GeneralHomePage extends StatelessWidget {
  const GeneralHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkNavy,
      // SIDE NAVIGATION DRAWER
      drawer: Drawer(
        backgroundColor: darkNavy,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: cardBg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.hotel, color: accentPurple, size: 40),
                  SizedBox(height: 10),
                  Text(
                    'ROYAL HOTEL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Luxury & Comfort',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: accentPurple),
              title: const Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
            // CUSTOMER DASHBOARD / WELCOME PAGE LINK (Wuxuu marka hore weydiinayaa Login)
            ListTile(
              leading: const Icon(Icons.dashboard_outlined, color: goldAccent),
              title: const Text('Customer Dashboard', style: TextStyle(color: Colors.white)),
              subtitle: const Text(
                'Login required',
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              onTap: () {
                Navigator.pop(context); // Xir Drawer-ka
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(
                      initialRole: 'customer',
                      customerHomePage: WelcomePage(),
                      adminHomePage: AdminDashboard(),
                    ),
                  ),
                );
              },
            ),
            // ADMIN DASHBOARD LINK (Wuxuu marka hore weydiinayaa Username & Password)
            ListTile(
              leading: const Icon(Icons.admin_panel_settings_outlined, color: goldAccent),
              title: const Text(
                'Admin Dashboard',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                'Password required',
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              onTap: () {
                Navigator.pop(context); // Xir Drawer-ka
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(
                      initialRole: 'admin',
                      customerHomePage: WelcomePage(),
                      adminHomePage: AdminDashboard(),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: accentPurple),
              title: const Text('About Us', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.room_service_outlined, color: goldAccent),
              title: const Text('Services', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ServicesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined, color: accentPurple),
              title: const Text('Gallery', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to Gallery Page
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_support_outlined, color: goldAccent),
              title: const Text(
                'Contact Us',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context); // Xir Drawer-ka
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header with working Drawer button
              Builder(
                builder: (context) => _buildHeader(context),
              ),
              const SizedBox(height: 16),

              // 2. Hero / Welcome Section (Using image1.jpg)
              _buildHero(context),
              const SizedBox(height: 20),

              // 3. Booking / Search Section
              _buildBookingCard(context),
              const SizedBox(height: 24),

              // 4. Featured rooms section
              _buildSectionTitle(
                'Explore Our Rooms',
                'Comfort and luxury for your stay',
              ),
              const SizedBox(height: 16),
              _buildRooms(),
              const SizedBox(height: 24),

              // 5. Hotel Dining & Snacks Section
              _buildSectionTitle(
                'Hotel Dining & Snacks',
                'Exquisite food, fresh snacks, and delightful tastes',
              ),
              const SizedBox(height: 16),
              _buildFoodHighlights(),
              const SizedBox(height: 24),

              // 6. Hotel Spa & Wellness Section (Using image18 to image23)
              _buildSectionTitle(
                'Luxury Spa & Wellness',
                'Relax, rejuvenate, and restore your mind and body',
              ),
              const SizedBox(height: 16),
              _buildSpaHighlights(),
              const SizedBox(height: 30),

              // 7. Footer
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  // HEADER
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.hotel, color: accentPurple, size: 30),
            const SizedBox(width: 10),
            const Text(
              'ROYAL HOTEL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // HERO SECTION (Using image1.jpg)
  Widget _buildHero(BuildContext context) {
    return Container(
      height: 380,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        image: const DecorationImage(
          image: AssetImage('assets/images/image1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.2),
              darkNavy.withOpacity(0.95),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'WELCOME TO ROYAL STAY',
              style: TextStyle(
                color: accentPurple,
                letterSpacing: 2,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Experience Luxury & Elegance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Explore top rooms and unforgettable hospitality.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Room booking will be available soon.'),
                  ),
                );
              },
              child: const Text(
                'BOOK YOUR STAY',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // BOOKING CARD
  Widget _buildBookingCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Find Your Perfect Stay',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _bookingField(Icons.calendar_today, 'Check-in date'),
          const SizedBox(height: 10),
          _bookingField(Icons.calendar_month, 'Check-out date'),
          const SizedBox(height: 10),
          _bookingField(Icons.people_outline, 'Number of guests'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Room search will be connected soon.'),
                  ),
                );
              },
              child: const Text('SEARCH ROOMS', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookingField(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: darkNavy,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: accentPurple, size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.white70)),
          const Spacer(),
          const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        ],
      ),
    );
  }

  // SECTION TITLE
  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ],
    );
  }

  // ROOMS
  Widget _buildRooms() {
    return SizedBox(
      height: 270,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _roomCard(
            'Deluxe Room',
            'Comfortable and elegant',
            'assets/images/image2.jpg',
            '\$180 / night',
          ),
          const SizedBox(width: 16),
          _roomCard(
            'Luxury Suite',
            'A premium royal experience',
            'assets/images/image3.jpg',
            '\$350 / night',
          ),
          const SizedBox(width: 16),
          _roomCard(
            'Executive Room',
            'Modern and stylish space',
            'assets/images/image13.jpg',
            '\$220 / night',
          ),
          const SizedBox(width: 16),
          _roomCard(
            'Royal Penthouse',
            'Ultimate luxury living',
            'assets/images/image14.jpg',
            '\$500 / night',
          ),
          const SizedBox(width: 16),
          _roomCard(
            'Standard Room',
            'Cozy and affordable',
            'assets/images/image15.jpg',
            '\$120 / night',
          ),
        ],
      ),
    );
  }

  Widget _roomCard(String name, String description, String image, String price) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Image.asset(
              image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    color: accentPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // FOOD & SNACKS HIGHLIGHTS
  Widget _buildFoodHighlights() {
    final foodItems = [
      {'image': 'assets/images/image10.jpg', 'title': 'Fine Dining Restaurant'},
      {'image': 'assets/images/image11.jpg', 'title': 'Fresh Tasty Snacks'},
      {'image': 'assets/images/image12.jpg', 'title': 'Special Chef Meals'},
      {'image': 'assets/images/image16.jpg', 'title': 'Gourmet Breakfast'},
      {'image': 'assets/images/image17.jpg', 'title': 'Exotic Beverages'},
    ];

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          final item = foodItems[index];
          return Container(
            width: 220,
            margin: EdgeInsets.only(right: index == foodItems.length - 1 ? 0 : 16),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(18),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    item['image']!,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.85),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Text(
                      item['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // SPA & WELLNESS HIGHLIGHTS
  Widget _buildSpaHighlights() {
    final spaItems = [
      {'image': 'assets/images/image18.jpg', 'title': 'Relaxation Therapy'},
      {'image': 'assets/images/image19.jpg', 'title': 'Aromatherapy Massage'},
      {'image': 'assets/images/image20.jpg', 'title': 'Sauna & Steam Bath'},
      {'image': 'assets/images/image21.jpg', 'title': 'Skin Care & Facial'},
      {'image': 'assets/images/image22.jpg', 'title': 'Traditional Hammam'},
      {'image': 'assets/images/image23.jpg', 'title': 'Private Wellness Room'},
    ];

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: spaItems.length,
        itemBuilder: (context, index) {
          final item = spaItems[index];
          return Container(
            width: 220,
            margin: EdgeInsets.only(right: index == spaItems.length - 1 ? 0 : 16),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(18),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    item['image']!,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.85),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Text(
                      item['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // FOOTER
  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Text(
            'ROYAL HOTEL',
            style: TextStyle(
              color: accentPurple,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Luxury • Comfort • Hospitality',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(height: 14),
          Text(
            '© 2026 Royal Hotel. All rights reserved.',
            style: TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// LOGIN PAGE (Navy Blue & Luxury Gold + Shining Border + Username & Password)
// =========================================================================
class LoginPage extends StatefulWidget {
  final String? initialRole; // 'customer' ama 'admin'
  final Widget? customerHomePage;
  final Widget? adminHomePage;

  const LoginPage({
    super.key,
    this.initialRole,
    this.customerHomePage,
    this.adminHomePage,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  static const Color navyBg = Color(0xFF0A0F1E);
  static const Color navyCard = Color(0xFF131B2E);
  static const Color navyElevated = Color(0xFF1A243D);
  static const Color gold = Color(0xFFC6A15B);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  late AnimationController _shineController;

  @override
  void initState() {
    super.initState();
    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    _shineController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: navyElevated,
        content: Text(
          message,
          style: const TextStyle(color: gold),
        ),
      ),
    );
  }

  void _handleLogin() {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      showMessage('Fadlan geli username iyo password');
      return;
    }

    final savedPass = registeredUsers[username];
    if (savedPass == null || savedPass != password) {
      showMessage(
        widget.initialRole == 'admin'
            ? 'Admin username ama password waa khalad! (Tijaabo: admin / 1234)'
            : 'Username ama password waa khalad! (Haddii aadan akoon lahayn, Register samee)',
      );
      return;
    }

    if (widget.initialRole == 'admin' && username.toLowerCase() != 'admin') {
      showMessage('Akoonkan ma aha Admin!');
      return;
    }

    showMessage('Soo dhawoow, $username!');

    if (username.toLowerCase() == 'admin' && widget.adminHomePage != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => widget.adminHomePage!),
      );
    } else if (widget.customerHomePage != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => widget.customerHomePage!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAdminTarget = widget.initialRole == 'admin';

    return Scaffold(
      backgroundColor: navyBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: gold),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 750;

          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/image29.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: navyBg);
                },
              ),
              Container(color: navyBg.withOpacity(0.58)),
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: isDesktop ? _desktopLayout(isAdminTarget) : _mobileLayout(isAdminTarget),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _desktopLayout(bool isAdminTarget) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1250),
      child: SizedBox(
        height: 700,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    width: 420,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: navyCard.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: gold.withOpacity(0.35)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Because Stays Should Feel Like Destinations',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Georgia',
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Find a perfect stay for your much awaited vacation!',
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 550,
              child: _loginCard(isAdminTarget),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mobileLayout(bool isAdminTarget) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text(
          'Because Stays Should Feel Like Destinations',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Georgia',
          ),
        ),
        const SizedBox(height: 25),
        _loginCard(isAdminTarget),
      ],
    );
  }

  Widget _loginCard(bool isAdminTarget) {
    return AnimatedBuilder(
      animation: _shineController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(_shineController.value * 6.28),
              colors: const [
                gold,
                Color(0xFF2A4A7F),
                Colors.white,
                Color(0xFF1A2E52),
                gold,
              ],
            ),
            boxShadow: [
              BoxShadow(color: navyBg.withOpacity(0.65), blurRadius: 25, spreadRadius: 3),
              BoxShadow(color: gold.withOpacity(0.18), blurRadius: 30),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                decoration: BoxDecoration(
                  color: navyCard.withOpacity(0.90),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: child,
              ),
            ),
          ),
        );
      },
      child: _loginForm(isAdminTarget),
    );
  }

  Widget _loginForm(bool isAdminTarget) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
          decoration: BoxDecoration(
            color: navyElevated,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: gold.withOpacity(0.45)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isAdminTarget ? Icons.admin_panel_settings : Icons.hotel,
                color: gold,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                isAdminTarget ? 'Royal Hotel • Admin' : 'Royal Hotel',
                style: const TextStyle(
                  color: gold,
                  fontSize: 17,
                  fontFamily: 'Georgia',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),
        Text(
          isAdminTarget ? 'Admin Sign In' : 'Welcome Back to\nRoyal Hotel',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: 'Georgia',
            height: 1.25,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          isAdminTarget
              ? 'Geli username iyo password-ka Admin-ka (tusaale: admin / 1234)'
              : 'Sign in with your username and password (tusaale: customer / 1234)',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white60, fontSize: 13.5),
        ),
        const SizedBox(height: 28),

        _fieldLabel('Username'),
        const SizedBox(height: 7),
        TextField(
          controller: usernameController,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('Enter your username', Icons.person_outline),
        ),
        const SizedBox(height: 20),

        _fieldLabel('Password'),
        const SizedBox(height: 7),
        TextField(
          controller: passwordController,
          obscureText: obscurePassword,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('Enter your password', Icons.lock_outline).copyWith(
            suffixIcon: IconButton(
              onPressed: () => setState(() => obscurePassword = !obscurePassword),
              icon: Icon(
                obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: Colors.white54,
              ),
            ),
          ),
        ),
        const SizedBox(height: 26),

        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: gold,
              foregroundColor: navyBg,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),
            ),
          ),
        ),

        if (!isAdminTarget) ...[
          const SizedBox(height: 22),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              const Text(
                "Don't have an account? ",
                style: TextStyle(color: Colors.white70, fontSize: 13.5),
              ),
              GestureDetector(
                onTap: () async {
                  final createdUser = await Navigator.push<String>(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  );
                  if (createdUser != null && createdUser.isNotEmpty) {
                    usernameController.text = createdUser;
                    showMessage('Akoonka ($createdUser) waa la keydiyey — geli password-kaaga!');
                  }
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: gold,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _fieldLabel(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Georgia'),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData? icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13, color: Colors.white38),
      prefixIcon: icon == null ? null : Icon(icon, size: 18, color: gold),
      filled: true,
      fillColor: navyElevated,
      contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: gold, width: 1.5),
      ),
    );
  }
}

// =========================================================================
// REGISTER PAGE (Navy Blue & Luxury Gold + Shining Border + Bilaa Sawir)
// =========================================================================
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  static const Color navyBg = Color(0xFF0A0F1E);
  static const Color navyCard = Color(0xFF131B2E);
  static const Color navyElevated = Color(0xFF1A243D);
  static const Color gold = Color(0xFFC6A15B);

  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  late AnimationController _shineController;

  @override
  void initState() {
    super.initState();
    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    usernameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _shineController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: navyElevated,
        content: Text(message, style: const TextStyle(color: gold)),
      ),
    );
  }

  void _handleRegister() {
    final username = usernameController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty || phone.isEmpty || password.isEmpty) {
      showMessage('Fadlan buuxi username, telefoonka iyo password-ka');
      return;
    }
    if (password.length < 4) {
      showMessage('Password-ku ha ka yaraan 4 xaraf');
      return;
    }
    if (password != confirmPassword) {
      showMessage('Labada password isma laha');
      return;
    }

    registeredUsers[username] = password;
    showMessage('Waa laguu diiwaangeliyey ($username)! Hadda waad soo geli kartaa.');
    Navigator.pop(context, username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navyBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: gold),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF070B16), navyBg, Color(0xFF0F1930)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: _registerCard(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerCard() {
    return AnimatedBuilder(
      animation: _shineController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(_shineController.value * 6.28),
              colors: const [
                gold,
                Color(0xFF2A4A7F),
                Colors.white,
                Color(0xFF1A2E52),
                gold,
              ],
            ),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.65), blurRadius: 25, spreadRadius: 3),
              BoxShadow(color: gold.withOpacity(0.18), blurRadius: 32),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                decoration: BoxDecoration(
                  color: navyCard.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: child,
              ),
            ),
          ),
        );
      },
      child: _registerForm(),
    );
  }

  Widget _registerForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
          decoration: BoxDecoration(
            color: navyElevated,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: gold.withOpacity(0.45)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.hotel, color: gold, size: 20),
              SizedBox(width: 8),
              Text(
                'Royal Hotel',
                style: TextStyle(
                  color: gold,
                  fontSize: 17,
                  fontFamily: 'Georgia',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Create Account at\nRoyal Hotel',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 28, color: Colors.white, fontFamily: 'Georgia', height: 1.25),
        ),
        const SizedBox(height: 8),
        const Text(
          'Diiwaangeli akoon cusub si aad u ballansato qolalka',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white60, fontSize: 13.5),
        ),
        const SizedBox(height: 24),

        _fieldLabel('Username'),
        const SizedBox(height: 6),
        TextField(
          controller: usernameController,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('Enter your username', Icons.person_outline),
        ),
        const SizedBox(height: 16),

        _fieldLabel('Phone Number (ZAAD / eDahab)'),
        const SizedBox(height: 6),
        TextField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('+252 63 ...', Icons.phone_outlined),
        ),
        const SizedBox(height: 16),

        _fieldLabel('Password'),
        const SizedBox(height: 6),
        TextField(
          controller: passwordController,
          obscureText: obscurePassword,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('Create a password', Icons.lock_outline).copyWith(
            suffixIcon: IconButton(
              onPressed: () => setState(() => obscurePassword = !obscurePassword),
              icon: Icon(
                obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: Colors.white54,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        _fieldLabel('Confirm Password'),
        const SizedBox(height: 6),
        TextField(
          controller: confirmPasswordController,
          obscureText: obscureConfirmPassword,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('Re-enter your password', Icons.lock_reset_outlined).copyWith(
            suffixIcon: IconButton(
              onPressed: () => setState(() => obscureConfirmPassword = !obscureConfirmPassword),
              icon: Icon(
                obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: Colors.white54,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _handleRegister,
            style: ElevatedButton.styleFrom(
              backgroundColor: gold,
              foregroundColor: navyBg,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              'Register',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),
            ),
          ),
        ),
        const SizedBox(height: 20),

        Wrap(
          alignment: WrapAlignment.center,
          children: [
            const Text(
              'Already have an account? ',
              style: TextStyle(color: Colors.white70, fontSize: 13.5),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text(
                'Login',
                style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 13.5),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _fieldLabel(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: const TextStyle(fontSize: 13.5, color: Colors.white, fontFamily: 'Georgia')),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData? icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13, color: Colors.white38),
      prefixIcon: icon == null ? null : Icon(icon, size: 18, color: gold),
      filled: true,
      fillColor: navyElevated,
      contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: gold, width: 1.5),
      ),
    );
  }
}