import 'package:flutter/material.dart';

class AdminPaymentsPage extends StatefulWidget {
  const AdminPaymentsPage({super.key});

  @override
  State<AdminPaymentsPage> createState() => _AdminPaymentsPageState();
}

class _AdminPaymentsPageState extends State<AdminPaymentsPage> {
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
    'Paid',
    'Pending',
    'Refunded',
  ];

  final List<String> statuses = const [
    'Paid',
    'Pending',
    'Refunded',
  ];

  final List<Map<String, String>> payments = [
    {
      'ref': 'PAY-901',
      'initials': 'HA',
      'guest': 'Hassan Ali',
      'item': 'Royal Luxury Suite (RM-101)',
      'method': 'eDahab',
      'date': 'Nov 20, 2026',
      'amount': '\$350',
      'status': 'Paid',
    },
    {
      'ref': 'PAY-902',
      'initials': 'FA',
      'guest': 'Fatima Ahmed',
      'item': 'Deluxe Ocean View (RM-204)',
      'method': 'ZAAD',
      'date': 'Nov 20, 2026',
      'amount': '\$180',
      'status': 'Pending',
    },
    {
      'ref': 'PAY-903',
      'initials': 'SY',
      'guest': 'Sahra Yusuf',
      'item': 'Grand Royal Penthouse (RM-305)',
      'method': 'Card',
      'date': 'Nov 19, 2026',
      'amount': '\$500',
      'status': 'Paid',
    },
    {
      'ref': 'PAY-904',
      'initials': 'MA',
      'guest': 'Mohamed Abdi',
      'item': 'Executive Double (RM-108)',
      'method': 'Cash',
      'date': 'Nov 18, 2026',
      'amount': '\$120',
      'status': 'Refunded',
    },
  ];

  List get filteredPayments {
    return payments.where((p) {
      final matchesFilter =
          selectedFilter == 'All' || p['status'] == selectedFilter;
      final q = searchQuery.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          (p['guest'] ?? '').toLowerCase().contains(q) ||
          (p['ref'] ?? '').toLowerCase().contains(q) ||
          (p['method'] ?? '').toLowerCase().contains(q);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  double _parseAmount(String? raw) {
    if (raw == null) return 0;
    final cleaned = raw.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0;
  }

  String _sumByStatus(String status) {
    double total = 0;
    for (final p in payments) {
      if (p['status'] == status) {
        total += _parseAmount(p['amount']);
      }
    }
    return '\$${total.toStringAsFixed(0)}';
  }

  Color _statusColor(String status) {
    if (status == 'Paid') {
      return const Color(0xFF83B5E4);
    } else if (status == 'Pending') {
      return const Color(0xFFC3A46D);
    }
    return const Color(0xFFE07A7A);
  }

  void _openPaymentSheet(Map<String, String> payment) {
    final index = payments.indexOf(payment);
    String currentStatus = payment['status'] ?? 'Pending';

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
                        radius: 23,
                        backgroundColor: navy.withOpacity(.45),
                        child: Text(
                          payment['initials'] ?? 'PY',
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
                              payment['guest'] ?? 'Guest',
                              style: const TextStyle(
                                color: white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${payment['ref']}  •  ${payment['item']}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                  _infoRow('Amount', payment['amount'] ?? '\$0'),
                  const SizedBox(height: 10),
                  _infoRow('Payment Method', payment['method'] ?? '-'),
                  const SizedBox(height: 10),
                  _infoRow('Date', payment['date'] ?? '-'),
                  const SizedBox(height: 16),
                  const Text(
                    'Update Payment Status',
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
                            payments[index] = {
                              ...payment,
                              'status': currentStatus,
                            };
                          });
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Save Payment Status',
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

  Widget _infoRow(String label, String value) {
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

  Widget _summaryBox(String label, String value, Color accent) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: const Color(0xFF202832)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: muted, fontSize: 9.5),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                color: accent,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = filteredPayments;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        iconTheme: const IconThemeData(color: white),
        title: const Text(
          'Payments Management',
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
            child: Row(
              children: [
                _summaryBox('Paid', _sumByStatus('Paid'), const Color(0xFF83B5E4)),
                const SizedBox(width: 8),
                _summaryBox('Pending', _sumByStatus('Pending'), const Color(0xFFC3A46D)),
                const SizedBox(width: 8),
                _summaryBox('Refunded', _sumByStatus('Refunded'), const Color(0xFFE07A7A)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: TextField(
              onChanged: (v) => setState(() => searchQuery = v),
              style: const TextStyle(color: white, fontSize: 12.5),
              decoration: InputDecoration(
                hintText: 'Search guest, reference ID or method...',
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
                      'No payments found.',
                      style: TextStyle(color: muted, fontSize: 12.5),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final p = list[index];
                      final status = p['status'] ?? 'Pending';
                      final badgeColor = _statusColor(status);

                      return InkWell(
                        onTap: () => _openPaymentSheet(p),
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
                                  p['initials'] ?? 'P',
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
                                      p['guest'] ?? '',
                                      style: const TextStyle(
                                        color: white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${p['ref']}  •  ${p['method']}  •  ${p['date']}',
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
                                    p['amount'] ?? '\$0',
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