import 'package:fintech_mobile_app/widgets/time_option_button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton.outlined(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new
            )
        ),
        title: Text(
          'Activity',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton.outlined(
              onPressed: () {},
              icon: Icon(
                  Icons.more_horiz
              )
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      3,
                          (index)=> Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 340,
                              height: 75,
                              decoration: BoxDecoration(
                                color: (index%2 ==0) ? Color.fromARGB(255, 16, 80, 98) : Colors.black,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Smartpay Cards',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '**** 1999',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child: Row(
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
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                  )
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(12),
                width: double.maxFinite,
                height: 350,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Column(
                  children: [
                    Text(
                      'Total Spending',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey
                      ),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      '\$9432.00',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    SizedBox(height: 12,),
                    TimeOptionsRow(),
                    SizedBox(height: 16,),
                    Expanded(
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(show: false)
                          )
                        ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
