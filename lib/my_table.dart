import 'package:flutter/material.dart';

List<int> colorValues = [0xFF99FF90, 0xFFC4C4C4];
List<String> categoryNames = ['Electric', 'Plumbing'];

class MyTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tables'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text('Color'),
                ),
              ),
              Center(child: Text('Category')),
              Center(child: Text('Action')),
            ],
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
              verticalInside: BorderSide(color: Colors.grey),
              //   horizontalInside: BorderSide(color: Colors.grey),
            ),
            columnWidths: {
              0: FractionColumnWidth(.32),
              1: FractionColumnWidth(.32),
              2: FractionColumnWidth(.32),
            },
            children: List.generate(categoryNames.length, (index) {
              return TableRow(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 2),
                    height: 36,
                    color: Color(colorValues[index]),
                    child: Center(
                      child: Container(
                        height: 20,
                        width: 40,
                        color: Color(colorValues[index]),
                      ),
                    ),
                  ),
                  Container(
                    height: 36,
                    color: Color(colorValues[index]),
                    child: Center(child: Text(categoryNames[index])),
                  ),
                  Container(
                    height: 36,
                    color: Color(colorValues[index]),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit),
                          Icon(Icons.delete_forever),
                        ],
                      ),
                    ),
                  ),
                ],
                // decoration: BoxDecoration(
                //   color: Color(colorValues[index]),
                // ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
