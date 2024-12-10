import 'package:flutter/material.dart';

class TenantListScreen extends StatelessWidget {
  // Liste fictive de locataires
  final List<Map<String, String>> tenants = List.generate(60, (index) {
    return {
      'name': 'Locataire ${index + 1}',
      'surname': 'Nom ${index + 1}',
      'phone': '+123456789${index % 10}', // Numéros fictifs
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des Locataires"),
      ),
      body: ListView.builder(
        itemCount: tenants.length,
        itemBuilder: (context, index) {
          final tenant = tenants[index];
          return ListTile(
            title: Text('${tenant['name']} ${tenant['surname']}'),
            subtitle: Text('Téléphone: ${tenant['phone']}'),
            leading: CircleAvatar(
              child: Text('${tenant['name']![0]}'), // Initiale du prénom
            ),
            onTap: () {
              // Action à effectuer lors du tap sur un locataire
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Détails de ${tenant['name']}')),
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TenantListScreen(),
  ));
}