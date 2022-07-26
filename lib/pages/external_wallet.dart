import 'package:flutter/material.dart';

class ExternalWallet extends StatefulWidget {
  const ExternalWallet({Key? key}) : super(key: key);

  @override
  State<ExternalWallet> createState() => _ExternalWalletState();
}

class _ExternalWalletState extends State<ExternalWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 120.0),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 150,
                  child: Icon(
                    Icons.wallet_giftcard,
                    color: Colors.black,
                    size: 150.0,
                  ),
                )),
            const SizedBox(height: 30.0),
            const Text(
              'External Wallet',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
