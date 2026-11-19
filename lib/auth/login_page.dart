import 'dart:ui';
import 'package:flutter/material.dart';

// Liiska akoonnada ee isla bogga ku dhex jira (oo ay Register-kuna ku darayso)
final Map<String, String> registeredUsers = {
  'admin': '1234',
  'customer': '1234',
};

class LoginPage extends StatefulWidget {
  final Widget? customerHomePage;
  final Widget? adminHomePage;

  const LoginPage({
    super.key,
    this.customerHomePage,
    this.adminHomePage,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  static const Color navyBg = Color(0xFF0A0F1E);
  static const Color navyCard = Color(0xFF131B2E);
  static const Color navyElevated = Color(0xFF1A243D);
  static const Color goldAccent = Color(0xFFC6A15B);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
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
    passwordController.dispose();
    _shineController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: navyElevated,
        content: Text(
          message,
          style: const TextStyle(color: goldAccent),
        ),
      ),
    );
  }

  void _handleLogin() {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      showMessage('Fadlan geli username iyo password');
      return;
    }

    final savedPass = registeredUsers[username];
    if (savedPass == null || savedPass != password) {
      showMessage('Username ama password waa khalad! (Haddii aadan akoon lahayn, Register samee)');
      return;
    }

    showMessage('Soo dhawoow, $username!');

    if (username.toLowerCase() == 'admin' && widget.adminHomePage != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => widget.adminHomePage!),
      );
    } else if (widget.customerHomePage != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => widget.customerHomePage!),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 750;

          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/image29.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: navyBg);
                },
              ),
              Container(color: navyBg.withOpacity(0.55)),
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: isDesktop ? _desktopLayout() : _mobileLayout(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _desktopLayout() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1250),
      child: SizedBox(
        height: 700,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    width: 420,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: navyCard.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: goldAccent.withOpacity(0.35)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Because Stays Should Feel Like Destinations',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Georgia',
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Find a perfect stay for your much awaited vacation!',
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 550,
              child: _loginCard(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text(
          'Because Stays Should Feel Like Destinations',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Georgia',
          ),
        ),
        const SizedBox(height: 25),
        _loginCard(),
      ],
    );
  }

  Widget _loginCard() {
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
              BoxShadow(
                color: navyBg.withOpacity(0.65),
                blurRadius: 25,
                spreadRadius: 3,
              ),
              BoxShadow(
                color: goldAccent.withOpacity(0.18),
                blurRadius: 30,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                decoration: BoxDecoration(
                  color: navyCard.withOpacity(0.90),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: child,
              ),
            ),
          ),
        );
      },
      child: _loginForm(),
    );
  }

  Widget _loginForm() {
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
        const SizedBox(height: 26),
        const Text(
          'Welcome Back to\nRoyal Hotel',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: 'Georgia',
            height: 1.25,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Sign in with your username and password',
          style: TextStyle(color: Colors.white60, fontSize: 14),
        ),
        const SizedBox(height: 28),

        _fieldLabel('Username'),
        const SizedBox(height: 7),
        TextField(
          controller: usernameController,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('Enter your username', Icons.person_outline),
        ),
        const SizedBox(height: 20),

        _fieldLabel('Password'),
        const SizedBox(height: 7),
        TextField(
          controller: passwordController,
          obscureText: obscurePassword,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('Enter your password', Icons.lock_outline).copyWith(
            suffixIcon: IconButton(
              onPressed: () => setState(() => obscurePassword = !obscurePassword),
              icon: Icon(
                obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: Colors.white54,
              ),
            ),
          ),
        ),
        const SizedBox(height: 26),

        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: goldAccent,
              foregroundColor: navyBg,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),
            ),
          ),
        ),
        const SizedBox(height: 22),

        Wrap(
          alignment: WrapAlignment.center,
          children: [
            const Text(
              "Don't have an account? ",
              style: TextStyle(color: Colors.white70, fontSize: 13.5),
            ),
            GestureDetector(
              onTap: () async {
                final createdUser = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => _InlineRegisterPage(
                      customerHomePage: widget.customerHomePage,
                    ),
                  ),
                );
                if (createdUser != null && createdUser.isNotEmpty) {
                  usernameController.text = createdUser;
                  showMessage('Akoonka ($createdUser) waa la keydiyey — geli password-kaaga!');
                }
              },
              child: const Text(
                'Register',
                style: TextStyle(
                  color: goldAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                ),
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
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Georgia'),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData? icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13, color: Colors.white38),
      prefixIcon: icon == null ? null : Icon(icon, size: 18, color: goldAccent),
      filled: true,
      fillColor: navyElevated,
      contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 14),
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

class _InlineRegisterPage extends StatefulWidget {
  final Widget? customerHomePage;

  const _InlineRegisterPage({this.customerHomePage});

  @override
  State<_InlineRegisterPage> createState() => _InlineRegisterPageState();
}

class _InlineRegisterPageState extends State<_InlineRegisterPage>
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

    registeredUsers[username] = password;
    showMessage('Waa laguu diiwaangeliyey ($username)! Hadda waad soo geli kartaa.');
    Navigator.pop(context, username);
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