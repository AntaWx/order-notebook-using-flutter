class Order {
  final int id;
  final String name;
  final String order;
  final double price; //price is Optional
  final int amount;
  final DateTime date;

  Order(
      {required this.id,
      required this.name,
      required this.order,
      required this.price,
      required this.amount,
      required this.date});
}
