class Expense {
  Expense({
    required this.id,
    required this.expenseTitle,
    required this.amount,
    required this.date,
  });

  int id;
  String expenseTitle;
  int amount;
  DateTime date;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      Expense(
        id: json["id"],
        expenseTitle: json["expenseTitle"],
        amount: json["amount"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "expenseTitle": expenseTitle,
        "amount": amount,
        "date": date.toIso8601String(),
      };
}
