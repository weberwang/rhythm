import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('initialization scaffold directories exist', () {
    expect(Directory('lib').existsSync(), isTrue);
    expect(Directory('lib/app').existsSync(), isTrue);
    expect(Directory('lib/core').existsSync(), isTrue);
    expect(Directory('lib/shared').existsSync(), isTrue);
    expect(Directory('lib/features').existsSync(), isTrue);
  });
}
