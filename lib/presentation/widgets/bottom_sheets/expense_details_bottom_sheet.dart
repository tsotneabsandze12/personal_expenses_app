import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/domain/models/expense.dart';
import 'package:personal_expenses_app/domain/providers/state_provider.dart';
import 'package:personal_expenses_app/presentation/widgets/delete_dialog.dart';
import 'package:personal_expenses_app/presentation/widgets/icon_btn.dart';
import 'package:provider/provider.dart';
import 'edit_expense_bottom_sheet.dart';

class ExpenseBottomSheetDetails extends StatefulWidget {
  final Expense expense;

  const ExpenseBottomSheetDetails({Key? key, required this.expense})
      : super(key: key);

  @override
  _ExpenseBottomSheetDetailsState createState() =>
      _ExpenseBottomSheetDetailsState();
}

class _ExpenseBottomSheetDetailsState extends State<ExpenseBottomSheetDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                      widget.expense.expenseTitle,
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
                          '${widget.expense.amount.toString()}\$',
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
                          DateFormat('dd/MM/yyyy').format(widget.expense.date),
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
                        callback: () => {
                          Provider.of<StateProvider>(context, listen: false)
                              .setEditSelectedDate(
                            DateFormat('dd/MM/yyyy')
                                .format(widget.expense.date),
                          ),
                          Navigator.of(context).pop(),
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => EditExpenseBottomSheet(
                              expense: widget.expense,
                            ),
                          ),
                        },
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
                                  builder: (_) =>
                                      deleteDialog(widget.expense.id, context),
                                  barrierDismissible: false)
                              .whenComplete(
                            () => Navigator.of(context).pop(),
                          ),
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
    );
  }
}
