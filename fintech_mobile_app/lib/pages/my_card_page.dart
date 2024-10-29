import 'package:fintech_mobile_app/widgets/credit_card.dart';
import 'package:flutter/material.dart';

class MyCardPage extends StatelessWidget {
  const MyCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton.outlined(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
            )
        ),
        title: Text(
          'My Cards',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20,),
              // back-card
              BackCard(),
              SizedBox(height: 25,),
              // front-card
              FrontCard(),
              SizedBox(height: 30,),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                label: Text(
                  'Add New Card',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.grey[100]!
                  ),
                  fixedSize: Size(double.maxFinite, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  backgroundColor: Colors.grey[100],
                  foregroundColor: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FrontCard extends StatelessWidget {
  const FrontCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 240,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    color: Color.fromARGB(255, 14, 19, 29),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Image.asset(
                            "assets/credit-card.png",
                            height: 40,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 70,
                          child: Image.asset(
                            "assets/wifi.png",
                            height: 50,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                            bottom: 16,
                            left: 16,
                            child: Text(
                              "**** **** **** 1999",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              ),
                            )
                        ),
                      ],
                    ),
                  )
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Color.fromARGB(255, 16, 80, 98),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Nusrat Jahan',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.white
                              ),
                            ),
                            Text(
                              '9/23',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white.withOpacity(0.8),
                            ),
                            Transform.translate(
                              offset: Offset(-10, 0),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white.withOpacity(0.8),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class BackCard extends StatelessWidget {
  const BackCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 14, 19, 29),
      ),
      child: Stack(
        children: [
          Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Image.asset(
                  "assets/card-design.png",
              fit: BoxFit.cover,
                width: 160,
              ),
          ),
          Padding(
            padding:  EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white.withOpacity(0.8),
                        ),
                        Transform.translate(
                          offset: Offset(-10, 0),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white.withOpacity(0.8),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '**** **** **** 1999',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '9/23',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Nusrat Jahan',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
