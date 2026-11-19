import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  static const Color navy = Color(0xFF173B63);
  static const Color blue = Color(0xFF397CC0);
  static const Color bg = Color(0xFF090B0F);
  static const Color card = Color(0xFF11151B);
  static const Color muted = Color(0xFF858D99);
  static const Color white = Color(0xFFF3F5F8);

  int selectedTab = 0;
  String selectedPeriod = '7D';

  // Liiska qolalka uu Admin-ku maareynayo (waa la beddeli karaa / la kordhin karaa)
  List<ManagedRoom> managedRooms = [
    const ManagedRoom(
      id: 'RM-101',
      name: 'Royal Luxury Suite',
      category: 'Suite',
      price: '\$350 / night',
      status: 'Available',
    ),
    const ManagedRoom(
      id: 'RM-204',
      name: 'Deluxe Ocean View',
      category: 'Deluxe',
      price: '\$180 / night',
      status: 'Occupied',
    ),
    const ManagedRoom(
      id: 'RM-305',
      name: 'Grand Royal Penthouse',
      category: 'Penthouse',
      price: '\$500 / night',
      status: 'Available',
    ),
    const ManagedRoom(
      id: 'RM-108',
      name: 'Executive Double',
      category: 'Standard',
      price: '\$120 / night',
      status: 'Maintenance',
    ),
  ];

  final bookings = const [
    Booking('HA', 'Hassan Ali', 'Deluxe Room', 'Nov 21', '\$180', 'Confirmed'),
    Booking('FA', 'Fatima Ahmed', 'Executive Suite', 'Nov 22', '\$320', 'Pending'),
    Booking('MA', 'Mohamed Abdi', 'Standard Room', 'Nov 23', '\$120', 'Confirmed'),
    Booking('SA', 'Sahra Yusuf', 'Family Room', 'Nov 24', '\$260', 'Checked in'),
    Booking('OA', 'Omar Ahmed', 'Deluxe Room', 'Nov 25', '\$180', 'Pending'),
  ];

  void _openManageRoomsSheet() {
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
            return DraggableScrollableSheet(
              initialChildSize: 0.72,
              minChildSize: 0.45,
              maxChildSize: 0.92,
              expand: false,
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
                  child: Column(
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
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Manage Rooms',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Click a room to toggle status or edit',
                                  style: TextStyle(color: muted, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blue,
                              foregroundColor: white,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => _showAddRoomDialog(setModalState),
                            icon: const Icon(Icons.add, size: 16),
                            label: const Text(
                              'Add Room',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          itemCount: managedRooms.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final room = managedRooms[index];
                            Color badgeColor;
                            if (room.status == 'Available') {
                              badgeColor = const Color(0xFF83B5E4);
                            } else if (room.status == 'Occupied') {
                              badgeColor = const Color(0xFFC3A46D);
                            } else {
                              badgeColor = const Color(0xFFE07A7A);
                            }

                            return InkWell(
                              borderRadius: BorderRadius.circular(13),
                              onTap: () {
                                final nextStatus = room.status == 'Available'
                                    ? 'Occupied'
                                    : room.status == 'Occupied'
                                        ? 'Maintenance'
                                        : 'Available';

                                setState(() {
                                  managedRooms[index] = room.copyWith(status: nextStatus);
                                });
                                setModalState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF161B22),
                                  borderRadius: BorderRadius.circular(13),
                                  border: Border.all(color: const Color(0xFF232C38)),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 38,
                                      width: 38,
                                      decoration: BoxDecoration(
                                        color: navy.withOpacity(.35),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.bed_outlined,
                                        color: Color(0xFF8DB9E5),
                                        size: 19,
                                      ),
                                    ),
                                    const SizedBox(width: 11),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${room.name} (${room.id})',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            '${room.category}  •  ${room.price}',
                                            style: const TextStyle(
                                              color: muted,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: badgeColor.withOpacity(.14),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Text(
                                        room.status,
                                        style: TextStyle(
                                          color: badgeColor,
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
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
              },
            );
          },
        );
      },
    );
  }

  void _showAddRoomDialog(StateSetter setModalState) {
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController(text: '\$150 / night');
    String category = 'Deluxe';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: card,
        title: const Text(
          'Add New Room',
          style: TextStyle(color: white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              style: const TextStyle(color: white, fontSize: 12),
              decoration: const InputDecoration(
                labelText: 'Room Name',
                labelStyle: TextStyle(color: muted, fontSize: 11),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceCtrl,
              style: const TextStyle(color: white, fontSize: 12),
              decoration: const InputDecoration(
                labelText: 'Price per night',
                labelStyle: TextStyle(color: muted, fontSize: 11),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: category,
              dropdownColor: card,
              style: const TextStyle(color: white, fontSize: 12),
              decoration: const InputDecoration(
                labelText: 'Category',
                labelStyle: TextStyle(color: muted, fontSize: 11),
              ),
              items: ['Standard', 'Deluxe', 'Suite', 'Penthouse']
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (val) {
                if (val != null) category = val;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: muted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: blue, foregroundColor: white),
            onPressed: () {
              if (nameCtrl.text.trim().isEmpty) return;
              final newRoom = ManagedRoom(
                id: 'RM-${110 + managedRooms.length}',
                name: nameCtrl.text.trim(),
                category: category,
                price: priceCtrl.text.trim().isEmpty ? '\$150 / night' : priceCtrl.text.trim(),
                status: 'Available',
              );
              setState(() {
                managedRooms = [newRoom, ...managedRooms];
              });
              setModalState(() {});
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _onManagementTap(String title) {
    if (title == 'Manage Rooms') {
      _openManageRoomsSheet();
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF161B22),
        behavior: SnackBarBehavior.floating,
        content: Text(
          '$title — Waa la furay (diyaar u ah in lagu xiro boggiisa).',
          style: const TextStyle(color: Color(0xFF8DB9E5), fontSize: 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final wide = constraints.maxWidth > 650;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _statistics(wide),
                            const SizedBox(height: 15),
                            _performance(),
                            const SizedBox(height: 15),
                            _recentBookings(),
                            const SizedBox(height: 18),
                            _management(wide),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            _bottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 15, 18, 10),
      child: Row(
        children: [
          _iconButton(Icons.menu_rounded, () {}),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hotel Overview',
                  style: TextStyle(
                    color: white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Royal Hotel management dashboard',
                  style: TextStyle(color: muted, fontSize: 10),
                ),
              ],
            ),
          ),
          _iconButton(Icons.tune_rounded, () {}),
        ],
      ),
    );
  }

  Widget _statistics(bool wide) {
    final metrics = [
      Metric(
        'TOTAL REVENUE',
        '\$24.8K',
        'This month',
        '+12.4%',
        Icons.account_balance_wallet_outlined,
        [0.3, 0.5, 0.4, 0.7, 0.5, 0.8, 0.7, 0.9],
      ),
      Metric(
        'ROOM OCCUPANCY',
        '78.6%',
        'Occupied rooms',
        '+5.8%',
        Icons.bed_outlined,
        [0.2, 0.4, 0.3, 0.6, 0.5, 0.7, 0.8, 0.9],
      ),
      Metric(
        'TOTAL BOOKINGS',
        '184',
        'This month',
        '+8.7%',
        Icons.calendar_month_outlined,
        [0.3, 0.4, 0.3, 0.6, 0.5, 0.7, 0.8, 0.9],
      ),
      Metric(
        'ACTIVE CUSTOMERS',
        '126',
        'Registered guests',
        '+2.1%',
        Icons.people_alt_outlined,
        [0.2, 0.4, 0.3, 0.5, 0.4, 0.6, 0.7, 0.8],
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: metrics.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: wide ? 4 : 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 145,
      ),
      itemBuilder: (context, index) {
        return _MetricCard(metric: metrics[index]);
      },
    );
  }

  Widget _performance() {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Hotel Performance',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              DropdownButton<String>(
                value: selectedPeriod,
                dropdownColor: card,
                underline: const SizedBox(),
                style: const TextStyle(color: white, fontSize: 10),
                items: ['7D', '30D', '90D']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => selectedPeriod = value);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _legend(blue, 'Room occupancy'),
              const SizedBox(width: 18),
              _legend(const Color(0xFF60758E), 'Bookings'),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 160,
            width: double.infinity,
            child: CustomPaint(
              painter: PerformancePainter(),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _AxisLabel('Nov 13'),
              _AxisLabel('Nov 14'),
              _AxisLabel('Nov 15'),
              _AxisLabel('Nov 16'),
              _AxisLabel('Nov 17'),
              _AxisLabel('Nov 18'),
              _AxisLabel('Nov 19'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _recentBookings() {
    return _Panel(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Recent Bookings',
                  style: TextStyle(
                    color: white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All  ›',
                  style: TextStyle(color: Color(0xFF8DB9E5), fontSize: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Expanded(flex: 5, child: _HeaderText('GUEST / ROOM')),
              Expanded(flex: 2, child: _HeaderText('DATE')),
              Expanded(flex: 2, child: _HeaderText('AMOUNT')),
              SizedBox(width: 65, child: _HeaderText('STATUS')),
            ],
          ),
          const SizedBox(height: 5),
          ...bookings.map(
            (booking) => _BookingRow(booking: booking),
          ),
        ],
      ),
    );
  }

  Widget _management(bool wide) {
    final actions = [
      QuickAction(Icons.bed_outlined, 'Manage Rooms', 'Rooms & availability'),
      QuickAction(Icons.room_service_outlined, 'Hotel Services', 'Services & requests'),
      QuickAction(Icons.payments_outlined, 'Payments', 'Transactions'),
      QuickAction(Icons.people_outline, 'Customers', 'Guest accounts'),
      QuickAction(Icons.reviews_outlined, 'Reviews', 'Guest feedback'),
      QuickAction(Icons.notifications_none, 'Notifications', 'Send announcements'),
      QuickAction(Icons.analytics_outlined, 'Reports', 'Hotel analytics'),
      QuickAction(Icons.settings_outlined, 'Settings', 'Admin settings'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 11, left: 2),
          child: Text(
            'Hotel Management',
            style: TextStyle(
              color: white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: actions.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: wide ? 4 : 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 78,
          ),
          itemBuilder: (context, index) {
            final item = actions[index];

            return InkWell(
              onTap: () => _onManagementTap(item.title),
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.all(11),
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
                        color: navy.withOpacity(.3),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Icon(
                        item.icon,
                        color: const Color(0xFF8DB9E5),
                        size: 19,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: muted,
                              fontSize: 8,
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
    );
  }

  Widget _bottomNavigation() {
    final items = [
      Icons.dashboard_outlined,
      Icons.bed_outlined,
      Icons.calendar_month_outlined,
      Icons.receipt_long_outlined,
      Icons.person_outline,
    ];

    final labels = ['Home', 'Rooms', 'Bookings', 'Reports', 'Profile'];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0D1117),
        border: Border(
          top: BorderSide(color: Color(0xFF202832)),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(8, 9, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final active = selectedTab == i;

          return InkWell(
            onTap: () {
              setState(() => selectedTab = i);
              if (i == 1) {
                _openManageRoomsSheet();
              }
            },
            child: SizedBox(
              width: 58,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    items[i],
                    color: active
                        ? const Color(0xFF6FA6DA)
                        : const Color(0xFF7E8793),
                    size: 21,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    labels[i],
                    style: TextStyle(
                      color: active
                          ? const Color(0xFF8DB9E5)
                          : muted,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _legend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: muted, fontSize: 9),
        ),
      ],
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: const Color(0xFF252C35)),
        ),
        child: Icon(icon, color: const Color(0xFFB6BEC9), size: 20),
      ),
    );
  }
}

class ManagedRoom {
  final String id;
  final String name;
  final String category;
  final String price;
  final String status;

  const ManagedRoom({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.status,
  });

  ManagedRoom copyWith({
    String? id,
    String? name,
    String? category,
    String? price,
    String? status,
  }) {
    return ManagedRoom(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      status: status ?? this.status,
    );
  }
}

class Metric {
  final String title;
  final String value;
  final String subtitle;
  final String change;
  final IconData icon;
  final List<double> points;

  const Metric(
    this.title,
    this.value,
    this.subtitle,
    this.change,
    this.icon,
    this.points,
  );
}

class _MetricCard extends StatelessWidget {
  final Metric metric;

  const _MetricCard({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 9),
      decoration: BoxDecoration(
        color: const Color(0xFF11151B),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF202832)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            metric.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF8A929E),
              fontSize: 8,
              letterSpacing: .35,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            metric.value,
            style: const TextStyle(
              color: Color(0xFFF3F5F8),
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            metric.subtitle,
            style: const TextStyle(color: Color(0xFF858D99), fontSize: 8),
          ),
          const Spacer(),
          SizedBox(
            height: 27,
            width: double.infinity,
            child: CustomPaint(
              painter: SparklinePainter(metric.points),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                Icons.arrow_upward_rounded,
                color: Color(0xFF6FA6DA),
                size: 11,
              ),
              Text(
                metric.change,
                style: const TextStyle(
                  color: Color(0xFF8DB9E5),
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Icon(metric.icon, color: const Color(0xFF69798C), size: 13),
            ],
          ),
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const _Panel({
    required this.child,
    this.padding = const EdgeInsets.all(14),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFF11151B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF202832)),
      ),
      child: child,
    );
  }
}

class PerformancePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFF252C35)
      ..strokeWidth = 1;

    for (int i = 0; i < 4; i++) {
      final y = size.height * i / 3;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    final occupancy = [
      .70, .66, .59, .63, .50, .45, .36,
      .42, .29, .35, .25, .31, .20, .27,
      .17, .23, .30, .24, .39, .48, .56,
      .52, .59, .55, .62, .57, .64, .60,
    ];

    final bookings = [
      .78, .74, .70, .72, .67, .64, .59,
      .61, .57, .54, .51, .52, .49, .46,
      .44, .45, .48, .46, .49, .52, .55,
      .53, .57, .55, .59, .57, .60, .58,
    ];

    _drawLine(canvas, size, occupancy, const Color(0xFF397CC0), true);
    _drawLine(canvas, size, bookings, const Color(0xFF60758E), false);
  }

  void _drawLine(
    Canvas canvas,
    Size size,
    List<double> values,
    Color color,
    bool fill,
  ) {
    final path = Path();

    for (int i = 0; i < values.length; i++) {
      final point = Offset(
        size.width * i / (values.length - 1),
        size.height * values[i],
      );

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    if (fill) {
      final area = Path.from(path)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();

      final shader = LinearGradient(
        colors: [
          color.withOpacity(.30),
          color.withOpacity(0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Offset.zero & size);

      canvas.drawPath(
        area,
        Paint()..shader = shader,
      );
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant PerformancePainter oldDelegate) => false;
}

class SparklinePainter extends CustomPainter {
  final List<double> points;

  SparklinePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final path = Path();

    for (int i = 0; i < points.length; i++) {
      final point = Offset(
        size.width * i / (points.length - 1),
        size.height * (1 - points[i]),
      );

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFF397CC0)
        ..strokeWidth = 1.7
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant SparklinePainter oldDelegate) => false;
}

class Booking {
  final String initials;
  final String guest;
  final String room;
  final String date;
  final String amount;
  final String status;

  const Booking(
    this.initials,
    this.guest,
    this.room,
    this.date,
    this.amount,
    this.status,
  );
}

class _BookingRow extends StatelessWidget {
  final Booking booking;

  const _BookingRow({required this.booking});

  Color get statusColor {
    if (booking.status == 'Confirmed' || booking.status == 'Checked in') {
      return const Color(0xFF83B5E4);
    }
    return const Color(0xFFC3A46D);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF202832), width: .7),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 13,
                  backgroundColor: const Color(0xFF1B3047),
                  child: Text(
                    booking.initials,
                    style: const TextStyle(
                      color: Color(0xFFB5D2EF),
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.guest,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFFE5E9EF),
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        booking.room,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF858D99),
                          fontSize: 7.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              booking.date,
              style: const TextStyle(
                color: Color(0xFFB8C0CA),
                fontSize: 8,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              booking.amount,
              style: const TextStyle(
                color: Color(0xFFE5E9EF),
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 65,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(.12),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                booking.status,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 6.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  final String text;

  const _HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Color(0xFF7F8996),
        fontSize: 7,
        letterSpacing: .3,
      ),
    );
  }
}

class _AxisLabel extends StatelessWidget {
  final String text;

  const _AxisLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF737D89),
        fontSize: 7.5,
      ),
    );
  }
}

class QuickAction {
  final IconData icon;
  final String title;
  final String subtitle;

  const QuickAction(this.icon, this.title, this.subtitle);
}
