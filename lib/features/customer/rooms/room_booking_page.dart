import 'package:flutter/material.dart';

const Color darkNavy = Color(0xFF0D0F14);
const Color cardBg = Color(0xFF1E222D);
const Color goldAccent = Color(0xFFC6A15B);

class RoomBookingPage extends StatefulWidget {
  final Map<String, dynamic> room;

  const RoomBookingPage({super.key, required this.room});

  @override
  State<RoomBookingPage> createState() => _RoomBookingPageState();
}

class _RoomBookingPageState extends State<RoomBookingPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _checkInController = TextEditingController(text: '2026-11-20');
  final TextEditingController _checkOutController = TextEditingController(text: '2026-11-22');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkNavy,
      appBar: AppBar(
        backgroundColor: darkNavy,
        elevation: 0,
        iconTheme: const IconThemeData(color: goldAccent),
        title: const Text(
          'CONFIRM ROOM BOOKING',
          style: TextStyle(
            color: goldAccent,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Koobiyeynta Qolka La Doortay (Room Summary Card)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: goldAccent.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.room['image'] ?? 'assets/images/image31.jpg',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.room['name'] ?? 'Luxury Room',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Category: ${widget.room['category'] ?? 'VIP'}',
                            style: const TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.room['price'] ?? '\$400 / Night',
                            style: const TextStyle(
                              color: goldAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Foomka Macluumaadka Macaamiilka
              const Text(
                'Guest Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              _buildTextField('Full Name', _nameController, Icons.person_outline, 'Fadlan geli magacaaga'),
              const SizedBox(height: 14),
              _buildTextField('Phone Number', _phoneController, Icons.phone_outlined, 'Fadlan geli lambarkaaga teleefanka', isNumber: true),
              const SizedBox(height: 14),
              _buildTextField('Check-In Date', _checkInController, Icons.calendar_today, 'Geli taariikhda galitaanka'),
              const SizedBox(height: 14),
              _buildTextField('Check-Out Date', _checkOutController, Icons.calendar_today, 'Geli taariikhda bixitaanka'),
              
              const SizedBox(height: 30),

              // 3. Badhanka Xaqiijinta (Confirm Booking)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: goldAccent,
                    foregroundColor: darkNavy,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          backgroundColor: cardBg,
                          title: const Text(
                            'Booking Confirmed!',
                            style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold),
                          ),
                          content: Text(
                            'Mahadsanid ${_nameController.text}! Qolkaaga ${widget.room['name']} si guul leh ayaa loo ballansaday.',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Xir Dialog-ka
                                
                                // Halkan ayaynu ku samayn karnaa redirect: 
                                // Wuxuu soo xirayaa boggan, oo haddii aad Main Screen ku leedahay 
                                // BottomNavigationBar, waxaad ku celin kartaa root ama adigoo isticmaalaya pushNamed.
                                // Tusaale ahaan, haddii aad rabto inaad dib ugu noqoto Dashboard-ka oo aad Bookings tab doorato:
                                Navigator.popUntil(context, (route) => route.isFirst);
                                
                                // Xusuusin: Haddii main dashboard-kaagu leeyahay Index Controller, 
                                // waxaad sidoo kale u diri kartaa xogta ballanta adigoo isticmaalaya Provider ama State management.
                              },
                              child: const Text('OK', style: TextStyle(color: goldAccent)),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'COMPLETE BOOKING',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, String validationMsg, {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
          style: const TextStyle(color: Colors.white, fontSize: 13),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validationMsg;
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: cardBg,
            prefixIcon: Icon(icon, color: goldAccent, size: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white10),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: goldAccent),
            ),
            errorStyle: const TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}