import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:PassPort/components/color/color.dart';

class ListViewPageFatoraa extends StatelessWidget {
  const ListViewPageFatoraa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Payment",
            style: TextStyle(
                fontSize: 18.sp, color: black, fontWeight: FontWeight.w700),
          ),
        ),
        body: MyFatoorah(
          onResult: (response) {
            log(response.paymentId.toString());
            log(response.status.toString());
            log("mahmoud zahran Barkat");
          },
          request: MyfatoorahRequest.test(
              currencyIso: Country.Egypt,
              successUrl:
                  "https://www.google.com/",
              errorUrl:
                  "https://www.google.com/",
              invoiceAmount: 1,
              language: ApiLanguage.English,
              token:
                  "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL"),
        ));
  }
}
