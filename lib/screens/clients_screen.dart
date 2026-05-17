import 'package:flutter/material.dart';
import 'package:carpinteria_application/models/client.dart';
import 'package:carpinteria_application/services/client_service.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final clientService = ClientService();
  List<Client> clients = [];

  @override
  void initState() {
    super.initState();
    loadClients();
  }

  void loadClients() {
    clients = clientService.loadClients();
    print(clients.length);
    setState(() {});
  }

  void showClientDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Nuevo cliente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Dirección'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final client = Client(
                  id: DateTime.now().toString(),
                  name: nameController.text,
                  phone: phoneController.text,
                  address: addressController.text,
                );
                await clientService.addClient(client);
                loadClients();
                if (context.mounted) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void showClientOptions(Client client) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar'),
              onTap: () {
                Navigator.pop(context);
                editClient(client);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Eliminar'),
              onTap: () {
                Navigator.pop(context);
                deleteClient(client);
              },
            ),
          ],
        );
      },
    );
  }

  void editClient(Client client) {
    final nameController = TextEditingController(text: client.name);
    final phoneController = TextEditingController(text: client.phone);
    final addressController = TextEditingController(text: client.address);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Editar cliente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController),
              TextField(controller: phoneController),
              TextField(controller: addressController),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final updated = Client(
                  id: client.id,
                  name: nameController.text,
                  phone: phoneController.text,
                  address: addressController.text,
                );
                await clientService.updateClient(updated);
                loadClients();
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void deleteClient(Client client) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Eliminar cliente'),
          content: Text('¿Eliminar ${client.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                await clientService.deleteClient(client.id);
                loadClients();
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showClientDialog();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text('Clientes')),
      body: clients.isEmpty
          ? const Center(child: Text('No hay clientes'))
          : ListView.builder(
              itemCount: clients.length,
              itemBuilder: (_, index) {
                final client = clients[index];
                return GestureDetector(
                  onLongPress: () {
                    showClientOptions(client);
                  },
                  child: Card(
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(client.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(client.phone),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(client.address),
                            ],
                          ),
                        ],                      
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
