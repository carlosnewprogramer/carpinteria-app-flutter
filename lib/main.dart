import 'package:carpinteria_application/home_screen.dart';
import 'package:carpinteria_application/models/client.dart';
import 'package:carpinteria_application/models/product.dart';
import 'package:carpinteria_application/services/client_service.dart';
import 'package:carpinteria_application/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(
    ProductAdapter(),
  );
  Hive.registerAdapter(
      ClientAdapter(),
  );
  await Hive.openBox<Product>(
    'products',
  );
  await Hive.openBox<Client>(
    'clients',
  );
  await Hive.openBox(
    'categories',
  );
  await ProductService().initializeProducts();
  await ClientService().initializeClients();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carpinteria App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey.shade100,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFD7CCC8),
          foregroundColor: Color(0xFF4E342E),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4E342E),
          ),
        ),      
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
