import 'package:flutter/material.dart';
import 'package:carpinteria_application/data/dummy_data.dart';
import 'package:carpinteria_application/models/client.dart';
import 'package:carpinteria_application/models/product.dart';
import 'package:carpinteria_application/models/order.dart';
import 'package:carpinteria_application/screens/orders_history_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Client? selectedClient;
  List<Product> selectedProducts = [];
  double total = 0;

  void calculateTotal() {
    total = selectedProducts.fold(0, (sum, product) => sum + product.price);
  }

  void addProduct(Product product) {
    setState(() {
      selectedProducts.add(product);
      calculateTotal();
    });
  }

  void removeProduct(Product product) {
    setState(() {
      selectedProducts.remove(product);
      calculateTotal();
    });
  }

  void saveOrder() {
    if (selectedClient == null || selectedProducts.isEmpty) {
      return;
    }
    final order = Order(
      id: DateTime.now().toString(),
      client: selectedClient!,
      products: selectedProducts,
      total: total,
      date: DateTime.now(),
      status: 'Pendiente',
    );
    orders.add(order);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pedido creado correctamente')),
    );
    setState(() {
      selectedClient = null;
      selectedProducts = [];
      total = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => OrdersHistoryScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.history,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveOrder,
        child: const Icon(Icons.save),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //========CLIENTE========
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Client>(
                    value: selectedClient,
                    hint: const Text('Seleccionar cliente'),
                    isExpanded: true,
                    items: clients.map((client) {
                      return DropdownMenuItem(
                        value: client,
                        child: Text(client.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedClient = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //========PRODUCTOS A SELLECCIONAR========
              const Text(
                'Seleccionar productos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        addProduct(product);
                      },
                      child: Container(
                        width: 160,
                        margin: const EdgeInsets.only(right: 14),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text('\$${product.price}'),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.brown.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                product.category,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              //========PRODUCTOS AGREGADOS========
              const Text(
                'Productos agregados',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: selectedProducts.length,
                  itemBuilder: (context, index) {
                    final product = selectedProducts[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(product.name),
                        subtitle: Text('\$${product.price}'),
                        trailing: IconButton(
                          onPressed: () {
                            removeProduct(product);
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              //========Total========
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Total: \$${total.toStringAsFixed(0)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
