class CartModel {
  String cartId;
  List cartImage;
  String cartName;
  int cartPrice;
  int cartQty;
  String cartDescription;
  CartModel(
      {required this.cartId,
      required this.cartImage,
      required this.cartName,
      required this.cartPrice,
      required this.cartQty,
      required this.cartDescription});
}
