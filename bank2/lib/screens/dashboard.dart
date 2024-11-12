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
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                // padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5,),
                        Text(
                          "BMSBank",
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
              SizedBox(height: 16,),
              // Container(
              //   height: 200,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(16),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black26,
              //         blurRadius: 10,
              //         offset: Offset(0, 5),
              //       )
              //     ]
              //   ),
              //   margin: EdgeInsets.symmetric(horizontal: 16),
              //   clipBehavior: Clip.antiAlias,
              //   child: Image.asset(
              //     "assets/images/bankimage.jpg",
              //     fit: BoxFit.contain,
              //   ),
              // ),
              // Image.asset(
              //   "assets/images/bankimage.jpg",
              //   fit: BoxFit.cover,
              // ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 110),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24))
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 80,),
                          Text(
                            "Quick Actions",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 16, 80, 98),
                            ),
                          ),
                          SizedBox(height: 16,),
                          // Action Buttons
                          ActionButtons(),
                          // Transaction List
                          SizedBox(height: 30,),
                          // TransactionList(),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 25,
                      right: 25,
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 32, 160, 180),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              "Welcome to Bank!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
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
