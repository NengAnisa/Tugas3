import 'package:flutter/material.dart';

void main() {
  runApp(const KalkulatorApp());
}

class KalkulatorApp extends StatelessWidget {
  const KalkulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KALKULATOR BMI",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const KalkulatorScreen(),
    );
  }
}

class KalkulatorScreen extends StatefulWidget {
  const KalkulatorScreen({super.key});

  @override
  State<KalkulatorScreen> createState() => _KalkulatorScreenState();
}

class _KalkulatorScreenState extends State<KalkulatorScreen> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  double? _bmiResult;
  String _bmiInterpretation = "Silakan masukkan data Anda!";
  String _gender = "Laki-laki"; // default gender

  void _calculateBMI() {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double heightInCM = double.tryParse(_heightController.text) ?? 0;

    if (weight <= 0 || heightInCM <= 0) {
      setState(() {
        _bmiResult = null;
        _bmiInterpretation = "Masukkan data yang valid!";
      });
      return;
    }

    final double heightInM = heightInCM / 100;
    final double bmi = weight / (heightInM * heightInM);

    setState(() {
      _bmiResult = bmi;

      if (_gender == "Laki-laki") {
        if (bmi < 18.5) {
          _bmiInterpretation = "Kekurangan berat badan";
        } else if (bmi < 25) {
          _bmiInterpretation = "Berat badan ideal";
        } else if (bmi < 30) {
          _bmiInterpretation = "Kelebihan berat badan";
        } else {
          _bmiInterpretation = "Obesitas";
        }
      } else {
        if (bmi < 18) {
          _bmiInterpretation = "Kekurangan berat badan";
        } else if (bmi < 24) {
          _bmiInterpretation = "Berat badan ideal";
        } else if (bmi < 29) {
          _bmiInterpretation = "Kelebihan berat badan";
        } else {
          _bmiInterpretation = "Obesitas";
        }
      }
    });
  }

  void _resetFields() {
    setState(() {
      _weightController.clear();
      _heightController.clear();
      _bmiResult = null;
      _bmiInterpretation = "Silakan masukkan data Anda!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "KALKULATOR BMI",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 168, 3, 168),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Pilih jenis kelamin
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      "Pilih Jenis Kelamin",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: "Laki-laki",
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                        const Text("Laki-laki"),
                        const SizedBox(width: 20),
                        Radio<String>(
                          value: "Perempuan",
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                        const Text("Perempuan"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Input berat
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Berat Badan (kg)",
                prefixIcon: const Icon(Icons.monitor_weight),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Input tinggi
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Tinggi Badan (cm)",
                prefixIcon: const Icon(Icons.height),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Tombol Hitung dan Reset
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _calculateBMI,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 221, 31, 205),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  icon: const Icon(Icons.calculate),
                  label: const Text(
                    "Hitung BMI",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _resetFields,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 155, 19, 137),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    "Reset",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Hasil BMI
            const Text(
              "HASIL PERHITUNGAN",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: const Color.fromARGB(255, 234, 189, 240),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      _bmiResult != null
                          ? _bmiResult!.toStringAsFixed(1)
                          : '--',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _bmiInterpretation,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "($_gender)",
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}