import 'package:flutter/material.dart';

class AdminServicesPage extends StatefulWidget {
  const AdminServicesPage({super.key});

  @override
  State<AdminServicesPage> createState() => _AdminServicesPageState();
}

class _AdminServicesPageState extends State<AdminServicesPage> {
  static const Color navy = Color(0xFF173B63);
  static const Color blue = Color(0xFF397CC0);
  static const Color bg = Color(0xFF090B0F);
  static const Color card = Color(0xFF11151B);
  static const Color muted = Color(0xFF858D99);
  static const Color white = Color(0xFFF3F5F8);

  String selectedFilter = 'All';
  String searchQuery = '';

  final List<String> filters = const [
    'All',
    'Available',
    'Unavailable',
  ];

  final List<String> categories = const [
    'Dining',
    'Spa',
    'Transport',
    'Laundry',
  ];

  List services = [
    {
      'code': 'SRV-01',
      'name': '24/7 Room Dining',
      'category': 'Dining',
      'price': '\$25',
      'schedule': '24 Hours',
      'status': 'Available',
    },
    {
      'code': 'SRV-02',
      'name': 'Airport VIP Pickup',
      'category': 'Transport',
      'price': '\$40',
      'schedule': 'On Request',
      'status': 'Available',
    },
    {
      'code': 'SRV-03',
      'name': 'Royal Wellness Spa',
      'category': 'Spa',
      'price': '\$65',
      'schedule': '09:00 - 22:00',
      'status': 'Available',
    },
    {
      'code': 'SRV-04',
      'name': 'Express Laundry & Press',
      'category': 'Laundry',
      'price': '\$15',
      'schedule': 'Same Day',
      'status': 'Unavailable',
    },
  ];

  List get filteredServices {
    return services.where((s) {
      final matchesFilter =
          selectedFilter == 'All' || s['status'] == selectedFilter;
      final q = searchQuery.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          (s['name'] ?? '').toLowerCase().contains(q) ||
          (s['category'] ?? '').toLowerCase().contains(q) ||
          (s['code'] ?? '').toLowerCase().contains(q);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  IconData _categoryIcon(String? category) {
    switch (category ?? '') {
      case 'Dining':
        return Icons.restaurant_menu_outlined;
      case 'Spa':
        return Icons.spa_outlined;
      case 'Transport':
        return Icons.local_taxi_outlined;
      case 'Laundry':
        return Icons.local_laundry_service_outlined;
      default:
        return Icons.room_service_outlined;
    }
  }

  Color _statusColor(String? status) {
    if (status == 'Available') {
      return const Color(0xFF83B5E4);
    }
    return const Color(0xFFE07A7A);
  }

  void _showAddServiceDialog() {
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController(text: '\$20');
    final scheduleCtrl = TextEditingController(text: '24 Hours');
    String selectedCategory = 'Dining';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: card,
              title: const Text(
                'Add Hotel Service',
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
                      labelText: 'Service Name',
                      labelStyle: TextStyle(color: muted, fontSize: 11),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    dropdownColor: card,
                    style: const TextStyle(color: white, fontSize: 12),
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      labelStyle: TextStyle(color: muted, fontSize: 11),
                    ),
                    items: categories
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setDialogState(() => selectedCategory = val);
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: priceCtrl,
                    style: const TextStyle(color: white, fontSize: 12),
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      labelStyle: TextStyle(color: muted, fontSize: 11),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: scheduleCtrl,
                    style: const TextStyle(color: white, fontSize: 12),
                    decoration: const InputDecoration(
                      labelText: 'Availability / Hours',
                      labelStyle: TextStyle(color: muted, fontSize: 11),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel', style: TextStyle(color: muted)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    foregroundColor: white,
                  ),
                  onPressed: () {
                    if (nameCtrl.text.trim().isEmpty) return;
                    final nextNum = services.length + 1;
                    final code = 'SRV-${nextNum.toString().padLeft(2, '0')}';
                    setState(() {
                      services = [
                        {
                          'code': code,
                          'name': nameCtrl.text.trim(),
                          'category': selectedCategory,
                          'price': priceCtrl.text.trim().isEmpty
                              ? '\$20'
                              : priceCtrl.text.trim(),
                          'schedule': scheduleCtrl.text.trim().isEmpty
                              ? '24 Hours'
                              : scheduleCtrl.text.trim(),
                          'status': 'Available',
                        },
                        ...services,
                      ];
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _openServiceSheet(Map<String, String> service) {
    final index = services.indexOf(service);
    String currentStatus = service['status'] ?? 'Available';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: Color(0xFF202832)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final badgeColor = _statusColor(currentStatus);

            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2B3440),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          color: navy.withOpacity(.45),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _categoryIcon(service['category']),
                          color: const Color(0xFF8DB9E5),
                          size: 21,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service['name'] ?? 'Service',
                              style: const TextStyle(
                                color: white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${service['code'] ?? ''}  •  ${service['category'] ?? ''}',
                              style: const TextStyle(color: muted, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: badgeColor.withOpacity(.14),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          currentStatus,
                          style: TextStyle(
                            color: badgeColor,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFF202832), height: 1),
                  const SizedBox(height: 14),
                  _detailRow('Price', service['price'] ?? '\$0'),
                  const SizedBox(height: 10),
                  _detailRow('Schedule', service['schedule'] ?? '-'),
                  const SizedBox(height: 16),
                  const Text(
                    'Service Availability',
                    style: TextStyle(color: muted, fontSize: 11),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['Available', 'Unavailable'].map((s) {
                      final active = currentStatus == s;
                      return ChoiceChip(
                        label: Text(s),
                        selected: active,
                        selectedColor: blue,
                        backgroundColor: const Color(0xFF161B22),
                        labelStyle: TextStyle(
                          color: active ? white : muted,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                        onSelected: (_) {
                          setModalState(() => currentStatus = s);
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        foregroundColor: white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (index != -1) {
                          setState(() {
                            services[index] = {
                              ...service,
                              'status': currentStatus,
                            };
                          });
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Save Service Status',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: muted, fontSize: 11.5)),
        Text(
          value,
          style: const TextStyle(
            color: white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = filteredServices;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        iconTheme: const IconThemeData(color: white),
        title: const Text(
          'Hotel Services',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _showAddServiceDialog,
            icon: const Icon(Icons.add_circle_outline, color: Color(0xFF8DB9E5)),
            tooltip: 'Add Service',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
            child: TextField(
              onChanged: (v) => setState(() => searchQuery = v),
              style: const TextStyle(color: white, fontSize: 12.5),
              decoration: InputDecoration(
                hintText: 'Search service by name, category or code...',
                hintStyle: const TextStyle(color: muted, fontSize: 12),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF8DB9E5),
                  size: 20,
                ),
                filled: true,
                fillColor: card,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 11,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF202832)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF202832)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: blue),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 36,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final f = filters[i];
                final selected = selectedFilter == f;
                return GestureDetector(
                  onTap: () => setState(() => selectedFilter = f),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected ? blue : card,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: selected ? blue : const Color(0xFF202832),
                      ),
                    ),
                    child: Text(
                      f,
                      style: TextStyle(
                        color: selected ? white : muted,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: list.isEmpty
                ? const Center(
                    child: Text(
                      'No services found.',
                      style: TextStyle(color: muted, fontSize: 12.5),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final s = list[index];
                      final status = s['status'] ?? 'Available';
                      final badgeColor = _statusColor(status);

                      return InkWell(
                        onTap: () => _openServiceSheet(s),
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
                                  _categoryIcon(s['category']),
                                  color: const Color(0xFF8DB9E5),
                                  size: 19,
                                ),
                              ),
                              const SizedBox(width: 11),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      s['name'] ?? '',
                                      style: const TextStyle(
                                        color: white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${s['category'] ?? ''}  •  ${s['schedule'] ?? ''}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: muted,
                                        fontSize: 10.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    s['price'] ?? '\$0',
                                    style: const TextStyle(
                                      color: white,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: badgeColor.withOpacity(.14),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                        color: badgeColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
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