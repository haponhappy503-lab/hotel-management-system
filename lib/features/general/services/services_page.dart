import 'package:flutter/material.dart';

const Color darkNavy = Color(0xFF0D0F14);
const Color cardBg = Color(0xFF1E222D);
const Color goldAccent = Color(0xFFC6A15B);

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final servicesList = [
      {
        'title': 'Fine Dining & Restaurant',
        'desc': 'Exquisite gourmet meals and tasty dishes.',
        'image': 'assets/images/image10.jpg',
      },
      {
        'title': 'Luxury Spa & Wellness',
        'desc': 'Relax your mind and body with professional therapies.',
        'image': 'assets/images/image18.jpg',
      },
      {
        'title': 'Fitness & Gym Center',
        'desc': 'Stay active with modern workout equipment.',
        'image': 'assets/images/image13.jpg',
      },
      {
        'title': '24/7 Room Service',
        'desc': 'Prompt and dedicated round-the-clock service.',
        'image': 'assets/images/image3.jpg',
      },
      {
        'title': 'Fresh Snacks & Lounge',
        'desc': 'Enjoy snacks, drinks, and cozy atmosphere.',
        'image': 'assets/images/image11.jpg',
      },
      {
        'title': 'Pool & Recreation',
        'desc': 'Refresh yourself in our luxury swimming pool area.',
        'image': 'assets/images/image6.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: darkNavy,
      appBar: AppBar(
        backgroundColor: darkNavy,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'OUR SERVICES',
          style: TextStyle(
            color: goldAccent,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hotel Amenities & Services',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Explore everything we offer to make your stay unforgettable.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // ListView oo adeegsanaysa card nadiif ah oo aan dhaa-dhaadhnayn
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: servicesList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final service = servicesList[index];
                return _buildServiceCard(
                  title: service['title']!,
                  description: service['desc']!,
                  image: service['image']!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String description,
    required String image,
  }) {
    return Container(
      height: 110, // Dherer go'an oo nadiif ah (Compact)
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          // Sawirka oo dhinaca bidix ah
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.asset(
              image,
              width: 120,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          // Qoraalka iyo Faahfaahinta
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          // Icon yar oo quruxda u kordhinaysa dhinaca midig
          const Padding(
            padding: EdgeInsets.only(right: 14.0),
            child: Icon(
              Icons.arrow_forward_ios,
              color: goldAccent,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }
}