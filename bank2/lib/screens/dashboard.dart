import 'package:bank2/widgets/action_button.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
                          style: TextStyle(color: Colors.white,fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        // Text(
                        //   "Nusrat Jahan!",
                        //   style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 24,
                        //       fontWeight: FontWeight.bold),
                        // ),
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
                          // TransactionList(),
                        ],
                      ),
                    ),
                    // Positioned(
                    //   top: 20,
                    //   left: 25,
                    //   right: 25,
                    //   child: CreditCard(),
                    // )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
