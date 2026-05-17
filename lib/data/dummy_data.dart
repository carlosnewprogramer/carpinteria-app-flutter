import 'package:carpinteria_application/models/client.dart';
import 'package:carpinteria_application/models/product.dart';
import 'package:carpinteria_application/models/employee.dart';
import 'package:carpinteria_application/models/order.dart';

List<Product> products = [

  Product(
    id: '1',
    name: 'Juego Comedor Europeo',
    price: 1550000,
    stock: 5,
    imageUrl: '',
    category: 'Juegos de Comedor',
  ),

  Product(
    id: '2',
    name: 'Juego sala estilo Clásico',
    price: 2580000,
    stock: 10,
    imageUrl: '',
    category: 'Juegos de Sala',
  ),

  Product(
    id: '3',
    name: 'Puerta de Madera para cocina',
    price: 650000,
    stock: 2,
    imageUrl: '',
    category: 'Puertas',
  ),

  Product(
    id: '4',
    name: 'Juego de Alcoba Matrimonial',
    price: 2250000,
    stock: 6,
    imageUrl: '',
    category: 'Juegos de Alcoba',
  ),

  Product(
    id: '5',
    name: 'Venatana duplex',
    price: 520000,
    stock: 8,
    imageUrl: '',
    category: 'Ventanas',
  ),
  
];

List<Employee> employees = [

  Employee(
    id: '1',
    name: 'Carlos Rodriguez',
    role: 'Carpintero',
    salary: 2500000,
  ),

  Employee(
    id: '2',
    name: 'Luis Martinez',
    role: 'Ayudante',
    salary: 1500000,
  ),
];

List<Client> clients = [

  Client(
    id: '1',
    name: 'Maria Gómez',
    phone: '3001234567',
    address: 'Barrio Bellavista',
  ),

  Client(
    id: '2',
    name: 'Juan Perez',
    phone: '3019876543',
    address: 'Barrio Blanco',
  ),
];

List<Order> orders = [];