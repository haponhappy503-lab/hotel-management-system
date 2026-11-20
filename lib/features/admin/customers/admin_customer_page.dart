import 'package:flutter/material.dart';

class AdminCustomerPage extends StatefulWidget {
  const AdminCustomerPage({super.key});

  @override
  State<AdminCustomerPage> createState() => _AdminCustomerPageState();
}

class _AdminCustomerPageState extends State<AdminCustomerPage> {
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
    'Active',
    'VIP',
    'Blocked',
  ];

  final List<String> statuses = const [
    'Active',
    'VIP',
    'Blocked',
  ];

  final List<Map<String, String>> customers = [
    {
      'initials': 'HA',
      'name': 'Hassan Ali',
      'email': 'hassan.ali@royalhotel.com',
      'phone': '+252 63 4112233',
      'bookings': '5',
      'spent': '\$1,450',
      'status': 'VIP',
    },
    {
      'initials': 'FA',
      'name': 'Fatima Ahmed',
      'email': 'fatima.ahmed@royalhotel.com',
      'phone': '+252 63 4556677',
      'bookings': '2',
      'spent': '\$640',
      'status': 'Active',
    },
    {
      'initials': 'MA',
      'name': 'Mohamed Abdi',
      'email': 'mohamed.abdi@royalhotel.com',
      'phone': '+252 63 4889900',
      'bookings': '4',
      'spent': '\$980',
      'status': 'Active',
    },
    {
      'initials': 'SY',
      'name': 'Sahra Yusuf',
      'email': 'sahra.yusuf@royalhotel.com',
      'phone': '+252 63 4223344',
      'bookings': '6',
      'spent': '\$2,120',
      'status': 'VIP',
    },
    {
      'initials': 'OA',
      'name': 'Omar Ahmed',
      'email': 'omar.ahmed@royalhotel.com',
      'phone': '+252 63 4778899',
      'bookings': '1',
      'spent': '\$180',
      'status': 'Blocked',
    },
  ];

  List get filteredCustomers {
    return customers.where((c) {
      final matchesFilter =
          selectedFilter == 'All' || c['status'] == selectedFilter;
      final q = searchQuery.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          (c['name'] ?? '').toLowerCase().contains(q) ||
          (c['email'] ?? '').toLowerCase().contains(q) ||
          (c['phone'] ?? '').toLowerCase().contains(q);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  Color _statusColor(String status) {
    if (status == 'VIP') {
      return const Color(0xFFC3A46D);
    } else if (status == 'Blocked') {
      return const Color(0xFFE07A7A);
    }
    return const Color(0xFF83B5E4);
  }

  void _openCustomerDetails(Map<String, String> customer) {
    final index = customers.indexOf(customer);
    String currentStatus = customer['status'] ?? 'Active';

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
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: navy.withOpacity(.45),
                        child: Text(
                          customer['initials'] ?? 'GU',
                          style: const TextStyle(
                            color: Color(0xFF8DB9E5),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              customer['name'] ?? 'Guest',
                              style: const TextStyle(
                                color: white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              customer['email'] ?? '',
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
                  _detailRow('Phone Number', customer['phone'] ?? ''),
                  const SizedBox(height: 10),
                  _detailRow(
                    'Total Bookings',
                    '${customer['bookings'] ?? '0'} stays',
                  ),
                  const SizedBox(height: 10),
                  _detailRow('Total Spent', customer['spent'] ?? '\$0'),
                  const SizedBox(height: 16),
                  const Text(
                    'Account Status',
                    style: TextStyle(color: muted, fontSize: 11),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: statuses.map((s) {
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
                            customers[index] = {
                              ...customer,
                              'status': currentStatus,
                            };
                          });
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Save Customer Status',
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
    final list = filteredCustomers;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        iconTheme: const IconThemeData(color: white),
        title: const Text(
          'Customers Management',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
            child: TextField(
              onChanged: (v) => setState(() => searchQuery = v),
              style: const TextStyle(color: white, fontSize: 12.5),
              decoration: InputDecoration(
                hintText: 'Search customer by name, email or phone...',
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
                      'No customers found.',
                      style: TextStyle(color: muted, fontSize: 12.5),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final c = list[index];
                      final status = c['status'] ?? 'Active';
                      final badgeColor = _statusColor(status);

                      return InkWell(
                        onTap: () => _openCustomerDetails(c),
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
                              CircleAvatar(
                                radius: 19,
                                backgroundColor: navy.withOpacity(.45),
                                child: Text(
                                  c['initials'] ?? 'C',
                                  style: const TextStyle(
                                    color: Color(0xFF8DB9E5),
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 11),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      c['name'] ?? '',
                                      style: const TextStyle(
                                        color: white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${c['email']}  •  ${c['bookings']} stays',
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
                                    c['spent'] ?? '\$0',
                                    style: const TextStyle(
                                      color: white,
                                      fontSize: 12,
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