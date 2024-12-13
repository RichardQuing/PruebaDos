import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
        centerTitle: true,
        backgroundColor: Colors.teal[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: formularioRegistro(),
      ),
      backgroundColor: Colors.grey[850],
    );
  }
}

Widget formularioRegistro() {
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _contrasena = TextEditingController();

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Text(
        "Crea tu cuenta",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 40),
      TextField(
        controller: _correo,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          label: const Text("Correo Electrónico"),
          prefixIcon: const Icon(Icons.email, color: Colors.teal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 62, 62, 62),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        style: const TextStyle(color: Colors.white),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: _contrasena,
        obscureText: true,
        decoration: InputDecoration(
          label: const Text("Contraseña"),
          prefixIcon: const Icon(Icons.lock, color: Colors.teal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 81, 81, 81),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        style: const TextStyle(color: Colors.white),
      ),
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: () => guardar(_correo.text, _contrasena.text),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.app_registration, color: Colors.white),
            SizedBox(width: 8),
            Text("Registrar"),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "¿Ya tienes una cuenta? ",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Inicia sesión",
              style: TextStyle(color: Colors.teal, fontSize: 16),
            ),
          ),
        ],
      ),
    ],
  );
}

Future<void> guardar(String correo, String contrasena) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("usuarios/");

  DatabaseReference newRef = ref.push();

  await newRef.set({
    "correo": correo,
    "contrasena": contrasena,
  });
}
