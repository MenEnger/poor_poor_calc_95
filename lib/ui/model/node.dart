
enum OpType {
  plus,
  minus,
  ;
}

abstract class Node {
  Node get farRightNode;

  int calcNode();

  String get formattedString;
}

class NumberNode implements Node {
  int n;

  NumberNode(this.n);

  @override
  int calcNode() {
    return n;
  }

  @override
  Node get farRightNode => this;

  @override
  String get formattedString => '$n';
}

/// 中置記法演算子ノード
abstract class InfixNotationNode implements Node {
  late Node left;
  Node? right;

  String get symbol;

  bool get isOperatorFixed => right != null;

  @override
  Node get farRightNode => isOperatorFixed ? right! : this;

  @override
  int calcNode() {
    if (isOperatorFixed) {
      return operation(left, right!);
    }
    return left.calcNode();
  }

  int operation(Node first, Node second);

  @override
  String get formattedString => isOperatorFixed
      ? '${left.formattedString} $symbol ${right!.formattedString}'
      : '${left.formattedString} $symbol ';
}

/// 加算ノード
class PlusNode extends InfixNotationNode {
  PlusNode(Node left) {
    this.left = left;
  }

  @override
  int operation(Node first, Node second) {
    return first.calcNode() + second.calcNode();
  }

  @override
  String get symbol => '+';
}

/// 減算ノード
class MinusNode extends InfixNotationNode {
  MinusNode(Node left) {
    this.left = left;
  }

  @override
  int operation(Node first, Node second) {
    return first.calcNode() - second.calcNode();
  }

  @override
  String get symbol => '-';
}
