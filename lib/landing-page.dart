import 'package:flutter/material.dart';
import 'login.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  double _buttonOffset = 0.0;
  bool _navigated = false;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _buttonOffset += details.delta.dx;
      if (_buttonOffset < 0) _buttonOffset = 0;
      if (_buttonOffset > MediaQuery.of(context).size.width - 120) {
        _buttonOffset = MediaQuery.of(context).size.width - 120;
        if (!_navigated) {
          _navigated = true;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (!_navigated) {
      setState(() {
        _buttonOffset = 0.0; // Balik posisi awal jika belum cukup jauh
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFF9BB3CC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo NH
            Center(
              child: Image.asset(
                'assets/logo-remove.png', 
                height: 200,
              ),
            ),

            // Teks utama
            Column(
              children: const [
                Text(
                  'Atur keuangan harian\ndengan mudah',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Team and Project management\nwith solution providing App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),

            // Area drag tombol Get Started
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      'Geser untuk memulai',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    left: _buttonOffset,
                    top: 5,
                    bottom: 5,
                    child: GestureDetector(
                      onHorizontalDragUpdate: _onHorizontalDragUpdate,
                      onHorizontalDragEnd: _onHorizontalDragEnd,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.indigo,
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
