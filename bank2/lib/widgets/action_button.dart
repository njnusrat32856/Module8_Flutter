
// import 'package:fintech_mobile_app/pages/transfer_money.dart';
import 'package:bank2/screens/bank_statement_screen.dart';
import 'package:bank2/screens/deposit_screen.dart';
import 'package:bank2/screens/transaction_list_screen.dart';
import 'package:bank2/screens/transfer_screen.dart';
import 'package:bank2/screens/user_profile_screen.dart';
import 'package:bank2/screens/withdraw_screen.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 239, 243, 245),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionButton(
              icon: Icons.account_balance,
              label: 'Deposit',
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DepositScreen())
                    );
              },
            ),
            ActionButton(
              icon: Icons.swap_horiz,
              label: 'Transfer',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TransferScreen())
                );
              },
            ),
            ActionButton(
              icon: Icons.attach_money,
              label: 'Withdraw',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WithdrawScreen()),
                );
              },
            ),
            ActionButton(
              icon: Icons.apps_sharp,
              label: 'More',
              onPressed: () {
                Navigator.push(
                    context,
                    // MaterialPageRoute(builder: (context) => BankStatementScreen())
                    MaterialPageRoute(builder: (context) => BankStatementScreen(userId: 3))
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
class ActionButton extends StatelessWidget {
  const ActionButton({super.key, required this.icon, required this.label, this.onPressed});

  final IconData icon;
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.outlined(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: Color.fromARGB(255, 16, 80, 98),
            )
        ),
        SizedBox(height: 8.0,),
        Text(
          label,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}

