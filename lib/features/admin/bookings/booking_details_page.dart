import 'package:flutter/material.dart';

class BookingDetailsPage extends StatefulWidget {
  final Map<String, String> booking;

  const BookingDetailsPage({
    super.key,
    required this.booking,
  });

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  static const Color navy = Color(0xFF173B63);
  static const Color blue = Color(0xFF397CC0);
  static const Color bg = Color(0xFF090B0F);
  static const Color card = Color(0xFF11151B);
  static const Color muted = Color(0xFF858D99);
  static const Color white = Color(0xFFF3F5F8);

  late String currentStatus;

  final List<String> statuses = const [
    'Confirmed',
    'Pending',
    'Checked in',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    currentStatus = widget.booking['status'] ?? 'Pending';
  }

  Color _statusColor(String status) {
    if (status == 'Confirmed' || status == 'Checked in') {
      return const Color(0xFF83B5E4);
    } else if (status == 'Cancelled') {
      return const Color(0xFFE07A7A);
    }
    return const Color(0xFFC3A46D);
  }

  void _saveStatus() {
    Navigator.pop(context, {
      ...widget.booking,
      'status': currentStatus,
    });
  }

  @override
  Widget build(BuildContext context) {
    final guest = widget.booking['guest'] ?? 'Guest';
    final initials = widget.booking['initials'] ?? 'GH';
    final room = widget.booking['room'] ?? 'Royal Room';
    final date = widget.booking['date'] ?? 'Nov 21';
    final amount = widget.booking['amount'] ?? '\$180';
    final badgeColor = _statusColor(currentStatus);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        iconTheme: const IconThemeData(color: white),
        title: const Text(
          'Booking Details',
          style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF202832)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: navy.withOpacity(.45),
                    child: Text(
                      initials,
                      style: const TextStyle(
                        color: Color(0xFF8DB9E5),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          guest,
                          style: const TextStyle(
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          room,
                          style: const TextStyle(color: muted, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: badgeColor.withOpacity(.14),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      currentStatus,
                      style: TextStyle(
                        color: badgeColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF202832)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _detailRow('Check-in Date', date),
                  const Divider(color: Color(0xFF202832), height: 22),
                  _detailRow('Room Type', room),
                  const Divider(color: Color(0xFF202832), height: 22),
                  _detailRow('Total Amount', amount),
                  const Divider(color: Color(0xFF202832), height: 22),
                  const Text(
                    'Update Booking Status',
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
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                        onSelected: (_) {
                          setState(() => currentStatus = s);
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _saveStatus,
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: muted, fontSize: 12)),
        Text(
          value,
          style: const TextStyle(
            color: white,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}