import 'package:fintech_mobile_app/widgets/action_buttons.dart';
import 'package:fintech_mobile_app/widgets/credit_card.dart';
import 'package:fintech_mobile_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 80, 98),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Nusrat Jahan!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton.outlined(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 167),
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 110,),
                        // Action Buttons
                        ActionButtons(),
                        // Transaction List
                        SizedBox(height: 30,),
                        TransactionList(),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 25,
                    right: 25,
                    child: CreditCard(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.white,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       IconButton(
      //           onPressed: () {},
      //           icon: Column(
      //             children: [
      //               Icon(Icons.home),
      //               Text(
      //                 'Home',
      //                 style: TextStyle(
      //                   fontSize: 10,
      //                 ),
      //               )
      //             ],
      //           )
      //       ),
      //       IconButton(
      //           onPressed: () {},
      //           icon: Column(
      //             children: [
      //               Icon(Icons.credit_card),
      //               Text(
      //                 'My Card',
      //                 style: TextStyle(
      //                   fontSize: 10,
      //                 ),
      //               )
      //             ],
      //           )
      //       ),
      //       FloatingActionButton(
      //         onPressed: () {},
      //         backgroundColor: Color.fromARGB(255, 16, 80, 98),
      //         child: Icon(
      //           Icons.qr_code_scanner,
      //           color: Colors.white,
      //         ),
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(30)
      //         ),
      //       ),
      //       IconButton(
      //           onPressed: () {},
      //           icon: Column(
      //             children: [
      //               Icon(Icons.bar_chart),
      //               Text(
      //                 'Activity',
      //                 style: TextStyle(
      //                   fontSize: 10,
      //                 ),
      //               )
      //             ],
      //           )
      //       ),
      //       IconButton(
      //           onPressed: () {},
      //           icon: Column(
      //             children: [
      //               Icon(Icons.person),
      //               Text(
      //                 'Profile',
      //                 style: TextStyle(
      //                   fontSize: 10,
      //                 ),
      //               )
      //             ],
      //           )
      //       ),
      //
      //     ],
      //   ),
      // ),
    );
  }
}