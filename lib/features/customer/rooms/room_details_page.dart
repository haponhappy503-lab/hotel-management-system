import 'package:flutter/material.dart';
import 'room_booking_page.dart'; // Hubi in import-kani uu dusha ka jiro

const Color darkNavy = Color(0xFF0D0F14);
const Color cardBg = Color(0xFF1E222D);
const Color goldAccent = Color(0xFFC6A15B);

class RoomDetailsPage extends StatelessWidget {
  final Map<String, dynamic> room;

  const RoomDetailsPage({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkNavy,
      appBar: AppBar(
        backgroundColor: darkNavy,
        elevation: 0,
        iconTheme: const IconThemeData(color: goldAccent),
        title: Text(
          room['name'] ?? 'Room Details',
          style: const TextStyle(
            color: goldAccent,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. TOP HERO BANNER / IMAGE OO DHAMMAYSTIRAN
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black, // Si ay hareeruhu u madoobaadaan
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(room['image'] ?? 'assets/images/image31.jpg'),
                  fit: BoxFit.contain, // Sawirku wuxuu noqonayaa mid buuxda oo aan go'ayn
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Layout-ka labada qeybood (Bidix: Details, Midig: Booking Form)
            LayoutBuilder(
              builder: (context, constraints) {
                bool isWide = constraints.maxWidth > 800;
                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: _buildLeftDetails()),
                      const SizedBox(width: 20),
                      Expanded(flex: 2, child: _buildRightBookingCard(context)),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildLeftDetails(),
                      const SizedBox(height: 24),
                      _buildRightBookingCard(context),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // QEYBTA BIDIX: Faahfaahinta, Sifooyinka iyo Sharaxaada
  Widget _buildLeftDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              room['name'] ?? 'Luxury Room',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: const [
                Icon(Icons.star, color: goldAccent, size: 16),
                Icon(Icons.star, color: goldAccent, size: 16),
                Icon(Icons.star, color: goldAccent, size: 16),
                Icon(Icons.star, color: goldAccent, size: 16),
                Icon(Icons.star, color: goldAccent, size: 16),
              ],
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          '${room['price'] ?? '\$400'} / Night',
          style: const TextStyle(
            color: goldAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          room['description'] ??
              'Undervalued seaside elegance, traditional grace, complemented by warm homely touches and pops of modern flair. Designed for ultimate luxury and comfort.',
          style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 24),

        // Room Feature Section
        const Text(
          'Room Feature',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildFeatureChip(Icons.tv, 'TV'),
            _buildFeatureChip(Icons.wifi, 'Free Wifi'),
            _buildFeatureChip(Icons.ac_unit, 'Air Condition'),
            _buildFeatureChip(Icons.phone, 'Phone'),
            _buildFeatureChip(Icons.local_laundry_service, 'Laundry'),
            _buildFeatureChip(Icons.person, 'Adults: 2'),
            _buildFeatureChip(Icons.aspect_ratio, 'Size: 24m²'),
            _buildFeatureChip(Icons.king_bed, 'Bed Type: One bed'),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: goldAccent, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // QEYBTA MIDIG: Foomka Ballanta & Support Box
  Widget _buildRightBookingCard(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: goldAccent.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Book A Room',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildInputField('Check In Date', 'mm/dd/yyyy', Icons.calendar_today),
              const SizedBox(height: 12),
              _buildInputField('Check Out Date', 'mm/dd/yyyy', Icons.calendar_today),
              const SizedBox(height: 12),
              _buildInputField('Adults', '2 Adults', Icons.person_outline),
              const SizedBox(height: 12),
              _buildInputField('Room', '1 Room', Icons.king_bed_outlined),
              const SizedBox(height: 20),

              // Book Now Button oo ku xidhan RoomBookingPage
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: goldAccent,
                    foregroundColor: darkNavy,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Halkan ayaa lagu xiray RoomBookingPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomBookingPage(room: room),
                      ),
                    );
                  },
                  child: const Text(
                    'BOOK TABLE NOW',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Contact Support Box
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: goldAccent.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: goldAccent),
          ),
          child: Column(
            children: const [
              Text(
                'If You Need Any Help\nContact With Us',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '+91 705 2101 786',
                style: TextStyle(
                  color: goldAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: darkNavy,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Icon(icon, color: goldAccent, size: 16),
            ],
          ),
        ),
      ],
    );
  }
}