import 'package:flutter/material.dart';
import 'room_details_page.dart'; // Hubi in import-kani uu sax yahay

const Color darkNavy = Color(0xFF0D0F14);
const Color cardBg = Color(0xFF1E222D);
const Color goldAccent = Color(0xFFC6A15B);

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  String selectedCategory = 'All';

  final List  allRooms = [
    // --- 1. VIP Rooms ---
    {
      'name': 'Royal VIP Suite',
      'category': 'VIP',
      'price': '\$450',
      'rating': '5.0',
      'image': 'assets/images/image31.jpg',
      'description': 'Exclusive VIP services.',
    },
    {
      'name': 'Royal Penthouse',
      'category': 'VIP',
      'price': '\$380',
      'rating': '4.9',
      'image': 'assets/images/image32.jpg',
      'description': 'Elite room for royalty.',
    },
    {
      'name': 'Imperial Gold VIP',
      'category': 'VIP',
      'price': '\$420',
      'rating': '4.9',
      'image': 'assets/images/image33.jpg',
      'description': 'Premium gold & navy finish.',
    },
    {
      'name': 'Ambassador Suite',
      'category': 'VIP',
      'price': '\$390',
      'rating': '4.8',
      'image': 'assets/images/image34.jpg',
      'description': 'Private luxury space.',
    },
    {
      'name': 'Crown VIP Haven',
      'category': 'VIP',
      'price': '\$460',
      'rating': '5.0',
      'image': 'assets/images/image35.jpg',
      'description': 'Pinnacle of comfort.',
    },

    // --- 2. Normal Rooms ---
    {
      'name': 'Standard Deluxe',
      'category': 'Normal',
      'price': '\$150',
      'rating': '4.5',
      'image': 'assets/images/image36.jpg',
      'description': 'Cozy & comfortable.',
    },
    {
      'name': 'Classic Comfort',
      'category': 'Normal',
      'price': '\$130',
      'rating': '4.4',
      'image': 'assets/images/image37.jpg',
      'description': 'Affordable luxury.',
    },
    {
      'name': 'Superior Twin',
      'category': 'Normal',
      'price': '\$160',
      'rating': '4.6',
      'image': 'assets/images/image38.jpg',
      'description': 'Twin beds setup.',
    },
    {
      'name': 'Traditional Cozy',
      'category': 'Normal',
      'price': '\$140',
      'rating': '4.3',
      'image': 'assets/images/image39.jpg',
      'description': 'Warm atmosphere.',
    },

    // --- 3. Sitting Area ---
    {
      'name': 'Executive Lounge',
      'category': 'Sitting Area',
      'price': '\$260',
      'rating': '4.7',
      'image': 'assets/images/image40.jpg',
      'description': 'Private modern lounge.',
    },
    {
      'name': 'Deluxe Living Space',
      'category': 'Sitting Area',
      'price': '\$280',
      'rating': '4.8',
      'image': 'assets/images/image41.jpg',
      'description': 'Attached couch area.',
    },
    {
      'name': 'Grand Sitting Suite',
      'category': 'Sitting Area',
      'price': '\$300',
      'rating': '4.9',
      'image': 'assets/images/image42.jpg',
      'description': 'Large living room.',
    },
    {
      'name': 'Lounge Chamber',
      'category': 'Sitting Area',
      'price': '\$250',
      'rating': '4.6',
      'image': 'assets/images/image43.jpg',
      'description': 'Stylish seating suite.',
    },

    // --- 4. Rooms View ---
    {
      'name': 'Ocean View Room',
      'category': 'Rooms View',
      'price': '\$310',
      'rating': '4.9',
      'image': 'assets/images/image46.jpg',
      'description': 'Breathtaking scenery.',
    },
    {
      'name': 'Skyline City View',
      'category': 'Rooms View',
      'price': '\$290',
      'rating': '4.8',
      'image': 'assets/images/image47.jpg',
      'description': 'Gorgeous city lights.',
    },
    {
      'name': 'Sunset Horizon',
      'category': 'Rooms View',
      'price': '\$320',
      'rating': '4.9',
      'image': 'assets/images/image48.jpg',
      'description': 'Evening sunset view.',
    },
    {
      'name': 'Garden Scenery',
      'category': 'Rooms View',
      'price': '\$270',
      'rating': '4.6',
      'image': 'assets/images/image49.jpg',
      'description': 'Overlooks hotel gardens.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredRooms = selectedCategory == 'All'
        ? allRooms
        : allRooms.where((room) => room['category'] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: darkNavy,
      appBar: AppBar(
        backgroundColor: darkNavy,
        elevation: 0,
        iconTheme: const IconThemeData(color: goldAccent),
        title: const Text(
          'ROYAL ROOMS CATALOG',
          style: TextStyle(
            color: goldAccent,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner-ka sare ee Premium Header
            Container(
              height: 160,
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/image31.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      darkNavy.withOpacity(0.3),
                      darkNavy.withOpacity(0.9),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'PREMIUM',
                      style: TextStyle(
                        color: goldAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Royal Rooms Selection',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Explore our finest rooms made for ultimate luxury and comfort.',
                      style: TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),

            // Category Filter Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryChip('All'),
                    _buildCategoryChip('VIP'),
                    _buildCategoryChip('Normal'),
                    _buildCategoryChip('Sitting Area'),
                    _buildCategoryChip('Rooms View'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Qeybta cinwaanka Rooms
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Rooms Collection',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ** QAABKA JIifKA AH (Horizontal ListView) **
            SizedBox(
              height: 235,
              child: filteredRooms.isEmpty
                  ? const Center(
                      child: Text(
                        'No rooms found in this category.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredRooms.length,
                      itemBuilder: (context, index) {
                        final room = filteredRooms[index];
                        return _buildHorizontalRoomCard(room, context);
                      },
                    ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String categoryName) {
    bool isSelected = selectedCategory == categoryName;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(categoryName),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedCategory = categoryName;
          });
        },
        selectedColor: goldAccent,
        backgroundColor: cardBg,
        labelStyle: TextStyle(
          color: isSelected ? darkNavy : Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? goldAccent : Colors.white10,
          ),
        ),
      ),
    );
  }

  // Kaarka Jiifka ah oo ku xidhan RoomDetailsPage
  Widget _buildHorizontalRoomCard(Map<String, dynamic> room, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Halkan ayuu ku furayaa bogga faahfaahinta qolka
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomDetailsPage(room: room),
          ),
        );
      },
      child: Container(
        width: 155,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sawirka dusha sare
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                room['image']!,
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    room['description']!,
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        room['price']!,
                        style: const TextStyle(
                          color: goldAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Badhanka + isna wuxuu furayaa details-ka qolka
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RoomDetailsPage(room: room),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: goldAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.add, color: darkNavy, size: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}