import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter95/flutter95.dart';
import 'package:retro_calc/ui/model/node.dart';

import 'provider.dart';

/// 電卓画面
class CalcPage extends StatelessWidget {
  const CalcPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CalcPageViewModelProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold95(
      title: 'Poor Poor Calc 95',
      body: DefaultTextStyle(
        style: Flutter95.textStyle,
        child: Consumer<CalcPageViewModelProvider>(
          builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Material(
                  child: Elevation95(
                    child: Text(
                      'Start the calculation by pressing the number button below.',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Elevation95(
                      type: Elevation95Type.down,
                      child: Text(
                        provider.displayText,
                        style: Flutter95.textStyle,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
                Table(
                    border: TableBorder.all(color: Colors.white),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(1.0),
                      1: FlexColumnWidth(1.0),
                      2: FlexColumnWidth(1.0),
                      3: FlexColumnWidth(1.0),
                    },
                    // defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    children: [
                      TableRow(children: [
                        const CalcNumButton(n: 7),
                        const CalcNumButton(n: 8),
                        const CalcNumButton(n: 9),
                        CalcButton(
                          text: 'AC',
                          onTap: () => provider.clear(),
                        ),
                      ]),
                      const TableRow(children: [
                        CalcNumButton(n: 4),
                        CalcNumButton(n: 5),
                        CalcNumButton(n: 6),
                        SizedBox.shrink(),
                      ]),
                      const TableRow(children: [
                        CalcNumButton(n: 1),
                        CalcNumButton(n: 2),
                        CalcNumButton(n: 3),
                        SizedBox.shrink(),
                      ]),
                      TableRow(children: [
                        const CalcNumButton(n: 0),
                        CalcButton(
                          onTap: () => provider.inputOperator(OpType.plus),
                          text: '+',
                        ),
                        CalcButton(
                          onTap: () => provider.inputOperator(OpType.minus),
                          text: '-',
                        ),
                        const SizedBox.shrink(),
                      ]),
                    ]),
                // Button95(
                //   onTap: () => provider.incrementCount(),
                //   child: const Text('count!'),
                // )
              ],
            );
          },
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/// 数字ボタン
class CalcNumButton extends StatelessWidget {
  const CalcNumButton({
    Key? key,
    required this.n,
  }) : super(key: key);

  final int n;

  @override
  Widget build(BuildContext context) {
    return Consumer<CalcPageViewModelProvider>(
      builder: (context, provider, child) {
        return Button95(
          onTap: () => provider.inputNumber(n),
          child: Center(
              child: Text(
            '$n',
            textAlign: TextAlign.center,
          )),
        );
      },
    );
  }
}

/// 電卓ボタン
class CalcButton extends StatelessWidget {
  const CalcButton({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Button95(
      onTap: onTap,
      child: Center(
          child: Text(
        text,
        textAlign: TextAlign.center,
      )),
    );
  }
}
