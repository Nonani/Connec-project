// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:logger/logger.dart';


// Auto-consume must be true on iOS.
// To try without auto-consume on another platform, change `true` to `false` here.
final bool _kAutoConsume = true;

const String _onceConsumable = '1_ticket';
const String _fifthTimesConsumable = '5_ticket';
const String _tenTimesConsumable = '10_ticket';
const String _twentyTimesConsumable = '20_ticket';
const Map<String, int> _productMap = {
  _onceConsumable: 1,
  _fifthTimesConsumable: 5,
  _tenTimesConsumable: 10,
  _twentyTimesConsumable: 20
};
const List<String> _consumableProductIds = <String>[
  _onceConsumable,
  _fifthTimesConsumable,
  _tenTimesConsumable,
  _twentyTimesConsumable
];

class IAPConnec extends StatefulWidget {
  @override
  State<IAPConnec> createState() => _IAPConnecState();
}

class _IAPConnecState extends State<IAPConnec> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  final logger = Logger();

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
    });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _notFoundIds = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_consumableProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _notFoundIds = productDetailResponse.notFoundIDs;
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _notFoundIds = productDetailResponse.notFoundIDs;
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _purchasePending = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> stack = <Widget>[];
    if (_queryProductError == null) {
      stack.add(
        ListView(
          children: <Widget>[
            _buildUserState(),
            _buildProductList(),
            _buildConsumableBox(),
          ],
        ),
      );
    } else {
      stack.add(Center(
        child: Text(_queryProductError!),
      ));
    }
    if (_purchasePending) {
      stack.add(
        Stack(
          children: const <Widget>[
            Opacity(
              opacity: 0.3,
              child: ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 56,
          backgroundColor: const Color(0xfffafafa),
          shape: const Border(
              bottom: BorderSide(color: Color(0xffdbdbdb), width: 2)),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff5f66f2),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            '쿠폰 구매',
            style: featureTitle,
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: stack,
        ),
      ),
    );
  }

  Row _buildUserState() {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          margin: const EdgeInsets.only(
            top: 20,
            left: 18,
            right: 18,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffafafaf),
          ),
        ),
        SizedBox(
          width: 250,
          child: FutureBuilder(
              future: getUser(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${snapshot.data['userName']}님',
                        style: const TextStyle(
                          color: Color(0xff333333),
                          fontSize: 17,
                          fontFamily: 'S-CoreDream-6Bold',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "현재 보유한 쿠폰",
                              style: TextStyle(
                                color: Color(0xffbdbdbd),
                                fontSize: 16,
                                fontFamily: 'S-CoreDream-4Regular',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "${snapshot.data['couponNum'].toString()}개",
                              style: const TextStyle(
                                color: Color(0xffbdbdbd),
                                fontSize: 16,
                                fontFamily: 'S-CoreDream-4Regular',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ])
                    ],
                  );
                } else {
                  return const Card();
                }
              }),
        ),
      ],
    );
  }

  Card _buildProductList() {
    if (_loading) {
      return const Card(
          child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching products...')));
    }
    if (!_isAvailable) {
      return const Card();
    }

    final List<GestureDetector> productList = <GestureDetector>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(GestureDetector(
          child: ListTile(
              title: Text('[${_notFoundIds.join(", ")}] not found',
                  style: TextStyle(color: ThemeData.light().colorScheme.error)),
              subtitle: const Text('현재 쿠폰 구매를 사용할 수 없습니다.'))));
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.
    productList.addAll(_products.map(
      (ProductDetails productDetails) {
        return GestureDetector(
          child: ListTile(
            leading: const Icon(
              Icons.confirmation_number,
              size: 36,
              color: Color(0xff5f66f2),
            ),
            title: Text(
              productDetails.title.substring(0, 10),
              style: const TextStyle(
                color: Color(0xff333333),
                fontSize: 17,
                fontFamily: 'S-CoreDream-5',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Text(
              productDetails.price,
              style: const TextStyle(
                color: Color(0xff333333),
                fontSize: 17,
                fontFamily: 'EchoDream',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          onTap: () {
            late PurchaseParam purchaseParam;

            if (Platform.isAndroid) {
              // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
              // verify the latest status of you your subscription by using server side receipt validation
              // and update the UI accordingly. The subscription purchase status shown
              // inside the app may not be accurate.

              purchaseParam = GooglePlayPurchaseParam(
                productDetails: productDetails,
              );
            } else {
              purchaseParam = PurchaseParam(
                productDetails: productDetails,
              );
            }
            _inAppPurchase.buyConsumable(
                purchaseParam: purchaseParam, autoConsume: _kAutoConsume);
          },
        );
      },
    ));

    return Card(
        child: Column(children: <Widget>[const Divider()] + productList));
  }

  Card _buildConsumableBox() {
    return const Card();
  }

  Future getUser() async {
    Map<String, dynamic> ret = {};
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    ret['userName'] = data.data()!['name'];
    data =
        await FirebaseFirestore.instance.collection('coupons').doc(uid).get();
    ret['couponNum'] = data.data()!['num'];
    return ret;
  }

  Future<bool> consume(String id) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> data = await db
        .collection('coupons')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (data.data()!['num']) {
      await db
          .collection('coupons')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'num': data.data()!['num'] - 1});
      return true;
    } else {
      return false;
    }
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if (_consumableProductIds.contains(purchaseDetails.productID)) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot<Map<String, dynamic>> data = await db
          .collection('coupons')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      await db
          .collection('coupons')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'num': data.data()!['num'] + _productMap[purchaseDetails.productID]
      });
      setState(() {
        _purchasePending = false;
      });
    }
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (!_kAutoConsume &&
              _consumableProductIds.contains(purchaseDetails.productID)) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
                _inAppPurchase.getPlatformAddition<
                    InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }
}

/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
///
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
