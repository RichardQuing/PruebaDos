import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/comentarios.dart';
import 'package:flutter_application_1/screens/listaSeries.dart';

class MiDrawer extends StatelessWidget {
  const MiDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
            child: ListView(
        children: [
          ListTile(
            title: Text("Comentarios"),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Comentarios())),
          ),
          ListTile(
            title: Text("Lista de series"),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => ListaSeries())),
          ),
        ],
      ),
    );
  }
}