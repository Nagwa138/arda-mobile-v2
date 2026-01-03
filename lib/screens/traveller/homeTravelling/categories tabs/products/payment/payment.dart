import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
PageController pageControllerPayment = PageController();
bool error = false ;

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("payment.confirm".tr(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ))),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "payment.p1".tr(),
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Color.fromRGBO(9, 30, 66, 1),
                  fontWeight: FontWeight.w600,
                )
            ),
            SizedBox(height: 10.h,),
            Text(
                "payment.p2".tr(),
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(9, 30, 66, 1),

                  fontWeight: FontWeight.w400,
                )
            ),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/traveller/fawery.png"),
                Image.asset("assets/images/traveller/visa.png"),
                Image.asset("assets/images/traveller/money.png"),
                Image.asset("assets/images/traveller/vodafone.png"),
                Image.asset("assets/images/traveller/insta.png"),

              ],
            ),
            SizedBox(height: 20.h,),
            SizedBox(
              height: 550.h,
              child: PageView(
                controller: pageControllerPayment,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  /// 1
                  Column(
                    children: [
                      Container(
                        width: 327.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(5, 10, 42, 1)),
                          borderRadius: BorderRadiusDirectional.circular(10.r),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              SizedBox(width: 10.w,),
                              Text(
                                  "payment.add".tr(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 350.w,
                        height: 55.h,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: orange))),
                              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                              backgroundColor: WidgetStateProperty.all<Color>(orange),
                            ),
                            onPressed: () {
                              pageControllerPayment.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                            },
                            child: Text(
                              "payment.checkOut".tr(),
                              style: TextStyle(fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
                            )),
                      ),
                      SizedBox(height: 10.h,),
                    ],
                  ),
                  /// 2
                  Column(
                    children: [
                     Row(
                       children: [
                         Image.asset("assets/images/traveller/visa.png"),
                         SizedBox(width: 10.w,),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                                 "Moataz Abdelhafeez Elrawy",
                                 style: TextStyle(
                                   fontSize: 14.sp,
                                   fontWeight: FontWeight.w600,
                                 )
                             ),


                             Text(
                                 "457************* ",
                                 style: TextStyle(
                                   fontSize: 14.sp,
                                   fontWeight: FontWeight.w400,
                                 )
                             )
                           ],
                         ),
                         SizedBox(width: 50.w,),

                         Text(
                             "payment.edit".tr(),
                             style: TextStyle(
                               fontSize: 12,
                               decoration: TextDecoration.underline,
                               fontWeight: FontWeight.w600,
                             )
                         )

                       ],
                     ),
                      Spacer(),
                      SizedBox(
                        width: 350.w,
                        height: 55.h,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: orange))),
                              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                              backgroundColor: WidgetStateProperty.all<Color>(orange),
                            ),
                            onPressed: () {
                              pageControllerPayment.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                            },
                            child: Text(
                              "payment.buy".tr(),
                              style: TextStyle(fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
                            )),
                      ),
                      SizedBox(height: 10.h,),
                    ],
                  ),

                  /// 3
                 error ?  Column(
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/traveller/visa.png"),
                          SizedBox(width: 10.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Moataz Abdelhafeez Elrawy",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  )
                              ),


                              Text(
                                  "457************* ",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  )
                              )
                            ],
                          ),
                          SizedBox(width: 50.w,),

                          Text(
                              "payment.edit".tr(),
                              style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                              )
                          )

                        ],
                      ),
                      Spacer(),
                     Container(
                       width: 327.w,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadiusDirectional.circular(15.r),
                         border: Border.all(color: Color.fromRGBO(178, 187, 198, 1))
                       ),
                       child: Padding(
                         padding:  EdgeInsets.only(right: 20.w,left: 20.w,top: 20.h),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Image.asset("assets/images/traveller/warining.png"),
                             SizedBox(width: 10.w,),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                     "payment.error".tr(),
                                     style: TextStyle(
                                       fontSize: 16.sp,
                                       fontWeight: FontWeight.w700,
                                     )
                                 ),
                                 SizedBox(
                                   width: 250.w,
                                   child: Text(
                                     "payment.e1".tr(),
                                       style: TextStyle(
                                         fontSize: 14.sp,
                                         fontWeight: FontWeight.w400,
                                       )
                                   ),
                                 ),

                               ],
                             ),
                           ],
                         ),
                       ),
                     ),
                      SizedBox(height: 10.h,),
                    ],
                  ) :Column(
                    children: [
                      Spacer(),
                      SizedBox(
                       width: 350.w,
                       height: 55.h,
                       child: ElevatedButton(
                           style: ButtonStyle(
                             shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: orange))),
                             foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                             backgroundColor: WidgetStateProperty.all<Color>(orange),
                           ),
                           onPressed: () {
                             Navigator.pushNamed(context, "paymentSusscful");

                           },
                           child: Text(
                             "payment.buy".tr() +" " + "payment.sus".tr(),
                             style: TextStyle(fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
                           )),
                                       ),
                    ],
                  ),



                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
