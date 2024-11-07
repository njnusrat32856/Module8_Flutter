import 'dart:convert';

import 'package:bank_flutter/models/user.dart';
import 'package:bank_flutter/screens/deposit_screen.dart';
import 'package:bank_flutter/screens/login_screen.dart';
import 'package:bank_flutter/screens/user_profile.dart';
import 'package:bank_flutter/services/transaction_service.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class UserDashboardScreen extends StatefulWidget {

  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  late final User? user;
  // final String? errorMessage;

  //for deposit
  final TransactionService transactionService = TransactionService();

  int userId = 0;
  double amount = 0;
  String description = '';
  String message = '';
  String errorMessage = '';

  final _formKey = GlobalKey<FormState>();

  void makeDeposit() async {
    if (_formKey.currentState!.validate() ?? false) {
      try {
        await transactionService.depositMoney(userId, amount, description);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Deposit Pending"),
            content: Text(
                "Your deposit of $amount is pending approval. Once approved by the admin, your balance will be updated."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
        );

        setState(() {
          message = 'Successfully deposited $amount for user $userId.';
          errorMessage = '';
          clearForm();
        });
      } catch (error) {
        setState(() {
          errorMessage = 'An error occurred during the deposit. Please try again.';
          message = '';
        });
        print(error);
      }
    }
  }

  void clearForm() {
    setState(() {
      userId = 0;
      amount = 0;
      description = '';
    });
  }
  // end deposit

  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  // int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'User Dashboard',
          style: TextStyle(
              color: Colors.white
          ),
        ),
        automaticallyImplyLeading: false, // Hides the back button
        backgroundColor: Colors.blue,
      ),
      //If you want to show body behind the navbar, it should be true
      extendBody: true,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              // showTooltip: false,
              displayMode: SideMenuDisplayMode.auto,
              showHamburger: true,
              hoverColor: Colors.blue[100],
              selectedHoverColor: Colors.blue[100],
              selectedColor: Colors.lightBlue,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.grey[200]
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 80,
                    maxWidth: 80,
                  ),
                  child: Image.asset(
                    'assets/images/banklogo.png',
                  ),
                ),
                const Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Text(
                    'User',
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),
                ),
              ),
            ),
            items: [
              SideMenuItem(
                title: 'Dashboard',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.home),
                // badgeContent: const Text(
                //   '3',
                //   style: TextStyle(color: Colors.white),
                // ),
                // tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Users Profile',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.supervisor_account),
              ),
              SideMenuExpansionItem(
                title: "Transactions",
                icon: const Icon(Icons.credit_card),
                children: [
                  SideMenuItem(
                    title: 'Deposit',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                    },
                    icon: const Icon(Icons.save),
                    // badgeContent: const Text(
                    //   '3',
                    //   style: TextStyle(color: Colors.white),
                    // ),
                    // tooltipContent: "Transaction History",
                  ),
                  SideMenuItem(
                    title: 'Withdraw',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                    },
                    icon: const Icon(Icons.money_off),
                  ),
                  SideMenuItem(
                    title: 'Fund Transfer',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                    },
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
              SideMenuExpansionItem(
                title: "Loan Management",
                icon: const Icon(Icons.credit_card),
                children: [
                  SideMenuItem(
                    title: 'Loan Application',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                    },
                    icon: const Icon(Icons.save),
                    // badgeContent: const Text(
                    //   '3',
                    //   style: TextStyle(color: Colors.white),
                    // ),
                    // tooltipContent: "Transaction History",
                  ),
                  SideMenuItem(
                    title: 'Loan Details',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                    },
                    icon: const Icon(Icons.money_off),
                  ),
                  // SideMenuItem(
                  //   title: 'Fund Transfer',
                  //   onTap: (index, _) {
                  //     sideMenu.changePage(index);
                  //   },
                  //   icon: const Icon(Icons.send_rounded),
                  // ),
                ],
              ),
              // SideMenuItem(
              //   title: 'Loan Management',
              //   onTap: (index, _) {
              //     sideMenu.changePage(index);
              //   },
              //   icon: const Icon(Icons.file_copy_rounded),
              //   trailing: Container(
              //       decoration: const BoxDecoration(
              //           color: Colors.amber,
              //           borderRadius: BorderRadius.all(Radius.circular(6))),
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 6.0, vertical: 3),
              //         child: Text(
              //           'New',
              //           style: TextStyle(fontSize: 11, color: Colors.grey[800]),
              //         ),
              //       )),
              // ),
              SideMenuItem(
                title: 'Search',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.search),
              ),
              SideMenuItem(
                builder: (context, displayMode) {
                  return const Divider(
                    endIndent: 8,
                    indent: 8,
                  );
                },
              ),
              SideMenuItem(
                title: 'Settings',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.settings),
              ),
              // SideMenuItem(
              //   onTap:(index, _){
              //     sideMenu.changePage(index);
              //   },
              //   icon: const Icon(Icons.image_rounded),
              // ),
              // SideMenuItem(
              //   title: 'Only Title',
              //   onTap:(index, _){
              //     sideMenu.changePage(index);
              //   },
              // ),
              SideMenuItem(
                title: 'Logout',
                icon: Icon(Icons.exit_to_app),
                onTap: (int index, SideMenuController controller) {
                  _logout(context);
                },
              ),
            ],
          ),
          const VerticalDivider(
            width: 0,
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(
                            "https://t3.ftcdn.net/jpg/01/36/33/14/360_F_136331491_vRh0iHpvyi5juqXvbtujaibNIj6Xvyoh.jpg"),
                        Text(
                          'Welcome to Bank!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // Implement logout functionality or navigate back to login
                        //     Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => LoginScreen()),
                        //     ); // Example logout: navigate back to login
                        //   },
                        //   child: Text(
                        //     'Logout',
                        //     style: TextStyle(color: Colors.white),
                        //   ),
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.redAccent,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // color: Colors.white,
                  // child: const Center(
                  //   child: Text(
                  //     'Dashboard',
                  //     style: TextStyle(fontSize: 35),
                  //   ),
                  // ),
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'User Profile',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Column(
                        children: [
                            
                        ],
                      )
                      // ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=> UserProfile(user: )));
                      // },
                      //     child: Text(
                      //       'View Details'
                      //     )
                      // )
                    ],
                  ),
                  // child: const Center(
                  //   child: Text(
                  //     'Users Profile',
                  //     style: TextStyle(fontSize: 35),
                  //   ),
                  // ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,  // Uncomment if you want a white background
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Deposit',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 5), // Space between title and DepositScreen
                      // DepositScreen(userId: hashCode),
                      // DepositScreen(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                decoration: InputDecoration(labelText: 'User ID'),
                                keyboardType: TextInputType.number,
                                onChanged: (value) => userId = int.tryParse(value) ?? 0,
                                validator: (value) {
                                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                                    return 'Please enter a valid user ID';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: 'Amount'),
                                keyboardType: TextInputType.number,
                                onChanged: (value) => amount = double.tryParse(value) ?? 0,
                                validator: (value) {
                                  if (value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0) {
                                    return 'Deposit amount must be greater than zero.';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: 'Description'),
                                onChanged: (value) => description = value,
                              ),
                              SizedBox(height: 10.0),
                              ElevatedButton(
                                onPressed: makeDeposit,
                                child: Text('Make Deposit'),
                              ),
                              if (errorMessage.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    errorMessage,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   color: Colors.white,
                //   child: const Center(
                //     child: Text(
                //       'Deposit',
                //       style: TextStyle(fontSize: 35),
                //     ),
                //   ),
                // ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Withdraw',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Fund Transfer',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Files',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Download',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),

                // this is for SideMenuItem with builder (divider)
                const SizedBox.shrink(),

                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // body: SingleChildScrollView( // This enables scrolling if content overflows
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //       Image.network(
      //         "https://t3.ftcdn.net/jpg/01/36/33/14/360_F_136331491_vRh0iHpvyi5juqXvbtujaibNIj6Xvyoh.jpg",
      //         fit: BoxFit.cover,
      //       ),
      //       SizedBox(height: 15,),
      //       Text(
      //         'Welcome to Bank!',
      //         style: TextStyle(
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.blueAccent,
      //         ),
      //         textAlign: TextAlign.center,
      //       ),
      //       SizedBox(height: 20),
      //     ],
      //   ),
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.white,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       tabItem(Icons.home, "Home", 0),
      //       tabItem(Icons.credit_card, "Transactions", 1),
      //       // tabItem(Icons.credit_card, "", 2),
      //       FloatingActionButton(
      //         onPressed: () => onTabTapped(2),
      //         backgroundColor: Color.fromARGB(255, 16, 80, 98),
      //         child: Icon(
      //           Icons.qr_code_scanner,
      //           color: Colors.white,
      //         ),
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(30)
      //         ),
      //       ),
      //       tabItem(Icons.bar_chart, "Activity", 3),
      //       tabItem(Icons.person, "Profile", 4),
      //     ],
      //   ),
      // ),
    );
  }
  // Widget tabItem(IconData icon, String label, int index) {
  //   return IconButton(
  //     onPressed: () => onTabTapped(index),
  //     icon: Column(
  //       children: [
  //         Icon(
  //           icon,
  //           color: currentIndex == index ? Colors.black : Colors.grey,
  //         ),
  //         Text(
  //           label,
  //           style: TextStyle(
  //             fontSize: 10,
  //             color: currentIndex == index ? Theme.of(context).primaryColor : Colors.grey,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
  // void onTabTapped (int index) {
  //   setState(() {
  //     currentIndex = index;
  //   });
  // }

  // Define a logout function
  void _logout(BuildContext context) {
    // Here, you would typically clear stored user data
    // e.g., shared preferences, cache, or secure storage.
    // After clearing the data, navigate to the login screen.

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LoginScreen()), // Replace with your login page widget
    );
  }

  // Widget to build individual profile items
  Widget _buildProfileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
