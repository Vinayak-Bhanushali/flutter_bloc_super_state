import 'package:intl/intl.dart';

extension Currency on num {
  static final formatter = NumberFormat("###.0#", "en_US");
  String dollarFormat() {
    return "\$${formatter.format(this)}";
  }
}
