abstract class ValueTypes {
  final dynamic value;
  const ValueTypes(this.value);
}

class IntType implements ValueTypes {
  IntType(this.intValue);
  final int intValue;

  @override
  get value => intValue;
}

class StringType implements ValueTypes {
  const StringType(this.stringValue);
  final String stringValue;
  @override
  get value => stringValue;
}

class StringListType implements ValueTypes {
  const StringListType(this.list);
  final List<String> list;
  @override
  get value => list;
}

class BoolType implements ValueTypes {
  const BoolType(this.boolValue);
  final bool boolValue;
  @override
  get value => boolValue;
}

class DoubleType implements ValueTypes {
  const DoubleType(this.doubleValue);
  final double doubleValue;
  @override
  get value => doubleValue;
}
