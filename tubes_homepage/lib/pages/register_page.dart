import 'package:flutter/material.dart';
import 'login_page.dart'; // pastikan file login_page.dart diimpor

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFCCE7FF), Colors.white],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/images/logo.png',
              width: MediaQuery.of(context).size.width * 0.4,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),

            const Text(
              "Welcome to BubbleTask!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),

            // Username
            const SizedBox(height: 50),

            // Username Input
            _buildLabeledInput(
              label: 'Username',
              icon: Icons.person_outline,
            ),

            const SizedBox(height: 24),

            // Password Input
            _buildLabeledInput(
              label: 'Password',
              icon: Icons.lock_outline,
              obscureText: true,
            ),

            const SizedBox(height: 24),

            // Password Input
            _buildLabeledInput(
              label: 'Confirm Password',
              icon: Icons.lock_outline,
              obscureText: true,
            ),

            const SizedBox(height: 40),

            // Register Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
              ),
              onPressed: () {
                // TODO: register logic
              },
              child: const Text(
                'Register',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBox({bool obscureText = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 6,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: TextField(
        obscureText: obscureText,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
  Widget _buildLabeledInput({
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
              icon: Icon(icon, color: Colors.deepPurple),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
