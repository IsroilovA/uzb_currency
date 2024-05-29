import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class CurrencyPinned {
  @HiveField(0)
  int code;
  @HiveField(1)
  bool isPinned;
  CurrencyPinned(this.code, this.isPinned);
}
