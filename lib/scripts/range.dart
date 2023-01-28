/// 注意! 期望 `T` 实现 `PartialEq`、`PartialOrd` 等 trait(此处并不严格要求自反性), 但在 dart 中无法做出此类限制 <br/>
/// 请使用添加了断言约束的子类 [RangeInt]、 [RangeDate]
///
/// `rusty code` <br/>
/// struct Range<T> <br/>
/// &nbsp;&nbsp;&nbsp;&nbsp;where T: PartialEq + PartialOrd { <br/>
/// &nbsp;&nbsp;&nbsp;&nbsp;min: T, <br/>
/// &nbsp;&nbsp;&nbsp;&nbsp;max: T, <br/>
/// } <br/>
class RangeBase<T> {
  final T? min;
  final T? max;

  const RangeBase({this.min, this.max});
}

/// 整数范围
class RangeInt extends RangeBase<int> {
  RangeInt({required super.min, required super.max})
      : assert(min == null || max == null || min <= max);
}

/// 日期范围
class RangeDate extends RangeBase<DateTime> {
  RangeDate({required super.min, required super.max})
      : assert(min == null || max == null || !min.isAfter(max));
}
