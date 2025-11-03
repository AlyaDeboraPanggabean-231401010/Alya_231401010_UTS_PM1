import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo EtheraMind
                Image.asset(
                  'assets/images/etheramind_logo.png',
                  width: 120,
                  height: 120,
                ),
                const SizedBox(height: 32),

                // Welcome text
                const Text(
                  'Selamat Datang di EtheraMind!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 12),

                // Subjudul
                const Text(
                  'Masukkan nama kamu untuk mulai tantangan!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 40),

                // Input nama
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white10,
                    labelText: 'Nama Kamu',
                    labelStyle: const TextStyle(
                      color: Colors.white70,
                      fontFamily: 'Montserrat',
                    ),
                    prefixIcon: const Icon(Icons.person, color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    if (value.length < 2) {
                      return 'Nama minimal 2 karakter';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Tombol Mulai
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _onContinuePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8D2DCE),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Mulai',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onContinuePressed() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();

      // TODO: sambungkan ke QuizProvider nanti
      // final quizProvider = Provider.of<QuizProvider>(context, listen: false);
      // quizProvider.setUserName(name);

      // TODO: arahkan ke CategoryScreen nanti
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const CategoryScreen()),
      // );

      debugPrint('Nama dimasukkan: $name');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
