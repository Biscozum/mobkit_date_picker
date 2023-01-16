import 'package:flutter_test/flutter_test.dart';
import 'package:mobkit_date_picker/src/extensions/date_extensions.dart';

void main() {
  test('check isSameDay datetime extension', () {
    var dt1 = DateTime(2015, 10, 16, 11, 30);
    var dt2 = DateTime(2015, 10, 16, 16, 30);
    var dt3 = DateTime(2015, 10, 15, 16, 30);
    expect(dt1.isSameDay(dt2), true);
    expect(dt2.isSameDay(dt3), false);
  });
}
