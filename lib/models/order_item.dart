import 'tour_model.dart';

class OrderItem {
  final int id;
   int quantity;
  final Tour tour;

  OrderItem(this.id, this.quantity, this.tour);
}


OrderItem item = OrderItem(1, 1, tours[1]);