

class Wei {
  late BigInt src;
  late String currency;
  final conversor = BigInt.from(1000000000000000000);

  Wei({required this.src, required this.currency});

  String toRBTCString() {
    var valueMul2 =  src / conversor;
    return valueMul2.toStringAsFixed(18);
  }

  String toRBTCTrimmedString() {
    var valueMul = src / conversor;
    return valueMul.toStringAsFixed(2);
  }

  double getWei() {
    return src / conversor;
  }

}
