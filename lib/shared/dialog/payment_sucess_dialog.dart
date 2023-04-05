import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/color_constants.dart';
import '../utils/image_utils.dart';
import '../utils/math_utils.dart';
import '../widgets/base_text.dart';

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({
    Key? key,
    required this.continueCallBack,
    required this.coin,
  }) : super(key: key);

  final VoidCallback continueCallBack;

  final double borderRadius = 25.0;
  final int coin;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Dialog(
        insetPadding: EdgeInsets.all(getSize(32.0)),
        elevation: 0,
        backgroundColor: const Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getSize(borderRadius)),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal:getSize(10)),
          decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: BorderRadius.circular(getSize(borderRadius)),
              border: Border.all(
                color: ColorConstants.primary,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 25,
                  color: ColorConstants.primary.withOpacity(0.6),
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
                child: Image.asset(
                  getAssetsPNGImg('payment_success'),
                  width: getSize(180),
                  height: getSize(150),
                  //fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: getSize(10)),
              const BaseText(
                text: 'Payment Success',
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
                fontSize: 24,
              ),
              SizedBox(height: getSize(15.0)),
              BaseText(
                text: 'Tip ID # 125050',
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                fontSize: 14,
                textColor: ColorConstants.primary,
              ),
              SizedBox(height: getSize(15.0)),
              const BaseText(
                text: 'Thank you for choosing our service and trusted to help you with your problems',
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                fontSize: 14,
              ),
              SizedBox(height: getSize(10.0)),
              /* Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset(getAssetsPNGImg('coin')),
                  ),
                  BaseText(
                    text: '+$coin',
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                    fontSize: 32,
                  ),
                ],
              ),*/
              SizedBox(height: getSize(15.0)),
              /* BaseElevatedButton(
                //width: getSize(113.0),
                onPressed: () {
                  continueCallBack();
                },
                borderRadius: BorderRadius.circular(15.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: BaseText(text: 'CONTINUE'),
                ),
                */ /* gradient: LinearGradient(
                  colors: [
                    ColorConstants.red1,
                    ColorConstants.red3,
                  ],
                ),*/ /*
              ),*/
              SizedBox(height: getSize(20.0)),
            ],
          ),
        ),
      ),
    );
  }



}
