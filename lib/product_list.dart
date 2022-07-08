import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/model/db_helper.dart';
import 'package:provider/provider.dart';
import 'model/cart_model.dart';
import 'model/cart_provider.dart';
import 'package:shopping_cart/cart_screen.dart';


class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DBHelper? dbHelper = DBHelper();
  List<String> productName= ['Mango', 'Peach', 'Orange', 'Grapes', 'Banana', 'Apple', 'Cherry'];
  List<String> productUnit= ['KG', 'Dozen', 'KG', 'Dozen', 'KG', 'KG', 'KG'];
  List<int> productPrice= [20, 10,30, 25, 40, 15, 70];
  List<String> productImage= [
    'https://media.istockphoto.com/vectors/fresh-mango-isolated-illustration-of-exotic-fruit-vector-id1371913878?k=20&m=1371913878&s=612x612&w=0&h=GE_iajOAKDLbt4JM1Pi-45Zz1Ma7obuzihmdBg2MS9M=',
    'https://media.istockphoto.com/photos/single-peach-fruit-with-leaf-isolated-on-white-picture-id1137630158?b=1&k=20&m=1137630158&s=170667a&w=0&h=bYeS3vmGTtbYeCFd5NIHQNVoHSRs4PmPswuI2pnp6fE=',
    'https://media.istockphoto.com/photos/orange-slices-isolated-on-white-picture-id672613170?k=20&m=672613170&s=612x612&w=0&h=l57j_xwi2loiyUZ_kfdd3Dy3YQvA4O7qbX33vUo8sug=',
    'https://media.istockphoto.com/photos/ripe-red-grape-pink-bunch-with-leaves-isolated-on-white-with-clipping-picture-id682505832?b=1&k=20&m=682505832&s=170667a&w=0&h=zENcygcWfieO_qXvHo8OGh8pj2p4mgymoIAVIvsgnlw=',
    'https://media.istockphoto.com/photos/banana-picture-id636739634?b=1&k=20&m=636739634&s=170667a&w=0&h=_HASEjG8LXbR4zu_eDH4dtS9WC80C9liLVFnKizTqtM=',
    'https://media.istockphoto.com/photos/red-apples-picture-id1141708425?b=1&k=20&m=1141708425&s=170667a&w=0&h=Ae2VCrC1GV9x4QVlVqbVVoicYrCcV4lYIxbQFoKZRpg=',
    'https://media.istockphoto.com/photos/cherry-trio-with-stem-and-leaf-picture-id157428769?k=20&m=157428769&s=612x612&w=0&h=6h04mpukiriaaMpL7US6O0oDA-RUqCvogZyReUbVRe4='
  ];

  @override
  Widget build(BuildContext context) {
    final cart  = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart List'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context) => CartScreen()));
              },
              child: Badge(
                badgeContent: Consumer<CartProvider>(
                 builder: (context, value , child){
                 return Text(value.getCounter().toString(),style: TextStyle(color: Colors.white));
                 },
                ),
                animationDuration: Duration(milliseconds: 300),
                badgeColor: Colors.black87,
                position: BadgePosition.topStart(top: 0, start: 13),
                child: Icon(Icons.shopping_cart, ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productName.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image(
                                   height: 100,
                                   width: 100,
                                   image: NetworkImage(productImage[index].toString()),
                              ),
                              SizedBox(width: 5,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(productName[index].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),),
                                  Text(productUnit[index].toString() +" "+"\$" + productPrice[index].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),),
                                  SizedBox(height: 5,),
                                   InkWell(
                                     onTap: (){
                                       dbHelper!.insert(
                                           Cart(
                                               id : index ,
                                               productId : index.toString(),
                                               productName :index.toString(),
                                               initialPrice : productPrice[index],
                                               productPrice : productPrice[index],
                                               quantity : 1,
                                               unitTag : productName[index].toString(),
                                               image : productImage[index].toString())
                                              ).then((value){
                                            print('product added to cart');
                                            cart.addTotalPrice(double.parse(productPrice[index].toString()));
                                            cart.addCounter();

                                       }).onError((error, stacktrace){
                                             print(error.toString());
                                       });
                                     },
                                     child: Container(
                                        height: 30,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.redAccent
                                        ),
                                        child: Center(
                                          child: Text('Add to cart', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                        ),
                                      ),
                                   ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
