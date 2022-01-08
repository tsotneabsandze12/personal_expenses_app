import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:personal_expenses_app/domain/models/expense.dart';
import 'package:personal_expenses_app/domain/providers/state_provider.dart';
import 'package:personal_expenses_app/infrastructure/services/api_service.dart';
import 'package:personal_expenses_app/presentation/widgets/icon_btn.dart';
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
    await provider.setExpensesList(notify: false);
    provider.setTotalExpenses(notify: false);

    provider.setIsProcessing(false);
  }

  @override
  void initState() {
    super.initState();
    _getExpenses();
  }

  @override
  Widget build(BuildContext context) {

    AlertDialog deleteDialog(int id) {
      return AlertDialog(
        title: const Text('Accept?'),
        content: const Text('Do you really want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () async {
              await ApiService.deleteExpense(id);
              Provider.of<StateProvider>(context, listen: false)
                  .deleteExpense(id, notify: true);
              Navigator.of(context).pushNamed(HomeView.routeName);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(HomeView.routeName);
            },
            child: const Text('No'),
          ),
        ],
      );
    }

    Future<dynamic> showDetailsBottomSheet(Expense expense) {
      return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 360,
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Text(
                            expense.expenseTitle,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff484848),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Expense Amount',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff484848),
                                ),
                              ),
                              Text(
                                '${expense.amount.toString()}\$',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff484848),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff484848),
                                ),
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy').format(expense.date),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff484848),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment:
                          //     CrossAxisAlignment.end,
                          children: [
                            CircularIconBtn(
                              padding: 20,
                              color: const Color(0xff267b7b),
                              elevation: 2,
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 35,
                              ),
                              callback: () => {},
                            ),
                            CircularIconBtn(
                              padding: 20,
                              color: const Color(0xff267b7b),
                              elevation: 2,
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 35,
                              ),
                              callback: () => {
                                showDialog(
                                    context: context,
                                    builder: (_) => deleteDialog(expense.id),
                                    barrierDismissible: false),
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget upperBackGroundSection = Container(
      margin: const EdgeInsets.only(bottom: 100.0),
      alignment: Alignment.topCenter,
      height: 300.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
    );

    Widget headerSection = Positioned(
      top: 90.0,
      right: 0.0,
      left: 0.0,
      child: Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: 27,
          right: 10,
          bottom: 20,
        ),
        child: ListTile(
          leading: const Text(
            "Personal Expenses",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color(0xff484848),
            ),
          ),
          trailing: CircularIconBtn(
            padding: 6,
            color: const Color(0xff267b7b),
            elevation: 2,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            callback: () => {},
          ),
        ),
      ),
    );

    Widget topCardSection = Positioned(
      top: 150.0,
      right: 0.0,
      left: 0.0,
      child: Container(
        height: 260,
        width: 400.0,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        child: Card(
          elevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 20),
            child: Center(
              child: ListTile(
                title: Text(
                  "${num.parse(Provider.of<StateProvider>(context, listen: true).totalExpenses.toStringAsFixed(3))
                      } \$",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff484848),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    
    Container bottomListView(StateProvider provider){
      return Container(
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
                      color: Color(0xff484848)),
                ),
                subtitle: Text(
                  DateFormat.yMMMd()
                      .format(expense.date)
                      .toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff484848)),
                ),
                trailing: Text(
                  '${expense.amount} \$',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff484848)),
                ),
                onTap: () => {showDetailsBottomSheet(expense)},
                onLongPress: () => {},
              ),
            );
          },
        ),
      );
    }
    

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
                        upperBackGroundSection,
                        headerSection,
                        topCardSection,
                      ],
                    ),
                    bottomListView(provider)
                  ],
                ),
        ),
      ),
    );
  }
}
