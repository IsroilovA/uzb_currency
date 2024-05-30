import 'package:hive/hive.dart';

part 'currency_pinned.g.dart';

@HiveType(typeId: 1)
class CurrencyPinned {
  @HiveField(0)
  int id;
  @HiveField(1)
  int code;
  CurrencyPinned(this.id, this.code);
}
