import 'package:flutter/material.dart';

const Color navyBg = Color(0xFF0A0F1E);
const Color navyCard = Color(0xFF131B2E);
const Color navyElevated = Color(0xFF1A243D);
const Color goldAccent = Color(0xFFC6A15B);

class HotelServiceItem {
  final String id;
  final String title; // Magac qurux badan oo huteel ku habboon
  final String subtitle;
  final String category; // 'Wellness & Spa', 'Pool & Leisure', 'Dining & Cafeteria', 'Care & Laundry'
  final String hours;
  final String priceLabel;
  final String image;
  final String badge;
  final String description;
  final List<String> highlights;

  const HotelServiceItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.hours,
    required this.priceLabel,
    required this.image,
    required this.badge,
    required this.description,
    required this.highlights,
  });
}

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  String selectedCategory = 'All';

  final List<String> categories = const [
    'All',
    'Wellness & Spa',
    'Pool & Leisure',
    'Dining & Cafeteria',
    'Care & Laundry',
  ];

  final List<HotelServiceItem> services = const [
    HotelServiceItem(
      id: 'SRV-01',
      title: 'Royal Thermal Sanctuary',
      subtitle: 'Aromatherapy, Steam & Calm Restoration',
      category: 'Wellness & Spa',
      hours: '08:00 AM – 10:00 PM',
      priceLabel: '\$65 / session',
      image: 'assets/images/image18.jpg',
      badge: 'SIGNATURE SPA',
      description:
          'Escape into deep relaxation with warm herbal oils, steam therapy, and private wellness suites tailored for peaceful recovery.',
      highlights: [
        'Private Steam & Sauna Access',
        'Organic Essential Oils',
        'Complimentary Herbal Tea',
      ],
    ),
    HotelServiceItem(
      id: 'SRV-02',
      title: 'Azure Infinity Pool Deck',
      subtitle: 'Heated Panoramic Water & Sun Loungers',
      category: 'Pool & Leisure',
      hours: '06:30 AM – 09:00 PM',
      priceLabel: 'Complimentary / \$25 Guest',
      image: 'assets/images/image6.jpg',
      badge: 'POOL LOUNGE',
      description:
          'Unwind beside crystal-clear water with shaded cabanas, poolside refreshments, and a serene atmosphere day or night.',
      highlights: [
        'Temperature-Controlled Pool',
        'Reserved Sun Loungers & Towels',
        'Poolside Refreshment Service',
      ],
    ),
    HotelServiceItem(
      id: 'SRV-03',
      title: 'Golden Roast Cafeteria',
      subtitle: 'Artisan Coffee, Fresh Pastries & Light Bites',
      category: 'Dining & Cafeteria',
      hours: '06:00 AM – 11:30 PM',
      priceLabel: 'From \$8',
      image: 'assets/images/image11.jpg',
      badge: 'CAFETERIA & BARISTA',
      description:
          'Enjoy freshly brewed specialty coffee, warm bakery selections, smoothies, and curated snacks in a refined lounge setting.',
      highlights: [
        'Specialty Espresso & Tea',
        'Freshly Baked Croissants & Snacks',
        'Quiet Reading & Lounge Seating',
      ],
    ),
    HotelServiceItem(
      id: 'SRV-04',
      title: 'Imperial Garment Care',
      subtitle: 'Same-Day Wash, Press & Delicate Fabric Care',
      category: 'Care & Laundry',
      hours: '07:00 AM – 08:00 PM',
      priceLabel: 'From \$12 / bag',
      image: 'assets/images/image17.jpg',
      badge: 'EXPRESS LAUNDRY',
      description:
          'Crisp, neatly pressed attire delivered back to your room with gentle fabric-safe cleaning and express turnaround.',
      highlights: [
        'Same-Day Express Option',
        'Suit & Delicate Fabric Steaming',
        'Doorstep Pickup & Delivery',
      ],
    ),
  ];

  List<HotelServiceItem> get filteredServices {
    if (selectedCategory == 'All') return services;
    return services.where((item) => item.category == selectedCategory).toList();
  }

  void _openServiceDetail(HotelServiceItem service) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceDetailPage(service: service),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = filteredServices;

    return Scaffold(
      backgroundColor: navyBg,
      appBar: AppBar(
        backgroundColor: navyBg,
        elevation: 0,
        iconTheme: const IconThemeData(color: goldAccent),
        title: const Text(
          'ROYAL HOTEL • SERVICES',
          style: TextStyle(
            color: goldAccent,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.6,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Intro
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Curated Hotel Experiences',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Georgia',
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Dooro category si aad u aragto adeegga ku habboon oo u fur boggiisa gaarka ah.',
                  style: TextStyle(color: Colors.white60, fontSize: 12.5),
                ),
              ],
            ),
          ),

          // 1. CATEGORIES BAR
          SizedBox(
            height: 42,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = cat == selectedCategory;

                return GestureDetector(
                  onTap: () => setState(() => selectedCategory = cat),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: isSelected ? goldAccent : navyCard,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? goldAccent : goldAccent.withOpacity(0.28),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: isSelected ? navyBg : Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 14),

          // 2. CARDS LIST (NAQSHAD XIRFAD LEH OO UU CLICK-GU U FURAYO BOG U GAAR AH)
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final item = list[index];
                return _buildServiceCard(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(HotelServiceItem item) {
    return GestureDetector(
      onTap: () => _openServiceDetail(item),
      child: Container(
        decoration: BoxDecoration(
          color: navyCard,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: goldAccent.withOpacity(0.28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sawirka & Badge-ka sare
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                  child: Image.asset(
                    item.image,
                    height: 155,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 155,
                      color: navyElevated,
                      alignment: Alignment.center,
                      child: const Icon(Icons.hotel, color: goldAccent, size: 36),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: navyBg.withOpacity(0.88),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: goldAccent.withOpacity(0.6)),
                    ),
                    child: Text(
                      item.badge,
                      style: const TextStyle(
                        color: goldAccent,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: goldAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.priceLabel,
                      style: const TextStyle(
                        color: navyBg,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Faahfaahinta kaarka
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.category.toUpperCase(),
                    style: TextStyle(
                      color: goldAccent.withOpacity(0.85),
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Georgia',
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.subtitle,
                    style: const TextStyle(color: Colors.white60, fontSize: 12.5),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.schedule, color: goldAccent, size: 15),
                      const SizedBox(width: 6),
                      Text(
                        item.hours,
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: navyElevated,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(color: goldAccent.withOpacity(0.5)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Open Page',
                              style: TextStyle(
                                color: goldAccent,
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward_ios, color: goldAccent, size: 11),
                          ],
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

// =========================================================================
// 3. BOGGA GAARKA AH EE ADEEG KASTA MARKA LA CLICK DHAHDO
// =========================================================================
class ServiceDetailPage extends StatefulWidget {
  final HotelServiceItem service;

  const ServiceDetailPage({super.key, required this.service});

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  String selectedSlot = '10:00 AM';
  int quantity = 1;
  final TextEditingController _noteController = TextEditingController();

  final List<String> timeSlots = const [
    '08:00 AM',
    '10:00 AM',
    '02:00 PM',
    '06:00 PM',
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _confirmRequest() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: navyElevated,
        content: Text(
          '${widget.service.title} ($quantity) — Waqtiga $selectedSlot waa la xaqiijiyey!',
          style: const TextStyle(color: goldAccent),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.service;

    return Scaffold(
      backgroundColor: navyBg,
      appBar: AppBar(
        backgroundColor: navyBg,
        elevation: 0,
        iconTheme: const IconThemeData(color: goldAccent),
        title: Text(
          s.title,
          style: const TextStyle(
            color: goldAccent,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                s.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: navyElevated,
                  alignment: Alignment.center,
                  child: const Icon(Icons.hotel, color: goldAccent, size: 42),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: navyCard,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: goldAccent.withOpacity(0.5)),
                  ),
                  child: Text(
                    s.category,
                    style: const TextStyle(
                      color: goldAccent,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  s.priceLabel,
                  style: const TextStyle(
                    color: goldAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Text(
              s.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Georgia',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Hours: ${s.hours}',
              style: const TextStyle(color: Colors.white60, fontSize: 12.5),
            ),
            const SizedBox(height: 12),

            Text(
              s.description,
              style: const TextStyle(color: Colors.white70, fontSize: 13.5, height: 1.45),
            ),
            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: navyCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Included Highlights',
                    style: TextStyle(
                      color: goldAccent,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...s.highlights.map(
                    (h) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: goldAccent, size: 15),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              h,
                              style: const TextStyle(color: Colors.white, fontSize: 12.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            const Text(
              'Select Preferred Time',
              style: TextStyle(color: Colors.white, fontSize: 13.5, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: timeSlots.map((slot) {
                final active = slot == selectedSlot;
                return GestureDetector(
                  onTap: () => setState(() => selectedSlot = slot),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: active ? goldAccent : navyCard,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: active ? goldAccent : goldAccent.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      slot,
                      style: TextStyle(
                        color: active ? navyBg : Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quantity / Guests',
                  style: TextStyle(color: Colors.white, fontSize: 13.5, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (quantity > 1) setState(() => quantity--);
                      },
                      icon: const Icon(Icons.remove_circle_outline, color: goldAccent),
                    ),
                    Text(
                      '$quantity',
                      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => setState(() => quantity++),
                      icon: const Icon(Icons.add_circle_outline, color: goldAccent),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _noteController,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Room number ama fariin gaar ah (optional)...',
                hintStyle: const TextStyle(color: Colors.white38, fontSize: 12.5),
                filled: true,
                fillColor: navyElevated,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(color: Colors.white12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(color: goldAccent),
                ),
              ),
            ),
            const SizedBox(height: 22),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldAccent,
                  foregroundColor: navyBg,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _confirmRequest,
                child: const Text(
                  'Confirm Service Request',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}