import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String? email;
  @HiveField(1)
  String? password;
  @HiveField(2)
  String? name;

  User({
    this.email,
    this.password,
    this.name,
  });
}
