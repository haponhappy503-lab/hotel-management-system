import 'package:flutter/material.dart';

class AdminReportsPage extends StatefulWidget {
  const AdminReportsPage({super.key});

  @override
  State<AdminReportsPage> createState() => _AdminReportsPageState();
}

class _AdminReportsPageState extends State<AdminReportsPage> {
  static const Color navy = Color(0xFF173B63);
  static const Color blue = Color(0xFF397CC0);
  static const Color bg = Color(0xFF090B0F);
  static const Color card = Color(0xFF11151B);
  static const Color muted = Color(0xFF858D99);
  static const Color white = Color(0xFFF3F5F8);

  String selectedPeriod = '7D';

  final List<String> periods = const ['7D', '30D', '90D'];

  final Map<String, Map<String, dynamic>> periodStats = const {
    '7D': {
      'revenue': '\$6,420',
      'occupancy': '78.6%',
      'bookings': '46',
      'adr': '\$195',
      'points': [0.42, 0.54, 0.49, 0.71, 0.66, 0.79, 0.86],
    },
    '30D': {
      'revenue': '\$24,800',
      'occupancy': '82.4%',
      'bookings': '184',
      'adr': '\$210',
      'points': [0.35, 0.48, 0.60, 0.57, 0.74, 0.81, 0.90],
    },
    '90D': {
      'revenue': '\$71,950',
      'occupancy': '76.1%',
      'bookings': '532',
      'adr': '\$204',
      'points': [0.30, 0.45, 0.52, 0.63, 0.59, 0.72, 0.83],
    },
  };

  final List reports = const [
    {
      'code': 'RPT-101',
      'title': 'Revenue & Occupancy Summary',
      'category': 'Financial',
      'generated': 'Nov 20, 2026',
      'summary': 'Total room revenue and average occupancy across suites and deluxe rooms.',
    },
    {
      'code': 'RPT-102',
      'title': 'Guest Bookings & Check-ins',
      'category': 'Operations',
      'generated': 'Nov 19, 2026',
      'summary': 'Confirmed stays, pending reservations, and check-in turnaround times.',
    },
    {
      'code': 'RPT-103',
      'title': 'Hotel Services Utilization',
      'category': 'Services',
      'generated': 'Nov 18, 2026',
      'summary': 'Revenue and demand across room dining, spa, transport, and laundry.',
    },
    {
      'code': 'RPT-104',
      'title': 'Refunds & Payment Methods',
      'category': 'Payments',
      'generated': 'Nov 17, 2026',
      'summary': 'Breakdown of eDahab, ZAAD, card, and cash settlements plus refunds.',
    },
  ];

  void _openReportSheet(Map<String, String> report) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: Color(0xFF202832)),
      ),
      builder: (context) {
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
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: navy.withOpacity(.45),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Icon(
                      Icons.description_outlined,
                      color: Color(0xFF8DB9E5),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report['title'] ?? 'Report',
                          style: const TextStyle(
                            color: white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${report['code'] ?? ''}  •  ${report['category'] ?? ''}',
                          style: const TextStyle(color: muted, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Divider(color: Color(0xFF202832), height: 1),
              const SizedBox(height: 14),
              _detailRow('Generated Date', report['generated'] ?? '-'),
              const SizedBox(height: 10),
              _detailRow('Reporting Window', selectedPeriod),
              const SizedBox(height: 14),
              const Text(
                'Overview',
                style: TextStyle(color: muted, fontSize: 11),
              ),
              const SizedBox(height: 6),
              Text(
                report['summary'] ?? '',
                style: const TextStyle(color: white, fontSize: 12, height: 1.4),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    foregroundColor: white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFF161B22),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          '${report['code'] ?? 'Report'} ($selectedPeriod) exported.',
                          style: const TextStyle(
                            color: Color(0xFF8DB9E5),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.download_rounded, size: 18),
                  label: const Text(
                    'Export Report',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
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

  Widget _statCard(String title, String value, String sub) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF202832)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: muted,
              fontSize: 8.5,
              letterSpacing: .4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            sub,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFF8DB9E5), fontSize: 9.5),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentStats = periodStats[selectedPeriod] ?? periodStats['7D']!;
    final rawPoints = currentStats['points'];
    final List<double> points = rawPoints is List<double>
        ? rawPoints
        : const [0.4, 0.5, 0.6, 0.55, 0.7, 0.8, 0.85];

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        iconTheme: const IconThemeData(color: white),
        title: const Text(
          'Hotel Reports',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Reporting Period',
                  style: TextStyle(
                    color: white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: periods.map((p) {
                    final selected = selectedPeriod == p;
                    return Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: GestureDetector(
                        onTap: () => setState(() => selectedPeriod = p),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: selected ? blue : card,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: selected ? blue : const Color(0xFF202832),
                            ),
                          ),
                          child: Text(
                            p,
                            style: TextStyle(
                              color: selected ? white : muted,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.75,
              children: [
                _statCard(
                  'REVENUE ($selectedPeriod)',
                  (currentStats['revenue'] ?? '\$0').toString(),
                  'Completed stays',
                ),
                _statCard(
                  'OCCUPANCY',
                  (currentStats['occupancy'] ?? '0%').toString(),
                  'Room utilization',
                ),
                _statCard(
                  'BOOKINGS',
                  (currentStats['bookings'] ?? '0').toString(),
                  'Total reservations',
                ),
                _statCard(
                  'AVG. NIGHTLY RATE',
                  (currentStats['adr'] ?? '\$0').toString(),
                  'Per room / night',
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFF202832)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Performance Trend',
                        style: TextStyle(
                          color: white,
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        selectedPeriod,
                        style: const TextStyle(
                          color: Color(0xFF8DB9E5),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 130,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: _ReportTrendPainter(points),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Available Reports',
              style: TextStyle(
                color: white,
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reports.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final r = reports[index];
                return InkWell(
                  onTap: () => _openReportSheet(r),
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
                          child: const Icon(
                            Icons.analytics_outlined,
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
                                r['title'] ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: white,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${r['code']}  •  ${r['category']}  •  ${r['generated']}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: muted,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: muted,
                          size: 20,
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

class _ReportTrendPainter extends CustomPainter {
  final List<double> points;

  const _ReportTrendPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFF202832)
      ..strokeWidth = 0.8;

    for (int i = 0; i <= 3; i++) {
      final y = (i / 3) * size.height;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    if (points.isEmpty) return;

    final linePaint = Paint()
      ..color = const Color(0xFF397CC0)
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    for (int i = 0; i < points.length; i++) {
      final x = points.length == 1
          ? size.width / 2
          : (i / (points.length - 1)) * size.width;
      final y = size.height - (points[i].clamp(0.0, 1.0) * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant _ReportTrendPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}