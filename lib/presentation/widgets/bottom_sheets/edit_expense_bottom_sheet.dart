import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_app/domain/models/expense.dart';
import 'package:personal_expenses_app/presentation/widgets/btn.dart';
import 'package:personal_expenses_app/presentation/widgets/field.dart';
import 'package:personal_expenses_app/domain/providers/state_provider.dart';
import 'package:personal_expenses_app/domain/Validators/form_validation_mixin.dart';


class EditExpenseBottomSheet extends StatefulWidget {
  final Expense expense;

  const EditExpenseBottomSheet({Key? key, required this.expense})
      : super(key: key);

  @override
  _EditExpenseBottomSheetState createState() =>
      _EditExpenseBottomSheetState();
}

class _EditExpenseBottomSheetState extends State<EditExpenseBottomSheet> with FormValidationMixin {
  var key = GlobalKey<FormState>();

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
                      isEnabled: false,
                      type: TextInputType.number,
                      align: TextAlign.start,
                      borderColor: Colors.white,
                      initialValue: widget.expense.id.toString(),
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
                      initialValue: widget.expense.amount.toString(),
                      validator: (value) {
                        if (isAmountValid(value)) {
                          return null;
                        }
                        return 'invalid value';
                      },
                      onSaved: (val) {
                        widget.expense.amount = num.parse(val);
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
                      initialValue: widget.expense.expenseTitle.toString(),
                      validator: (String? value) {
                        if (isTitleValid(value)) {
                          return null;
                        }
                        return 'invalid value';
                      },
                      onSaved: (val) {
                        widget.expense.expenseTitle = val;
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
                        Consumer<StateProvider>(
                          builder: (_, provider, __) => Text(
                            Provider.of<StateProvider>(context, listen: false)
                                .selectedDateEditBottomSheet,
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
                              initialDate: widget.expense.date,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(3000),
                            ).then((value) => {
                                  if (isDateValid(value))
                                    {
                                      widget.expense.date = value!,
                                      Provider.of<StateProvider>(context,
                                              listen: false)
                                          .setEditSelectedDate(
                                              DateFormat('dd/MM/yyyy')
                                                  .format(value),
                                              notify: true),
                                    }
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
                                .updateExpense(widget.expense),

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
