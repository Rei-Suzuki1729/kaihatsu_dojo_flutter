import 'dart:math';

///properties
class DiffConditionModel {
  double? DiffCondition;
  double? Condition;

  ///DiffConditionの計算
  double? DiffConditionCalc ({required YesterdayConditon, required Condition}) {
    DiffCondition = Condition - YesterdayConditon;
    return DiffCondition;
  }
}
