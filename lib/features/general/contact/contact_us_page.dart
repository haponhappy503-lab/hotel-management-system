import 'package:flutter/material.dart';

const Color navyBg = Color(0xFF0A0F1E);
const Color navyCard = Color(0xFF131B2E);
const Color navyElevated = Color(0xFF1A243D);
const Color goldAccent = Color(0xFFC6A15B);

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: navyCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: goldAccent.withOpacity(0.45)),
          ),
          title: const Text(
            'Message Sent!',
            style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Mahadsanid ${_nameController.text}! Fariintaada waxaa si guul leh loogu diray Royal Hotel.',
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _nameController.clear();
                _emailController.clear();
                _subjectController.clear();
                _messageController.clear();
              },
              child: const Text('OK', style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 760;

    return Scaffold(
      backgroundColor: navyBg,
      appBar: AppBar(
        backgroundColor: navyBg,
        elevation: 0,
        iconTheme: const IconThemeData(color: goldAccent),
        title: const Text(
          'ROYAL HOTEL',
          style: TextStyle(
            color: goldAccent,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. TOP HERO BANNER ("Contact Us" + "Home / Contact" sidii sawirka)[cite: 6]
            _buildTopHeroBanner(),

            // 2. QEYBTA DHEXE: GET IN TOUCH FORM + CONTACT INFO & MAP[cite: 6]
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1050),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 5, child: _buildGetInTouchForm()),
                            const SizedBox(width: 20),
                            Expanded(flex: 6, child: _buildContactInfoAndMap()),
                          ],
                        )
                      : Column(
                          children: [
                            _buildGetInTouchForm(),
                            const SizedBox(height: 20),
                            _buildContactInfoAndMap(),
                          ],
                        ),
                ),
              ),
            ),

            // 3. CALL TO ACTION BANNER (Sida sawirka dhexe)[cite: 6]
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1050),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildMidCtaBanner(),
                ),
              ),
            ),
            const SizedBox(height: 28),

            // 4. FOOTER (NAVY BLUE + GOLD)
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHeroBanner() {
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        color: navyCard,
        border: Border(bottom: BorderSide(color: goldAccent.withOpacity(0.2))),
        image: DecorationImage(
          image: const AssetImage('assets/images/image6.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            navyBg.withOpacity(0.78),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Home',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Text('/', style: TextStyle(color: goldAccent, fontSize: 12)),
              ),
              Text(
                'Contact',
                style: TextStyle(color: goldAccent, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGetInTouchForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: navyCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(
                color: goldAccent,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Get In Touch',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),

            _buildInputField(
              label: 'Name',
              hint: 'Your Name...',
              controller: _nameController,
              validatorMsg: 'Fadlan geli magacaaga',
            ),
            const SizedBox(height: 14),

            _buildInputField(
              label: 'Email',
              hint: 'example@yourmail.com',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validatorMsg: 'Fadlan geli email-kaaga',
            ),
            const SizedBox(height: 14),

            _buildInputField(
              label: 'Subject',
              hint: 'Title...',
              controller: _subjectController,
              validatorMsg: 'Fadlan geli dulucda fariinta',
            ),
            const SizedBox(height: 14),

            _buildInputField(
              label: 'Message',
              hint: 'Type Here...',
              controller: _messageController,
              maxLines: 4,
              validatorMsg: 'Fadlan qor fariintaada',
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldAccent,
                  foregroundColor: navyBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _submitMessage,
                child: const Text(
                  'Send Now',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String validatorMsg,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white, fontSize: 13),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return validatorMsg;
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38, fontSize: 12.5),
            filled: true,
            fillColor: navyElevated,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: goldAccent),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfoAndMap() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Waxaad si toos ah ula xiriiri kartaa maamulka Royal Hotel si aad u hesho ballan qolal, adeegyo gaar ah, ama caawin degdeg ah 24/7.',
          style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 20),

        // 2x2 Contact Details (Phone, Email, WhatsApp, Our Office sidii sawirka)[cite: 6]
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.65,
          children: [
            _buildContactDetailTile(
              icon: Icons.phone_in_talk_outlined,
              title: 'Phone Number',
              value: '+252 63 400 1290',
            ),
            _buildContactDetailTile(
              icon: Icons.email_outlined,
              title: 'Email Address',
              value: 'info@royalhotel.so',
            ),
            _buildContactDetailTile(
              icon: Icons.chat_bubble_outline,
              title: 'WhatsApp / ZAAD',
              value: '+252 63 400 1290',
            ),
            _buildContactDetailTile(
              icon: Icons.location_on_outlined,
              title: 'Our Hotel',
              value: 'Shaqaalaha Avenue, Hargeisa',
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Location / Map Preview Card (Navy Blue + Gold)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: navyCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: goldAccent.withOpacity(0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Royal Hotel Location Map',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: navyElevated,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Hargeisa • 24/7',
                      style: TextStyle(color: goldAccent, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                height: 145,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: navyElevated,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.location_pin, color: goldAccent, size: 34),
                    SizedBox(height: 6),
                    Text(
                      'Royal Hotel — Luxury & Hospitality',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Shaqaalaha Road, Hargeisa, Somaliland',
                      style: TextStyle(color: Colors.white60, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactDetailTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: navyCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: goldAccent, size: 22),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.5),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(color: Colors.white60, fontSize: 11),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMidCtaBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 34),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: navyCard,
        border: Border.all(color: goldAccent.withOpacity(0.3)),
        image: DecorationImage(
          image: const AssetImage('assets/images/image14.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            navyBg.withOpacity(0.82),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Book Your Stay',
            style: TextStyle(color: goldAccent, fontSize: 12, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          const Text(
            'We Are Always Ready To\nGive You Royal Comfort',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: goldAccent,
              foregroundColor: navyBg,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Get Started', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: navyCard,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1050),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'ROYAL HOTEL',
                          style: TextStyle(
                            color: goldAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Luxury suites, calm hospitality, and seamless local payments via ZAAD, eDahab, SLSH & USD.',
                          style: TextStyle(color: Colors.white60, fontSize: 11.5, height: 1.45),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Quick Links',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        SizedBox(height: 8),
                        Text('Home', style: TextStyle(color: Colors.white60, fontSize: 11.5)),
                        SizedBox(height: 4),
                        Text('Rooms', style: TextStyle(color: Colors.white60, fontSize: 11.5)),
                        SizedBox(height: 4),
                        Text('Bookings', style: TextStyle(color: Colors.white60, fontSize: 11.5)),
                        SizedBox(height: 4),
                        Text('Contact', style: TextStyle(color: goldAccent, fontSize: 11.5)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.white10),
              const SizedBox(height: 10),
              const Text(
                'Copyright © 2026 Royal Hotel | All Rights Reserved',
                style: TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}