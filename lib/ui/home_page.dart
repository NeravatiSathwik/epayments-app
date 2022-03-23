import 'package:code_with_patel/Dbhelper/mongodb.dart';
import 'package:code_with_patel/display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:code_with_patel/Dbhelper/MongoDbModel.dart';



class Razor extends StatefulWidget {
  const Razor({Key? key,this.mobile}) : super(key: key);

  final mobile;
  @override
  _RazorState createState() => _RazorState();
}

class _RazorState extends State<Razor> {
  late var _razorpay;
  var amountController = TextEditingController();
  var nameController = TextEditingController();
  var phnumController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    String s='success';
    insertdata(nameController.text, s, amountController.text,phnumController.text);
    print("Payment Done");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    String s='Failed';
    insertdata(nameController.text, s, amountController.text,phnumController.text);
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  Future <void> insertdata(String fname,String status,String amount,String mobile) async{
    var id =M.ObjectId();
    final data=MongoDbModel(id:id, firstName:fname,status:status,amount: amount,mobile:mobile);
    var result = await MongoDatabase.insert(data);
    //ScaffoldMessenger.of(context).showSnackBar(snackBar(context:Text("inserted"+id.$oid)));

  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text("PAYMENT DETAILS"),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: amountController,
                decoration:
                const InputDecoration(hintText: "Enter your Amount"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "credit to"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: phnumController,
                decoration: const InputDecoration(hintText: "phone num"),
              ),
            ),
            CupertinoButton(
                color: Colors.grey,
                child: Text("Pay Amount"),
                onPressed: () {
                  ///Make payment
                  var options = {
                    'key': "rzp_test_rD311J2U86Dzqx",
                    // amount will be multiple of 100
                    'amount': (int.parse(amountController.text) * 100)
                        .toString(), //So its pay 500
                    'name': nameController.text,
                    'description': 'Demo',
                    'timeout': 300, // in seconds
                    'prefill': {
                      'contact': widget.mobile,
                      'email': 'codewithpatel@gmail.com'
                    }
                  };
                  _razorpay.open(options);
                })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }
}





