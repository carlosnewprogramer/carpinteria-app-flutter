import 'package:carpinteria_application/models/client.dart';
import 'package:hive/hive.dart';

class ClientService {

  final Box<Client> box =
      Hive.box<Client>(
        'clients',
      );

  Future<void> initializeClients() async {
    if (box.isNotEmpty){
      return;
    }
    final clients = [
      Client(
        id: '1',
        name: 'Yesid Jimenez',
        phone: '3145897625',
        address: 'mz 5 cs 40 Urb Panamericana'
      ),
      Client(
        id: '2',
        name: 'Diana Rodriguez',
        phone: '31689745872',
        address: 'mz 5 cs 41 Urb Panamericana'
      ),
    ];
    for (var client in clients){
      await box.put(
        client.id,
        client,
      );
    }  
  }

  //======= LEER =======
  List<Client> loadClients(){

    return box.values.toList();
  }

  //======= AGREGAR =======
  Future<void> addClient(
    Client client,
  ) async {

    await box.put(
      client.id,
      client,
    );
  }

  //======= ACTUALIZAR =======
  Future<void> updateClient(
    Client client,
  ) async {

    await box.put(
      client.id,
      client,
    );
  }

  //======= ELIMINAR =======
  Future<void> deleteClient(
    String id,
  ) async {

    await box.delete(
      id,
    );
  }
}