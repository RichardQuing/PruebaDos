import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/navegadores/drawer.dart'; // Asegúrate de tener el drawer adecuado
import 'package:http/http.dart' as http;

// Función para obtener los datos de las series desde la API
Future<List> obtenerSeries(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['series']; // Accede a la lista bajo la clave 'series'
  } else {
    throw Exception("No se pudo conectar");
  }
}

class ListaSeries extends StatelessWidget {
  const ListaSeries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MiDrawer(), // Asegúrate de tener el drawer configurado
      appBar: AppBar(
        title: Text("Lista de Series"),
        backgroundColor: Colors.teal[800],
      ),
      body: listViewSeries(
          "https://jritsqmet.github.io/web-api/series.json"), // URL de la API
      backgroundColor: Colors.grey[850],
    );
  }

  // Widget que maneja la visualización de las series
  Widget listViewSeries(String url) {
    return FutureBuilder(
      future: obtenerSeries(url), // Llama a la función que obtiene los datos
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final serie = data[index];
              return Card(
                color: Colors.grey[800], // Card de color oscuro
                child: ListTile(
                  title: Text(
                    serie['titulo'], // Título de la serie
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Column(
                    children: [
                      Image.network(
                        serie["info"]["imagen"], // Imagen de la serie
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  onTap: () {
                    // Al tocar un elemento, mostrar más información en un AlertDialog
                    _showSeriesDetails(serie, context);
                  },
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // Función que muestra un cuadro de diálogo con más detalles de la serie
  void _showSeriesDetails(Map serie, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: Text(
            serie['titulo'],
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(serie['info']['imagen']), // Imagen de la serie
              SizedBox(height: 10),
              Text(
                  "Año: ${serie['anio']}",
                  style: TextStyle(color: Colors.white), // Año de la serie
              ),
              SizedBox(height: 10),
              Text(
                  "Descripción: ${serie['descripcion']}",
                  style: TextStyle(color: Colors.white), // Descripción de la serie
              ),
              SizedBox(height: 10),
              Text(
                  "Creador: ${serie['metadata']['creador']}",
                  style: TextStyle(color: Colors.white), // Creador de la serie
              ),
              SizedBox(height: 10),
              Text(
                  "Temporadas: ${serie['metadata']['temporadas']}",
                  style: TextStyle(color: Colors.white), // Temporadas
              ),
              SizedBox(height: 10),
              Text("Ver en IMDb: ", style: TextStyle(color: Colors.white)),
              GestureDetector(
                child: Text(
                  serie['info']['url'],
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(height: 10),
              Text("Ver Tráiler: ", style: TextStyle(color: Colors.white)),
              GestureDetector(
                child: Text(
                  serie['info']['trailer'],
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cerrar',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }
}
