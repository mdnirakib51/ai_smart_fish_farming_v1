import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;

import '../../global/constants/colors_resources.dart';
import '../../global/widget/global_text.dart';

class PsPaymentButton extends StatefulWidget {
  final String merchantID;
  final String storePass;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final String invoiceNumber;
  final String currency;
  final String paymentAmount;
  final String reference;
  final String custName;
  final String custPhone;
  final String custEmail;
  final String custAddress;
  final String callbackUrl; // Your server endpoint
  final String webViewAppBarName;
  final double buttonHeight;
  final double buttonwidth;
  final Future<void> Function(String transactionId) successFunction;

  const PsPaymentButton({
    super.key,
    required this.merchantID,
    required this.storePass,
    required this.successFunction,
    required this.buttonHeight,
    required this.buttonwidth,
    required this.buttonText,
    required this.webViewAppBarName,
    required this.buttonColor,
    required this.currency,
    required this.callbackUrl,
    required this.textColor,
    required this.custAddress,
    required this.custEmail,
    required this.custName,
    required this.custPhone,
    required this.invoiceNumber,
    required this.paymentAmount,
    required this.reference,
  });

  @override
  State<PsPaymentButton> createState() => _PsPaymentButtonState();
}

class _PsPaymentButtonState extends State<PsPaymentButton> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isProcessing ? null : callToken,
      child: Container(
        height: widget.buttonHeight,
        width: widget.buttonwidth,
        decoration: BoxDecoration(
          color: _isProcessing ? Colors.grey : widget.buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: _isProcessing
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "Processing...",
              style: TextStyle(
                color: widget.textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
            : Text(
          widget.buttonText,
          style: TextStyle(
            color: widget.textColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> callToken() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      final response = await postAPICall(
        "https://api.paystation.com.bd/grant-token",
        {},
        header: {
          'merchantId': widget.merchantID,
          'password': widget.storePass,
        },
      );

      if (response['status_code'] == "200") {
        await callPsPayment(response['token']);
      } else {
        throw Exception('Failed to get token: ${response['message']}');
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment initialization failed: $e')),
      );
    }
  }

  Future<void> callPsPayment(String token) async {
    try {
      final payData = {
        'invoice_number': widget.invoiceNumber,
        'currency': widget.currency,
        'payment_amount': widget.paymentAmount,
        'reference': widget.reference,
        'cust_name': widget.custName,
        'cust_phone': widget.custPhone,
        'cust_email': widget.custEmail,
        'cust_address': widget.custAddress,
        'callback_url': widget.callbackUrl,
      };

      final response = await postAPICall(
        "https://api.paystation.com.bd/create-payment",
        payData,
        header: {"token": token},
      );

      log("Pay Data: $payData");

      if (response["status"] == "success") {
        if (!mounted) return;
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentWeb(
              successFunction: widget.successFunction,
              appBar: widget.webViewAppBarName,
              url: response['payment_url'],
            ),
          ),
        );
      } else {
        throw Exception(response['message'] ?? 'Payment creation failed');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment processing failed: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }


  Future<dynamic> postAPICall(String url, dynamic param,
      {Map<String, String>? header}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        body: param,
        headers: header,
      );
      return _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw Exception('Server error');
      default:
        throw FetchDataException(
            'Error occurred while communicating with Server');
    }
  }
}

class PaymentWeb extends StatefulWidget {
  final String url;
  final String appBar;
  final Future<void> Function(String transactionId) successFunction;

  const PaymentWeb({
    required this.url,
    required this.appBar,
    required this.successFunction,
    super.key,
  });

  @override
  _PaymentWebState createState() => _PaymentWebState();
}

class _PaymentWebState extends State<PaymentWeb> {
  double _progress = 0;
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorRes.appColor,
          title: GlobalText(
            str: widget.appBar,
            color: ColorRes.white,
            fontSize: 14,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: ColorRes.white),
            onPressed: () => Navigator.maybePop(context),
          ),
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.url)),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
              onLoadStart: (controller, url) async {
                if (url != null && url.toString().contains('status=Successful')) {
                  final uri = Uri.parse(url.toString());
                  final transactionId = uri.queryParameters['transaction_id'] ??
                      uri.queryParameters['trx_id'] ??
                      uri.queryParameters['payment_id'] ??
                      'unknown_id';

                  await widget.successFunction(transactionId);
                  log("Tx Id: $transactionId");
                  Navigator.pop(context);
                } else if (url != null && url.toString().contains('status=Failed')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment failed')),
                  );
                  Navigator.pop(context);
                }
              },
            ),
            _progress < 1
                ? LinearProgressIndicator(value: _progress)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

// Exception classes
class CustomException implements Exception {
  final String? message;
  final String? prefix;

  CustomException([this.message, this.prefix]);

  @override
  String toString() => "$prefix$message";
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}