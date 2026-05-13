import 'package:flutter/material.dart';
import 'package:carpinteria_application/data/dummy_data.dart';
import 'package:carpinteria_application/models/order.dart';

class OrdersHistoryScreen extends StatefulWidget{
  const OrdersHistoryScreen({super.key});

  @override
  State<OrdersHistoryScreen> createState() => _OrdersHistoryScreenState();
  
}

class _OrdersHistoryScreenState extends State<OrdersHistoryScreen>{
  List<Order> filteredOrders = orders;
  final TextEditingController searchController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  void searchOrders(String query){
    setState(() {
      filteredOrders = orders.where((order){
        return order.client.name
          .toLowerCase()
          .contains(query.toLowerCase());
      }).toList();
    });
  }

  double calculateClientTotal(){
    double total = 0;
    for (var order in filteredOrders){
      total += order.total;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historial de pedidos',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //=======BUSCADOR DE PEDIDOS========
            Container(
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
              child: TextField(
                controller: searchController,
                onChanged: searchOrders,
                decoration: InputDecoration(
                  hintText: 'Buscar cliente...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.brown,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            //======TOTAL CLIENTE======
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text('Total en compras',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${calculateClientTotal().toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            //========LISTA PEDIDOS=======
            Expanded(
              child: filteredOrders.isEmpty ? Center(
                child: Text('No hay pedidos',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              )
              : ListView.builder(
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index){
                    final order = filteredOrders[index];
                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: 14,
                      ),
                      padding: const EdgeInsets.all(18),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //=======CLIENTE=======
                            Text(
                              order.client.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            //=======PRODUCTOS=======
                            Text(
                              '${order.products.length} productos',
                            ),
                            const SizedBox(height: 6),
                            //=======TOTAL=======
                            Text(
                              'Total: \$${order.total.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //========ESTADO========
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    order.status,
                                    style: const TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                //=======FECHA=======
                                Text(
                                  '${order.date.day}/${order.date.month}/${order.date.year}',
                                ),
                              ],
                            ),
                          ],
                        ),
                    );
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }
}