import 'package:flutter/material.dart';

const Color navyBg = Color(0xFF0A0F1E);
const Color navyCard = Color(0xFF131B2E);
const Color navyElevated = Color(0xFF1A243D);
const Color goldAccent = Color(0xFFC6A15B);

class EditRoomPage extends StatefulWidget {
  final Map<String, dynamic> room;

  const EditRoomPage({
    super.key,
    required this.room,
  });

  @override
  State<EditRoomPage> createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descController;

  late String selectedCategory;
  late String selectedStatus;
  late String selectedImage;

  final List<String> categories = const [
    'Deluxe',
    'Suite',
    'Penthouse',
    'Standard',
  ];

  final List<String> statuses = const [
    'Available',
    'Occupied',
    'Maintenance',
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: (widget.room['name'] ?? '').toString());
    priceController = TextEditingController(text: (widget.room['price'] ?? '').toString());
    descController = TextEditingController(text: (widget.room['description'] ?? '').toString());

    final cat = (widget.room['category'] ?? 'Suite').toString();
    selectedCategory = categories.contains(cat) ? cat : 'Suite';

    final st = (widget.room['status'] ?? 'Available').toString();
    selectedStatus = statuses.contains(st) ? st : 'Available';

    selectedImage = (widget.room['image'] ?? 'assets/images/image6.jpg').toString();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descController.dispose();
    super.dispose();
  }

  void _updateRoom() {
    final name = nameController.text.trim();
    final price = priceController.text.trim();

    if (name.isEmpty || price.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: navyElevated,
          content: Text(
            'Magaca qolka iyo qiimaha lama faaruqin karo',
            style: TextStyle(color: goldAccent),
          ),
        ),
      );
      return;
    }

    Navigator.pop(context, {
      ...widget.room,
      'name': name,
      'category': selectedCategory,
      'price': price,
      'status': selectedStatus,
      'image': selectedImage,
      'description': descController.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navyBg,
      appBar: AppBar(
        backgroundColor: navyBg,
        elevation: 0,
        iconTheme: const IconThemeData(color: goldAccent),
        title: const Text(
          'EDIT ROOM',
          style: TextStyle(
            color: goldAccent,
            fontSize: 14.5,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.6,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: navyCard,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: goldAccent.withOpacity(0.35)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('Room Name'),
              const SizedBox(height: 6),
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white, fontSize: 13.5),
                decoration: _input('Room Name'),
              ),
              const SizedBox(height: 14),
              _label('Category'),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                dropdownColor: navyCard,
                style: const TextStyle(color: Colors.white, fontSize: 13.5),
                decoration: _input('Category'),
                items: categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => selectedCategory = v);
                },
              ),
              const SizedBox(height: 14),
              _label('Price'),
              const SizedBox(height: 6),
              TextField(
                controller: priceController,
                style: const TextStyle(color: Colors.white, fontSize: 13.5),
                decoration: _input('Price'),
              ),
              const SizedBox(height: 14),
              _label('Status'),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                dropdownColor: navyCard,
                style: const TextStyle(color: Colors.white, fontSize: 13.5),
                decoration: _input('Status'),
                items: statuses
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => selectedStatus = v);
                },
              ),
              const SizedBox(height: 14),
              _label('Description'),
              const SizedBox(height: 6),
              TextField(
                controller: descController,
                maxLines: 3,
                style: const TextStyle(color: Colors.white, fontSize: 13.5),
                decoration: _input('Description'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: goldAccent,
                    foregroundColor: navyBg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _updateRoom,
                  child: const Text(
                    'Update Room',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: goldAccent,
        fontSize: 12.5,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  InputDecoration _input(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38, fontSize: 12.5),
      filled: true,
      fillColor: navyElevated,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: goldAccent, width: 1.5),
      ),
    );
  }
}