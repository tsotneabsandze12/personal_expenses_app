import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/domain/Validators/form_validation_mixin.dart';
import 'package:personal_expenses_app/domain/models/expense.dart';
import 'package:personal_expenses_app/presentation/widgets/icon_btn.dart';
import '../delete_dialog.dart';
import 'edit_expense_bottom_sheet.dart';

class ExpenseBottomSheetDetails with FormValidationMixin {
  static showDetailsBottomSheet(
      {required Expense expense,
      required BuildContext context,
      required GlobalKey<FormState> key}) {
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
                              EditExpenseBottomSheet.showEditExpenseBottomSheet(
                                  expense: expense, key: key, context: context)
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
                                      deleteDialog(expense.id, context),
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
}
