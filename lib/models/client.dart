import 'package:hive/hive.dart';

part 'client.g.dart';

@HiveType(typeId: 1)
class Client {

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String address;

  Client({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
  });
}