import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/domain/Validators/form_validation_mixin.dart';
import 'package:personal_expenses_app/domain/models/expense.dart';
import 'package:personal_expenses_app/domain/providers/state_provider.dart';
import 'package:personal_expenses_app/presentation/widgets/btn.dart';
import 'package:personal_expenses_app/presentation/widgets/field.dart';
import 'package:provider/provider.dart';
import '../home_view.dart';

class EditExpenseBottomSheet with FormValidationMixin {
  static showEditExpenseBottomSheet(
      {required Expense expense,
      required BuildContext context,
      required GlobalKey<FormState> key}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: const EdgeInsets.all(15),
            height: 360,
            color: Theme.of(context).primaryColor,
            child: Form(
              key: key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Field(
                        isEnabled: false,
                        type: TextInputType.number,
                        align: TextAlign.start,
                        borderColor: Colors.white,
                        initialValue: expense.id.toString(),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Field(
                        type: TextInputType.number,
                        borderColor: Colors.white,
                        align: TextAlign.start,
                        initialValue: expense.amount.toString(),
                        validator: (value) {
                          if (FormValidationMixin.isAmountValid(value)) {
                            return null;
                          }
                          return 'invalid value';
                        },
                        onSaved: (val) {
                          expense.amount = num.parse(val);
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Field(
                        type: TextInputType.text,
                        borderColor: Colors.white,
                        align: TextAlign.start,
                        initialValue: expense.expenseTitle.toString(),
                        validator: (String? value) {
                          if (FormValidationMixin.isTitleValid(value)) {
                            return null;
                          }
                          return 'invalid value';
                        },
                        onSaved: (val) {
                          expense.expenseTitle = val;
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy').format(expense.date),
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Btn(
                            text: 'Pick Date',
                            width: 140,
                            height: 40,
                            color: const Color(0xff267b7b),
                            fontSize: 18,
                            fontColor: Colors.white,
                            radius: 10,
                            callback: () => {
                              showDatePicker(
                                context: context,
                                initialDate: expense.date,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(3000),
                              ).then((value) => {
                                    if (FormValidationMixin.isDateValid(value))
                                      {expense.date = value!}
                                  }),
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: Btn(
                        text: 'EDIT',
                        width: 140,
                        height: 40,
                        color: const Color(0xff267b7b),
                        fontSize: 18,
                        fontColor: Colors.white,
                        radius: 10,
                        callback: () async => {
                          if (key.currentState!.validate())
                            {
                              key.currentState!.save(),
                              await Provider.of<StateProvider>(context,
                                      listen: false)
                                  .updateExpense(expense),
                              Navigator.of(context)
                                  .pushNamed(HomeView.routeName)
                            }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
