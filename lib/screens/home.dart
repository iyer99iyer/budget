import 'package:budget/Widgets/home_page_button_widget.dart';
import 'package:budget/screens/transaction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'aggregate_transaction.dart';
import 'category.dart';
import 'category_wise_transaction.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Color(0xFFDDCC92),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                'Budget',
                style: GoogleFonts.rockSalt(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryScreen()),
                      );
                    },
                    child: HomePageBigButton(
                      color: Color(0xFF2F5A9B),
                      text: 'Category',
                      imageLocation: 'images/category.png',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Transaction()),
                      );
                    },
                    child: HomePageBigButton(
                      color: Color(0xFFBB3C3C),
                      text: 'Transaction',
                      imageLocation: 'images/transaction.png',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryWiseTransaction()),
                  );
                },
                child: HomePageLongButton(
                  color: Color(0xFF468C49),
                  text: 'Category-wise Transaction',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AggregateTransaction()),
                  );
                },
                child: HomePageLongButton(
                  color: Color(0xFFBC950D),
                  text: 'Aggregate Transaction',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
