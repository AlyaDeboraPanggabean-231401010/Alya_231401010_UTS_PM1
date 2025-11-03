import 'package:flutter/material.dart';
// TODO: import constants.dart nanti setelah file dibuat
// import 'package:etheramind/utils/constants.dart';
// TODO: import NameInputScreen nanti setelah file dibuat
// import 'package:etheramind/screens/name_input_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // TODO: atur durasi dan curve animasi nanti
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    // TODO: nanti ubah delay dan arah navigasi

    Future.delayed(const Duration(seconds: 3), () {
      // sementara, belum navigasi ke halaman berikut
      debugPrint("Splash selesai, nanti ke NameInputScreen");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: nanti ubah warna background pakai AppColors.primary
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Logo EtheraMind
             Image.asset('assets/images/etheramind_logo.png',
             width: 120,
             height: 120,
             ),
              const SizedBox(height: 24),

              // Text EtheraMind
              const Text(
                'Etheramind',
                style: TextStyle(
                  fontFamily: 'Montserrat', // pakai font Montserrat
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),

              // Text dibawah EtheraMind
              const Text(
                'Siap Tantang Otakmu?',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  color: Colors.white70, // grey
                ),
              ),

              const SizedBox(height: 40),
              
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
