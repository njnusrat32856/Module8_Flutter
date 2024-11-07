import 'package:fintech_mobile_app/widgets/top_up_bottom_sheet.dart';
import 'package:flutter/material.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  String selectedProvider = 'Bank of America';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton.outlined(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Top Up'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bank Transfer',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            PaymentProvider(
              image: "assets/bank_of_america.jpg",
              name: "Bank of America",
              account: "**** **** **** 1999",
              isSelected: selectedProvider == 'Bank of America',
              onChanged: (value) {
                if (value == true) {
                  setState(() {
                    selectedProvider = 'Bank of America';
                  });
                }
              },
            ),
            PaymentProvider(
              image: "assets/us_bank.png",
              name: "U.S. Bank",
              account: "**** **** **** 1999",
              isSelected: selectedProvider == 'U.S. Bank',
              onChanged: (value) {
                if (value == true) {
                  setState(() {
                    selectedProvider = 'U.S. Bank';
                  });
                }
              },
            ),
            Text(
              'Others',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            PaymentProvider(
              image: "assets/paypal.jpg",
              name: "Paypal",
              account: "Easy Payment",
              isSelected: selectedProvider == 'Paypal',
              onChanged: (value) {
                if (value == true) {
                  setState(() {
                    selectedProvider = 'Paypal';
                  });
                }
              },
            ),
            PaymentProvider(
              image: "assets/apple.png",
              name: "Apply Pay",
              account: "Easy Payment",
              isSelected: selectedProvider == 'Apply Pay',
              onChanged: (value) {
                if (value == true) {
                  setState(() {
                    selectedProvider = 'Apply Pay';
                  });
                }
              },
            ),
            PaymentProvider(
              image: "assets/google.png",
              name: "Google Pay",
              account: "Easy Payment",
              isSelected: selectedProvider == 'Google Pay',
              onChanged: (value) {
                if (value == true) {
                  setState(() {
                    selectedProvider = 'Google Pay';
                  });
                }
              },
            ),
            ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      builder: (context) =>
                          TopUpBottomSheet(selectedProvider: selectedProvider));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    fixedSize: Size(double.maxFinite, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14))),
                child: Text(
                  'Confirm',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  String getAccountForProvider(String provider) {
    switch (provider) {
      case 'Bank of America':
        return '**** **** **** 1990';
      case 'U.S. Bank':
        return '**** **** **** 1990';
      default:
        return 'Easy Payment';
    }
  }
}

class PaymentProvider extends StatelessWidget {
  const PaymentProvider(
      {super.key,
      required this.image,
      required this.name,
      required this.account,
      required this.isSelected,
      required this.onChanged});

  final String image;
  final String name;
  final String account;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage(image),
            backgroundColor: Colors.white,
          ),
          title: Text(name),
          subtitle: Text(account),
          trailing: Transform.scale(
            scale: 1.5,
            child: Radio.adaptive(
              value: true,
              groupValue: isSelected,
              onChanged: onChanged,
              activeColor: Colors.teal,
            ),
          ),
          contentPadding: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: Colors.black12,
              )),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
