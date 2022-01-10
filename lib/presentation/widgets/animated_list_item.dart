import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/domain/models/expense.dart';
import 'bottom_sheets/expense_details_bottom_sheet.dart';

class AnimatedListItem extends StatefulWidget {
  final int index;
  final Expense expense;

  const AnimatedListItem({Key? key, required this.index, required this.expense})
      : super(key: key);

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _controller.forward();
    super.initState();
  }

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 20),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ),
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            widget.expense.expenseTitle,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xff484848)),
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(widget.expense.date).toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff484848),
            ),
          ),
          trailing: Text(
            '${widget.expense.amount} \$',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff484848),
            ),
          ),
          onTap: () => {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: ExpenseBottomSheetDetails(
                  expense: widget.expense,
                ),
              ),
            )
          },
        ),
      ),
    );
  }
}
