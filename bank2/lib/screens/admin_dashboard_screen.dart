import 'package:bank2/screens/login_screen.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMSBank Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false, // Hides the back button
        backgroundColor: Colors.blue,
      ),
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
                    'Admin',
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
                badgeContent: const Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Users Details',
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
                    title: 'Transaction History',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                    },
                    icon: const Icon(Icons.money),
                    badgeContent: const Text(
                      '3',
                      style: TextStyle(color: Colors.white),
                    ),
                    tooltipContent: "Transaction History",
                  ),
                  SideMenuItem(
                    title: 'Expansion Item 2',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                    },
                    icon: const Icon(Icons.supervisor_account),
                  )
                ],
              ),
              SideMenuItem(
                title: 'Loan Management',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.file_copy_rounded),
                trailing: Container(
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 3),
                      child: Text(
                        'New',
                        style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                      ),
                    )),
              ),
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
                          'Welcome, Admin!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton.icon(
                          icon: Icon(Icons.people),
                          label: Text(
                            'View Users Accounts',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            // Navigate to users page or call an API to fetch users
                            print("View Users clicked");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton.icon(
                          icon: Icon(Icons.attach_money),
                          label: Text(
                            'Manage Transactions',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            // Navigate to manage hotels page or call an API to manage hotels
                            print("Manage Hotels clicked");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton.icon(
                          icon: Icon(Icons.approval),
                          label: Text(
                            'Approve Or Deny Account',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            // Implement logout functionality or navigate back to login
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => AddHotelPage()),
                            // ); // Example logout: navigate back to login
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton.icon(
                          icon: Icon(Icons.settings),
                          label: Text(
                            'Settings',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            // Navigate to settings page
                            print("Settings clicked");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
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
                  child: const Center(
                    child: Text(
                      'Users',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Expansion Item 1',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Expansion Item 2',
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
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //       Image.network("https://t3.ftcdn.net/jpg/01/36/33/14/360_F_136331491_vRh0iHpvyi5juqXvbtujaibNIj6Xvyoh.jpg"),
      //       Text(
      //         'Welcome, Admin!',
      //         style: TextStyle(
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.blueAccent,
      //         ),
      //         textAlign: TextAlign.center,
      //       ),
      //       SizedBox(height: 20),
      //       ElevatedButton.icon(
      //         icon: Icon(Icons.people),
      //         label: Text(
      //             'View Users Accounts',
      //           style: TextStyle(
      //             color: Colors.white
      //           ),
      //         ),
      //         onPressed: () {
      //           // Navigate to users page or call an API to fetch users
      //           print("View Users clicked");
      //         },
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.blueAccent,
      //         ),
      //       ),
      //       SizedBox(height: 10),
      //       ElevatedButton.icon(
      //         icon: Icon(Icons.attach_money),
      //         label: Text(
      //           'Manage Transactions',
      //           style: TextStyle(
      //               color: Colors.white
      //           ),
      //         ),
      //         onPressed: () {
      //           // Navigate to manage hotels page or call an API to manage hotels
      //           print("Manage Hotels clicked");
      //         },
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.blueAccent,
      //         ),
      //       ),
      //       SizedBox(height: 10),
      //
      //
      //       ElevatedButton.icon(
      //         icon: Icon(Icons.approval),
      //         label: Text(
      //           'Approve Or Deny Account',
      //           style: TextStyle(
      //               color: Colors.white
      //           ),
      //         ),
      //         onPressed: () {
      //           // Implement logout functionality or navigate back to login
      //           // Navigator.pushReplacement(
      //           //   context,
      //           //   MaterialPageRoute(builder: (context) => AddHotelPage()),
      //           // ); // Example logout: navigate back to login
      //         },
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.blueAccent,
      //         ),
      //       ),
      //       SizedBox(height: 10),
      //
      //
      //       ElevatedButton.icon(
      //         icon: Icon(Icons.settings),
      //         label: Text(
      //             'Settings',
      //           style: TextStyle(
      //               color: Colors.white
      //           ),
      //         ),
      //         onPressed: () {
      //           // Navigate to settings page
      //           print("Settings clicked");
      //         },
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.blueAccent,
      //         ),
      //       ),
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: () {
      //           // Implement logout functionality or navigate back to login
      //           Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(builder: (context) => LoginScreen()),
      //           ); // Example logout: navigate back to login
      //         },
      //         child: Text(
      //             'Logout',
      //           style: TextStyle(
      //               color: Colors.white
      //           ),
      //         ),
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.redAccent,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

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
}
