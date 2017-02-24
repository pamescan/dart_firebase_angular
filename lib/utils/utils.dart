import 'dart:math';

class utils {
  static randomRangeValue(int max) {
    var rng = new Random();

    return rng.nextInt(max);
  }
static String getRandomBasicColor(){
   return colors[randomRangeValue(colors.length)];
}
  static List colors = [
    'f44336',
    'E91E63',
    '9C27B0',
    '673AB7',
    '3F51B5',
    '2196F3',
    '03A9F4',
    '00BCD4',
    '009688',
    '4CAF50',
    '8BC34A',
    'CDDC39',
    'FFEB3B',
    'FFC107',
    'FF9800',
    'FF5722',
    '795548',
    '9E9E9E',
    '607D8B'
  ];
}

class Color {
  String name;
  String value;
}

