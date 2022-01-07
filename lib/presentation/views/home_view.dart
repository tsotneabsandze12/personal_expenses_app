import 'package:flutter/material.dart';
import 'package:personal_expenses_app/domain/providers/state_provider.dart';
import 'package:personal_expenses_app/infrastructure/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static String routeName = '/home';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  _getExpenses() async {
    var provider = Provider.of<StateProvider>(context, listen: false);

    var expenses = await ApiService.getExpenses();
    if (expenses.isNotEmpty) {
      provider.setExpensesList(expenses, notify: false);
    }

    provider.setIsProcessing(false);
  }

  @override
  void initState() {
    super.initState();
    _getExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<StateProvider>(
          builder: (_, provider, __) => provider.isProcessing
              ? const Center(
                  heightFactor: 25,
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 100.0),
                          alignment: Alignment.topCenter,
                          height: 300.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/background.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 90.0,
                          right: 0.0,
                          left: 0.0,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 40.0),
                            child: ListTile(
                              leading: const Text(
                                "Personal Expenses",
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              trailing: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xff267b7b),
                                  borderRadius: BorderRadius.circular(90),
                                ),
                                child: IconButton(
                                  iconSize: 25,
                                  splashColor: Colors.green,
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 150.0,
                          right: 0.0,
                          left: 0.0,
                          child: Container(
                            height: 260,
                            width: 400.0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 40.0),
                            child: Card(
                              elevation: 6.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 10, bottom: 20),
                                child: Center(
                                  child: ListTile(
                                    title: Text(
                                      "0.00 \$",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40, bottom: 40),
                      child: ListView.builder(
                        itemCount: provider.listLength,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (_, int index) {
                          var expense = provider.getExpenseByIndex(index);
                          return Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(
                                expense.expenseTitle,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.grey),
                              ),
                              subtitle: Text(
                                DateFormat.yMMMd()
                                    .format(expense.date)
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              trailing: Text(
                                '${expense.amount} \$',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
