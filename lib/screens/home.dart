import 'package:budget/screens/add_category.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryScreen()),
                  );
                },
                child: Text('Add Category'),
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: () {},
                child: Text('Add Transaction'),
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: () {},
                child: Text('Total Transaction'),
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: () {},
                child: Text('Category Wise Transaction'),
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: () {},
                child: Text('Aggregate Transaction'),
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: () {},
                child: Text('Add Category'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
