import 'package:flutter/material.dart';

const Color navyBg = Color(0xFF0A0F1E);
const Color navyCard = Color(0xFF131B2E);
const Color navyElevated = Color(0xFF1A243D);
const Color goldAccent = Color(0xFFC6A15B);

class RoomDetailsPage extends StatelessWidget {
  final Map<String, dynamic> room;

  const RoomDetailsPage({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    final String name = (room['name'] ?? 'Royal Room').toString();
    final String category = (room['category'] ?? 'Suite').toString();
    final String price = (room['price'] ?? '\$200 / night').toString();
    final String status = (room['status'] ?? 'Available').toString();
    final String image = (room['image'] ?? 'assets/images/image6.jpg').toString();
    final String description = (room['description'] ??
            'Spacious navy-and-gold room designed for comfort, privacy, and royal hospitality.')
        .toString();

    return Scaffold(
      backgroundColor: navyBg,
      appBar: AppBar(
        backgroundColor: navyBg,
        elevation: 0,
        iconTheme: const IconThemeData(color: goldAccent),
        title: const Text(
          'ROOM DETAILS',
          style: TextStyle(
            color: goldAccent,
            fontSize: 14.5,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.6,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                image,
                height: 210,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 210,
                  color: navyCard,
                  alignment: Alignment.center,
                  child: const Icon(Icons.king_bed, color: goldAccent, size: 42),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: navyCard,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: goldAccent.withOpacity(0.5)),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      color: goldAccent,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: status == 'Available'
                        ? Colors.green.withOpacity(0.16)
                        : goldAccent.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: status == 'Available' ? Colors.greenAccent : goldAccent,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Georgia',
              ),
            ),
            const SizedBox(height: 6),
            Text(
              price,
              style: const TextStyle(
                color: goldAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: navyCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white10),
              ),
              child: Text(
                description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13.5,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}