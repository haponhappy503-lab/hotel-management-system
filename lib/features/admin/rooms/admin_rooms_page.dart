import 'package:flutter/material.dart';
import 'add_room_page.dart';
import 'edit_room_page.dart';
import 'room_details_page.dart';

const Color navyBg = Color(0xFF0A0F1E);
const Color navyCard = Color(0xFF131B2E);
const Color navyElevated = Color(0xFF1A243D);
const Color goldAccent = Color(0xFFC6A15B);

class AdminRoomsPage extends StatefulWidget {
  const AdminRoomsPage({super.key});

  @override
  State<AdminRoomsPage> createState() => _AdminRoomsPageState();
}

class _AdminRoomsPageState extends State<AdminRoomsPage> {
  String selectedCategory = 'All';
  String searchQuery = '';

  final List<String> categories = const [
    'All',
    'Deluxe',
    'Suite',
    'Penthouse',
    'Standard',
  ];

  final List rooms = [
    {
      'name': 'Royal Luxury Suite (#402)',
      'category': 'Suite',
      'price': '\$350 / night',
      'status': 'Available',
      'image': 'assets/images/image6.jpg',
      'description': 'Panoramic view, king bed, and private lounge.',
    },
    {
      'name': 'Deluxe Ocean View (#205)',
      'category': 'Deluxe',
      'price': '\$180 / night',
      'status': 'Occupied',
      'image': 'assets/images/image2.jpg',
      'description': 'Bright ocean balcony with modern navy interiors.',
    },
    {
      'name': 'Grand Royal Penthouse (#601)',
      'category': 'Penthouse',
      'price': '\$500 / night',
      'status': 'Available',
      'image': 'assets/images/image14.jpg',
      'description': 'Top-floor luxury residence with dining terrace.',
    },
    {
      'name': 'Classic Standard (#108)',
      'category': 'Standard',
      'price': '\$120 / night',
      'status': 'Maintenance',
      'image': 'assets/images/image15.jpg',
      'description': 'Cozy and calm stay for business or solo guests.',
    },
  ];

  List get filteredRooms {
    return rooms.where((r) {
      final matchesCategory =
          selectedCategory == 'All' || r['category'] == selectedCategory;
      final matchesQuery = searchQuery.trim().isEmpty ||
          r['name'].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  Future<void> _goAddRoom() async {
    final created = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddRoomPage()),
    );
    if (created != null) {
      setState(() => rooms.insert(0, created));
    }
  }

  Future<void> _goEditRoom(int originalIndex) async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditRoomPage(room: rooms[originalIndex]),
      ),
    );
    if (updated != null) {
      setState(() => rooms[originalIndex] = updated);
    }
  }

  void _deleteRoom(int originalIndex) {
    final removedName = rooms[originalIndex]['name'].toString();
    setState(() => rooms.removeAt(originalIndex));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: navyElevated,
        content: Text(
          '"$removedName" waa la tirtiray',
          style: const TextStyle(color: goldAccent),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = filteredRooms;

    return Scaffold(
      backgroundColor: navyBg,
      appBar: AppBar(
        backgroundColor: navyBg,
        elevation: 0,
        iconTheme: const IconThemeData(color: goldAccent),
        title: const Text(
          'ADMIN • ROOMS',
          style: TextStyle(
            color: goldAccent,
            fontSize: 14.5,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.6,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: goldAccent,
        foregroundColor: navyBg,
        onPressed: _goAddRoom,
        icon: const Icon(Icons.add),
        label: const Text(
          'Add Room',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
            child: TextField(
              onChanged: (val) => setState(() => searchQuery = val),
              style: const TextStyle(color: Colors.white, fontSize: 13.5),
              decoration: InputDecoration(
                hintText: 'Search room by name...',
                hintStyle: const TextStyle(color: Colors.white38, fontSize: 12.5),
                prefixIcon: const Icon(Icons.search, color: goldAccent),
                filled: true,
                fillColor: navyCard,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: goldAccent),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final cat = categories[i];
                final active = cat == selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => selectedCategory = cat),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: active ? goldAccent : navyCard,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: active ? goldAccent : goldAccent.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: active ? navyBg : Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 84),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = list[index];
                final originalIndex = rooms.indexOf(item);
                final status = (item['status'] ?? 'Available').toString();

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RoomDetailsPage(room: item),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: navyCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: goldAccent.withOpacity(0.28)),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            (item['image'] ?? 'assets/images/image6.jpg').toString(),
                            width: 74,
                            height: 74,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 74,
                              height: 74,
                              color: navyElevated,
                              child: const Icon(Icons.king_bed, color: goldAccent),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (item['name'] ?? '').toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.5,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${item['category']} • ${item['price']}',
                                style: const TextStyle(
                                  color: goldAccent,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: status == 'Available'
                                      ? Colors.green.withOpacity(0.16)
                                      : goldAccent.withOpacity(0.16),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: status == 'Available'
                                        ? Colors.greenAccent
                                        : goldAccent,
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => _goEditRoom(originalIndex),
                          icon: const Icon(Icons.edit_outlined, color: goldAccent, size: 20),
                        ),
                        IconButton(
                          onPressed: () => _deleteRoom(originalIndex),
                          icon: const Icon(Icons.delete_outline, color: Colors.white54, size: 20),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}