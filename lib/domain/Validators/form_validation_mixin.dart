mixin FormValidationMixin {
  bool isIdValid(String? id) {
    if (id == null || id.isEmpty) {
      return false;
    } else if (int.parse(id) <= 0) {
      return false;
    }
    return true;
  }

  bool isAmountValid(String? amount) {
    if (amount == null || amount.isEmpty) {
      return false;
    } else if (num.parse(amount) < 0) {
      return false;
    }
    return true;
  }

  bool isTitleValid(String? title) {
    if (title == null || title.isEmpty) {
      return false;
    }
    return true;
  }

  bool isDateValid(DateTime? date) {
    if (date == null) {
      return false;
    } else if (date.isAfter(DateTime.now())) {
      return false;
    }
    return true;
  }
}
