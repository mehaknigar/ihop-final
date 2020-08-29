double roundAndInc(double number) {
  double newNumber = number.roundToDouble();

  if (number > newNumber) newNumber++;

  return newNumber;
}
