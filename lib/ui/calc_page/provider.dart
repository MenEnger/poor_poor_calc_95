import 'package:flutter/material.dart';
import 'package:retro_calc/ui/model/node.dart';

class CalcPageViewModelProvider extends ChangeNotifier {

  Node rootNode = NumberNode(0);

  /// 表示用文字列
  String get displayText {
    if (rootNode is NumberNode) {
      if (rootNode.calcNode() == 0) {
        return '${rootNode.calcNode()}';
      }
      return '${rootNode.calcNode()}_';
    } else {
      return '${rootNode.formattedString}_ = ${rootNode.calcNode()}';
    }
  }

  /// 数値ノード入力
  void inputNumber(int n) {
    // 一番右のノードを求める
    Node farRightNode = rootNode.farRightNode;

    if (farRightNode is NumberNode) {
      farRightNode.n = farRightNode.calcNode() * 10 + n;
    } else if (farRightNode is InfixNotationNode) {
      farRightNode.right = NumberNode(n);
    }
    notifyListeners();
  }

  /// 算術ノード入力
  void inputOperator(OpType type) {
    if (rootNode is NumberNode) {
      final Node target;
      switch (type) {
        case OpType.plus:
          target = PlusNode(rootNode);
          break;
        case OpType.minus:
          target = MinusNode(rootNode);
          break;
      }
      rootNode = target;
    } else if (rootNode is InfixNotationNode) {
      final infixRootNode = (rootNode as InfixNotationNode);
      var underInputting = !infixRootNode.isOperatorFixed;
      final newLeft = underInputting ? infixRootNode.left : infixRootNode;
      switch (type) {
        case OpType.plus:
          rootNode = PlusNode(newLeft);
          break;
        case OpType.minus:
          rootNode = MinusNode(newLeft);
          break;
      }
    }
    notifyListeners();
  }

  /// クリア
  void clear() {
    rootNode = NumberNode(0);
    notifyListeners();
  }
}
