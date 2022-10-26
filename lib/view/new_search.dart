// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:taza_khabar/models/product_model.dart';
// import 'package:taza_khabar/provider/product_provider.dart';

// class NewSearch extends StatefulWidget {
//   NewSearch({Key? key}) : super(key: key);

//   @override
//   State<NewSearch> createState() => _NewSearchState();
// }

// class _NewSearchState extends State<NewSearch> {
//   List<ProductModel>? search;

//   ProdcutProvider? prodcutProvider;
//   @override
//   void initState() {
//     super.initState();
//     ProdcutProvider prodcutProvider = Provider.of(context, listen: false);
//     var allProduct = prodcutProvider.fatchProductData();
//     List<ProductModel> search = allProduct;
//   }

//   @override
//   Widget build(BuildContext context) {
//     prodcutProvider = Provider.of(context);
//     var userData = prodcutProvider!.search;
//     // prodcutProvider.fatchProductData();

//     String query = '';
//     searchItem(String query) {
//       List<ProductModel> searchFood = search!.where((element) {
//         return element.productName.toLowerCase().contains(query);
//       }).toList();
//       return searchFood;
//     }

//     List<ProductModel> searchItems = searchItem(query);
//     print(searchItems);

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(),
//         body: Column(
//           children: [
//             Text(
//               userData.skip(1).first.productName,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
