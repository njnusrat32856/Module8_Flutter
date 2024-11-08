import 'package:flutter/material.dart';

class TopUpBottomSheet extends StatefulWidget {

  final String selectedProvider;
  final String account;
  final String image;

  const TopUpBottomSheet({super.key, required this.selectedProvider, required this.account, required this.image});

  @override
  State<TopUpBottomSheet> createState() => _TopUpBottomSheetState();
}

class _TopUpBottomSheetState extends State<TopUpBottomSheet> {

  double amount = 100.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding:  EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage(widget.image),
              backgroundColor: Colors.white,
            ),
            title: Text(widget.selectedProvider),
            subtitle: Text(widget.account),
            trailing: Icon(
                Icons.keyboard_arrow_down,
              size: 25,
              color: Colors.grey,
            ),
            contentPadding: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.black12,
                )),
          ),

          SizedBox(height: 10,),
          Text(
              "Amount",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (amount > 5) amount -=5;
                    });
                  },
                  icon: Icon(Icons.remove),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )
                ),
              ),
              Text(
                '\$ ${amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    amount += 5;
                  });
                },
                icon: Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Slider(
              value: amount,
              min: 50,
              max: 500,
              activeColor: Color.fromARGB(255, 16, 80, 98),
              onChanged: (value) {
                setState(() {
                  amount = value;
                });
              }
          ),
          SizedBox(height: 10,),
          Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [50,75,100,150,200,300,400,500].map((value){
                return InkWell(
                  onTap: () {
                    setState(() {
                      amount = value.toDouble();
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 70,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: amount == value ? Color.fromARGB(255, 16, 80, 98) : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '\$$value',
                      style: TextStyle(
                        color: amount == value ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  fixedSize: Size(double.maxFinite, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14))),
              child: Text(
                'Top Up',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
          )
        ],
      ),
    );
  }
}
