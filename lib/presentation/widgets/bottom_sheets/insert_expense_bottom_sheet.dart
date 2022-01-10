import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:personal_expenses_app/domain/models/expense.dart';
import 'package:personal_expenses_app/presentation/widgets/btn.dart';
import 'package:personal_expenses_app/presentation/widgets/field.dart';
import 'package:personal_expenses_app/domain/providers/state_provider.dart';
import 'package:personal_expenses_app/domain/Validators/form_validation_mixin.dart';


class AddExpenseBottomSheet extends StatefulWidget {
  const AddExpenseBottomSheet({Key? key}) : super(key: key);

  @override
  _AddExpenseBottomSheetState createState() => _AddExpenseBottomSheetState();
}

class _AddExpenseBottomSheetState extends State<AddExpenseBottomSheet> with FormValidationMixin {
  var key = GlobalKey<FormState>();
  Expense e = Expense(id: 0, expenseTitle: '', amount: 0, date: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      type: TextInputType.number,
                      hintText: 'Please enter expense ID',
                      align: TextAlign.center,
                      borderColor: Colors.grey,
                      validator: (value) {
                        if (isIdValid(value)) {
                          return null;
                        }
                        return 'invalid id';
                      },
                      onSaved: (val) {
                        e.id = int.parse(val);
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Field(
                      type: TextInputType.number,
                      hintText: 'Please enter expense amount',
                      borderColor: Colors.grey,
                      align: TextAlign.center,
                      validator: (value) {
                        if (isAmountValid(value)) {
                          return null;
                        }
                        return 'invalid value';
                      },
                      onSaved: (val) {
                        e.amount = num.parse(val);
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Field(
                      type: TextInputType.text,
                      hintText: 'Please enter expense title',
                      borderColor: Colors.grey,
                      align: TextAlign.center,
                      validator: (String? value) {
                        if (isTitleValid(value)) {
                          return null;
                        }
                        return 'invalid value';
                      },
                      onSaved: (val) {
                        e.expenseTitle = val;
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<StateProvider>(
                          builder: (_, provider, __) => Text(
                            Provider.of<StateProvider>(context, listen: false)
                                    .selectedDateInsertBottomSheet
                                    .isEmpty
                                ? 'Pick Date'
                                : Provider.of<StateProvider>(context,
                                        listen: false)
                                    .selectedDateInsertBottomSheet,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
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
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(3000),
                            ).then(
                              (value) => {
                                e.date = value!,
                                Provider.of<StateProvider>(context,
                                        listen: false)
                                    .setInsertSelectedDate(
                                        DateFormat('dd/MM/yyyy').format(value),
                                        notify: true),
                              },
                            ),
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Btn(
                      text: 'ADD',
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
                                .addExpense(e),
                            Provider.of<StateProvider>(context, listen: false)
                                .setInsertSelectedDate('', notify: true),
                            Navigator.of(context).pop(),
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
    );
  }
}
