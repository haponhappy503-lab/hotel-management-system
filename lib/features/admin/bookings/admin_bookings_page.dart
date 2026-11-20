import 'package:flutter/material.dart';
import 'booking_details_page.dart';

class AdminBookingsPage extends StatefulWidget {
  const AdminBookingsPage({super.key});

  @override
  State<AdminBookingsPage> createState() => _AdminBookingsPageState();
}

class _AdminBookingsPageState extends State<AdminBookingsPage> {
  static const Color navy = Color(0xFF173B63);
  static const Color blue = Color(0xFF397CC0);
  static const Color bg = Color(0xFF090B0F);
  static const Color card = Color(0xFF11151B);
  static const Color muted = Color(0xFF858D99);
  static const Color white = Color(0xFFF3F5F8);

  String selectedFilter = 'All';
  String searchText = '';

  final List<String> filters = const [
    'All',
    'Confirmed',
    'Pending',
    'Checked in',
    'Cancelled',
  ];

  final List bookingsList = [
    {
      'initials': 'HA',
      'guest': 'Hassan Ali',
      'room': 'Deluxe Room',
      'date': 'Nov 21',
      'amount': '\$180',
      'status': 'Confirmed',
    },
    {
      'initials': 'FA',
      'guest': 'Fatima Ahmed',
      'room': 'Executive Suite',
      'date': 'Nov 22',
      'amount': '\$320',
      'status': 'Pending',
    },
    {
      'initials': 'MA',
      'guest': 'Mohamed Abdi',
      'room': 'Standard Room',
      'date': 'Nov 23',
      'amount': '\$120',
      'status': 'Confirmed',
    },
    {
      'initials': 'SA',
      'guest': 'Sahra Yusuf',
      'room': 'Family Room',
      'date': 'Nov 24',
      'amount': '\$260',
      'status': 'Checked in',
    },
    {
      'initials': 'OA',
      'guest': 'Omar Ahmed',
      'room': 'Deluxe Room',
      'date': 'Nov 25',
      'amount': '\$180',
      'status': 'Pending',
    },
  ];

  List get filteredBookings {
    return bookingsList.where((b) {
      final matchesStatus =
          selectedFilter == 'All' || b['status'] == selectedFilter;
      final query = searchText.trim().toLowerCase();
      final matchesSearch = query.isEmpty ||
          (b['guest'] ?? '').toLowerCase().contains(query) ||
          (b['room'] ?? '').toLowerCase().contains(query);
      return matchesStatus && matchesSearch;
    }).toList();
  }

  Color _badgeColor(String status) {
    if (status == 'Confirmed' || status == 'Checked in') {
      return const Color(0xFF83B5E4);
    } else if (status == 'Cancelled') {
      return const Color(0xFFE07A7A);
    }
    return const Color(0xFFC3A46D);
  }

  Future<void> _openDetails(Map<String, String> item) async {
    final index = bookingsList.indexOf(item);
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingDetailsPage(booking: item),
      ),
    );
    if (updated != null && index != -1) {
      setState(() {
        bookingsList[index] = updated;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = filteredBookings;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        iconTheme: const IconThemeData(color: white),
        title: const Text(
          'Bookings Management',
          style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
            child: TextField(
              onChanged: (v) => setState(() => searchText = v),
              style: const TextStyle(color: white, fontSize: 12.5),
              decoration: InputDecoration(
                hintText: 'Search guest or room...',
                hintStyle: const TextStyle(color: muted, fontSize: 12),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF8DB9E5), size: 20),
                filled: true,
                fillColor: card,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
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
                    padding: const EdgeInsets.symmetric(horizontal: 13),
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
            child: items.isEmpty
                ? const Center(
                    child: Text(
                      'No matching bookings found.',
                      style: TextStyle(color: muted, fontSize: 12.5),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final b = items[index];
                      final status = b['status'] ?? 'Pending';
                      final badgeColor = _badgeColor(status);

                      return InkWell(
                        onTap: () => _openDetails(b),
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
                                radius: 18,
                                backgroundColor: navy.withOpacity(.45),
                                child: Text(
                                  b['initials'] ?? 'G',
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
                                      b['guest'] ?? '',
                                      style: const TextStyle(
                                        color: white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${b['room']}  •  ${b['date']}',
                                      style: const TextStyle(color: muted, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    b['amount'] ?? '',
                                    style: const TextStyle(
                                      color: white,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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