import 'package:flutter/material.dart';

const Color navyBg = Color(0xFF0A0F1E);
const Color navyCard = Color(0xFF131B2E);
const Color navyElevated = Color(0xFF1A243D);
const Color goldAccent = Color(0xFFC6A15B);

class ServiceCategoryModel {
  final String name;
  final IconData icon;
  final Color iconColor;

  const ServiceCategoryModel({
    required this.name,
    required this.icon,
    required this.iconColor,
  });
}

class ServiceEntry {
  final String title;
  final String price;
  final String category;
  final String image;
  final String description;

  const ServiceEntry({
    required this.title,
    required this.price,
    required this.category,
    required this.image,
    required this.description,
  });
}

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final List<ServiceCategoryModel> categories = const [
    ServiceCategoryModel(
      name: 'Spa',
      icon: Icons.spa,
      iconColor: Colors.orange,
    ),
    ServiceCategoryModel(
      name: 'Swimming Pool',
      icon: Icons.pool,
      iconColor: Colors.lightBlueAccent,
    ),
    ServiceCategoryModel(
      name: 'Cafeteria',
      icon: Icons.local_cafe,
      iconColor: Colors.greenAccent,
    ),
    ServiceCategoryModel(
      name: 'Laundry',
      icon: Icons.local_laundry_service,
      iconColor: goldAccent,
    ),
  ];

  final List<ServiceEntry> allEntries = const [
    // SPA
    ServiceEntry(
      title: 'Aromatherapy Session',
      price: '\$45.00',
      category: 'Spa',
      image: 'assets/images/image18.jpg',
      description: 'Full relaxation therapy with warm essential oils.',
    ),
    ServiceEntry(
      title: 'Steam & Sauna Suite',
      price: '\$35.00',
      category: 'Spa',
      image: 'assets/images/image19.jpg',
      description: 'Private steam room and detox sauna experience.',
    ),

    // SWIMMING POOL
    ServiceEntry(
      title: 'Infinity Pool Pass',
      price: '\$20.00',
      category: 'Swimming Pool',
      image: 'assets/images/image6.jpg',
      description: 'Day access to heated infinity pool and loungers.',
    ),
    ServiceEntry(
      title: 'Poolside Cabana',
      price: '\$50.00',
      category: 'Swimming Pool',
      image: 'assets/images/image2.jpg',
      description: 'Shaded private cabana with towels and water service.',
    ),

    // CAFETERIA
    ServiceEntry(
      title: 'Crispy Sambuusa',
      price: '\$1.50',
      category: 'Cafeteria',
      image: 'assets/images/image11.jpg',
      description: 'Golden crispy sambuusa served hot from cafeteria.',
    ),
    ServiceEntry(
      title: 'Ice Cream & Pastry',
      price: '\$2.50',
      category: 'Cafeteria',
      image: 'assets/images/image12.jpg',
      description: 'Chilled dessert and fresh bakery treat.',
    ),

    // LAUNDRY
    ServiceEntry(
      title: 'Wash & Fold Bag',
      price: '\$12.00',
      category: 'Laundry',
      image: 'assets/images/image17.jpg',
      description: 'Gentle wash, neat folding, and room delivery.',
    ),
    ServiceEntry(
      title: 'Express Suit Pressing',
      price: '\$8.00',
      category: 'Laundry',
      image: 'assets/images/image10.jpg',
      description: 'Same-day steam press for suits and shirts.',
    ),
  ];

  String selectedCategory = 'Spa';

  List<ServiceEntry> get itemsForSelectedCategory {
    return allEntries.where((e) => e.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = itemsForSelectedCategory;

    return Scaffold(
      backgroundColor: navyBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. CATEGORIES (Sida sawirka 1aad: Icon sare + Magac hoos)
            const Text(
              'Categories',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 86,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = cat.name == selectedCategory;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = cat.name;
                      });
                    },
                    child: Container(
                      width: 155,
                      decoration: BoxDecoration(
                        color: isSelected ? navyElevated : navyCard,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? goldAccent
                              : Colors.white.withOpacity(0.14),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            cat.icon,
                            color: cat.iconColor,
                            size: 24,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cat.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // 2. EXPLORE <SELECTED CATEGORY> (Sida sawirka 2aad: Sawir bidix + Title & Price midig)
            Text(
              'Explore $selectedCategory',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = items[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ServiceItemDetailPage(item: item),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: navyCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.12),
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item.image,
                            width: 68,
                            height: 54,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 68,
                              height: 54,
                              color: navyElevated,
                              child: const Icon(
                                Icons.hotel,
                                color: goldAccent,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.price,
                                style: const TextStyle(
                                  color: goldAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Bogga gaarka ah marka mid ka mid ah items-ka la click siiyo
class ServiceItemDetailPage extends StatelessWidget {
  final ServiceEntry item;

  const ServiceItemDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navyBg,
      appBar: AppBar(
        backgroundColor: navyBg,
        elevation: 0,
        iconTheme: const IconThemeData(color: goldAccent),
        title: Text(
          item.title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                item.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: navyCard,
                  alignment: Alignment.center,
                  child: const Icon(Icons.hotel, color: goldAccent, size: 38),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.price,
              style: const TextStyle(
                color: goldAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.45,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldAccent,
                  foregroundColor: navyBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: navyElevated,
                      content: Text(
                        '${item.title} (${item.price}) waa la dalbaday!',
                        style: const TextStyle(color: goldAccent),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Order Now',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}