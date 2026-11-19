import 'dart:ui';
import 'package:flutter/material.dart';

// Liiska akoonnada ee wadaagga ah haddii la isticmaalo
final Map<String, String> registerPageUsers = {
  'admin': '1234',
  'customer': '1234',
};

class RegisterPage extends StatefulWidget {
  final Widget? loginPage;
  final Widget? customerHomePage;

  const RegisterPage({
    super.key,
    this.loginPage,
    this.customerHomePage,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  static const Color navyBg = Color(0xFF0A0F1E);
  static const Color navyCard = Color(0xFF131B2E);
  static const Color navyElevated = Color(0xFF1A243D);
  static const Color goldAccent = Color(0xFFC6A15B);

  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  late AnimationController _shineController;

  @override
  void initState() {
    super.initState();
    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    usernameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _shineController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: navyElevated,
        content: Text(message, style: const TextStyle(color: goldAccent)),
      ),
    );
  }

  void _handleRegister() {
    final username = usernameController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty || phone.isEmpty || password.isEmpty) {
      showMessage('Fadlan buuxi username, telefoonka iyo password-ka');
      return;
    }
    if (password.length < 4) {
      showMessage('Password-ku ha ka yaraan 4 xaraf');
      return;
    }
    if (password != confirmPassword) {
      showMessage('Labada password isma laha');
      return;
    }

    registerPageUsers[username] = password;
    showMessage('Akoonkaaga ($username) waa la diiwaangeliyey! Hadda waad soo geli kartaa.');

    if (Navigator.canPop(context)) {
      Navigator.pop(context, username);
    } else if (widget.loginPage != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => widget.loginPage!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navyBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: goldAccent),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF070B16), navyBg, Color(0xFF0F1930)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: _registerCard(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerCard() {
    return AnimatedBuilder(
      animation: _shineController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(_shineController.value * 6.28),
              colors: const [
                goldAccent,
                Color(0xFF2A4A7F),
                Colors.white,
                Color(0xFF1A2E52),
                goldAccent,
              ],
            ),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.65), blurRadius: 25, spreadRadius: 3),
              BoxShadow(color: goldAccent.withOpacity(0.18), blurRadius: 32),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                decoration: BoxDecoration(
                  color: navyCard.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: child,
              ),
            ),
          ),
        );
      },
      child: _registerForm(),
    );
  }

  Widget _registerForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
          decoration: BoxDecoration(
            color: navyElevated,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: goldAccent.withOpacity(0.45)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.hotel, color: goldAccent, size: 20),
              SizedBox(width: 8),
              Text(
                'Royal Hotel',
                style: TextStyle(
                  color: goldAccent,
                  fontSize: 17,
                  fontFamily: 'Georgia',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Create Account at\nRoyal Hotel',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 28, color: Colors.white, fontFamily: 'Georgia', height: 1.25),
        ),
        const SizedBox(height: 8),
        const Text(
          'Diiwaangeli akoon cusub si aad u ballansato qolalka',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white60, fontSize: 13.5),
        ),
        const SizedBox(height: 24),

        _fieldLabel('Username'),
        const SizedBox(height: 6),
        TextField(
          controller: usernameController,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('Enter your username', Icons.person_outline),
        ),
        const SizedBox(height: 16),

        _fieldLabel('Phone Number (ZAAD / eDahab)'),
        const SizedBox(height: 6),
        TextField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('+252 63 ...', Icons.phone_outlined),
        ),
        const SizedBox(height: 16),

        _fieldLabel('Password'),
        const SizedBox(height: 6),
        TextField(
          controller: passwordController,
          obscureText: obscurePassword,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('Create a password', Icons.lock_outline).copyWith(
            suffixIcon: IconButton(
              onPressed: () => setState(() => obscurePassword = !obscurePassword),
              icon: Icon(
                obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: Colors.white54,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        _fieldLabel('Confirm Password'),
        const SizedBox(height: 6),
        TextField(
          controller: confirmPasswordController,
          obscureText: obscureConfirmPassword,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('Re-enter your password', Icons.lock_reset_outlined).copyWith(
            suffixIcon: IconButton(
              onPressed: () => setState(() => obscureConfirmPassword = !obscureConfirmPassword),
              icon: Icon(
                obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: Colors.white54,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _handleRegister,
            style: ElevatedButton.styleFrom(
              backgroundColor: goldAccent,
              foregroundColor: navyBg,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              'Register',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),
            ),
          ),
        ),
        const SizedBox(height: 20),

        Wrap(
          alignment: WrapAlignment.center,
          children: [
            const Text(
              'Already have an account? ',
              style: TextStyle(color: Colors.white70, fontSize: 13.5),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text(
                'Login',
                style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold, fontSize: 13.5),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _fieldLabel(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: const TextStyle(fontSize: 13.5, color: Colors.white, fontFamily: 'Georgia')),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData? icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13, color: Colors.white38),
      prefixIcon: icon == null ? null : Icon(icon, size: 18, color: goldAccent),
      filled: true,
      fillColor: navyElevated,
      contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
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