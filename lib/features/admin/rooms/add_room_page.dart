import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const Color navyBg = Color(0xFF0A0F1E);
const Color navyCard = Color(0xFF131B2E);
const Color navyElevated = Color(0xFF1A243D);
const Color goldAccent = Color(0xFFC6A15B);

class AddRoomPage extends StatefulWidget {
  const AddRoomPage({super.key});

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  String selectedCategory = 'Suite';
  String selectedStatus = 'Available';

  // Sawirka la doortay: ama asset path ama 'device_file'
  String selectedImage = 'assets/images/image6.jpg';
  XFile? pickedDeviceFile;
  Uint8List? pickedFileBytes;

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

  final List presetPhotos = const [
  
  ];

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromDevice() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (file == null) return;

      final bytes = await file.readAsBytes();
      setState(() {
        pickedDeviceFile = file;
        pickedFileBytes = bytes;
        selectedImage = 'device_file';
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: navyElevated,
          content: Text(
            'Ma suurtagelin in sawir la furo: $e',
            style: const TextStyle(color: goldAccent),
          ),
        ),
      );
    }
  }

  void _saveRoom() {
    final name = nameController.text.trim();
    final rawPrice = priceController.text.trim();

    if (name.isEmpty || rawPrice.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: navyElevated,
          content: Text(
            'Fadlan geli magaca qolka iyo qiimaha',
            style: TextStyle(color: goldAccent),
          ),
        ),
      );
      return;
    }

    final formattedPrice =
        rawPrice.contains('\$') ? rawPrice : '\$$rawPrice / night';

    Navigator.pop(context, {
      'name': name,
      'category': selectedCategory,
      'price': formattedPrice,
      'status': selectedStatus,
      // Haddii sawir laga soo xulay qalabka, waxaa la gudbinayaa bytes/file; haddii kale asset-ka la doortay
      'image': pickedFileBytes != null
          ? 'assets/images/image6.jpg'
          : selectedImage,
      'pickedBytes': pickedFileBytes,
      'pickedFileName': pickedDeviceFile?.name,
      'description': descController.text.trim().isEmpty
          ? 'Luxury room at Royal Hotel.'
          : descController.text.trim(),
    });
  }

  Widget _buildPhotoPickerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _label('Room Photo'),
            TextButton.icon(
              onPressed: _pickImageFromDevice,
              icon: const Icon(Icons.folder_open, color: goldAccent, size: 17),
              label: const Text(
                'Choose from Files',
                style: TextStyle(
                  color: goldAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Haddii sawir laga soo xulay faylasha / gallery-ga
        if (pickedFileBytes != null) ...[
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: navyElevated,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: goldAccent, width: 1.5),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    pickedFileBytes!,
                    width: 68,
                    height: 68,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selected from Device',
                        style: TextStyle(
                          color: goldAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        pickedDeviceFile?.name ?? 'Custom Room Photo',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      pickedDeviceFile = null;
                      pickedFileBytes = null;
                      selectedImage = presetPhotos.first['path']!;
                    });
                  },
                  icon: const Icon(Icons.close, color: Colors.white54, size: 18),
                ),
              ],
            ),
          ),
        ],

        // Sawirrada diyaarsan oo qaab sawir (thumbnail cards) loo soo bandhigay
        SizedBox(
          height: 88,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: presetPhotos.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final item = presetPhotos[index];
              final path = item['path']!;
              final label = item['label']!;
              final isSelected = pickedFileBytes == null && selectedImage == path;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    pickedDeviceFile = null;
                    pickedFileBytes = null;
                    selectedImage = path;
                  });
                },
                child: Container(
                  width: 96,
                  decoration: BoxDecoration(
                    color: navyElevated,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? goldAccent : Colors.white12,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.asset(
                            path,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Center(
                              child: Icon(Icons.king_bed, color: goldAccent, size: 22),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        child: Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected ? goldAccent : Colors.white70,
                            fontSize: 10.5,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
    );
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
          'ADD NEW ROOM',
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
                decoration: _input('e.g. Royal Ocean Suite'),
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
              _label('Price per Night'),
              const SizedBox(height: 6),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 13.5),
                decoration: _input('e.g. \$280 / night'),
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
              _buildPhotoPickerSection(),
              const SizedBox(height: 14),
              _label('Description'),
              const SizedBox(height: 6),
              TextField(
                controller: descController,
                maxLines: 3,
                style: const TextStyle(color: Colors.white, fontSize: 13.5),
                decoration: _input('Room features & view...'),
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
                  onPressed: _saveRoom,
                  child: const Text(
                    'Save Room',
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