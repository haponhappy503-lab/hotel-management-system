import 'package:flutter/material.dart';
import '../about/about_page.dart';
import '../services/services_page.dart';
import '../contact/contact_us_page.dart';
import '../../customer/welcome_page.dart'; // Import-ka WelcomePage-ka macmiilk
import '../../admin/dashboard/admin_dashboard.dart';


const Color darkNavy = Color(0xFF0D0F14);
const Color cardBg = Color(0xFF1E222D);
const Color primaryBlue = Color(0xFF5356FF);
const Color accentPurple = Color(0xFF8B8FD8);
const Color goldAccent = Color(0xFFC6A15B);

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
            // CUSTOMER DASHBOARD / WELCOME PAGE LINK
            ListTile(
              leading: const Icon(Icons.dashboard_outlined, color: goldAccent),
              title: const Text('Customer Dashboard', style: TextStyle(color: Colors.white)),
              subtitle: const Text('Welcome & Features', style: TextStyle(color: Colors.grey, fontSize: 11)),
              onTap: () {
                Navigator.pop(context); // Xir Drawer-ka
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomePage(),
                  ),
                );
              },
            ),
            ListTile(
  leading: const Icon(Icons.admin_panel_settings_outlined, color: goldAccent),
  title: const Text(
    'Admin Dashboard',
    style: TextStyle(color: Colors.white),
  ),
  subtitle: const Text(
    'Revenue, Rooms & Bookings Control',
    style: TextStyle(color: Colors.grey, fontSize: 11),
  ),
  onTap: () {
    Navigator.pop(context); // Xir Drawer-ka
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminDashboard(),
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