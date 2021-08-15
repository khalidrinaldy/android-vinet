import 'dart:io';
import 'package:flutter_vinet/models/income_model.dart';
import 'package:flutter_vinet/models/payment_model.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';

Future<void> printPdf(Payment payment) async {
  final pdf = pw.Document();
  final fontNunitoSans = await rootBundle.load("assets/fonts/Nunito Sans/NunitoSans-Regular.ttf");
  final ttfNunitoSans = pw.Font.ttf(fontNunitoSans);

  final imageVinet = pw.MemoryImage(
    (await rootBundle.load('assets/images/payment/vinet.png')).buffer.asUint8List(),
  );
  final imageRtiga = pw.MemoryImage(
    (await rootBundle.load('assets/images/payment/rtiga.png')).buffer.asUint8List(),
  );
  final imagePaid = pw.MemoryImage(
    (await rootBundle.load('assets/images/payment/paid.png')).buffer.asUint8List(),
  );
  final iconShoppingBag = pw.MemoryImage(
    (await rootBundle.load('assets/images/payment/icon_shopping_bag.png')).buffer.asUint8List(),
  );
  final iconNetWorkCheck = pw.MemoryImage(
    (await rootBundle.load('assets/images/payment/icon_network_check.png')).buffer.asUint8List(),
  );
  final iconPaid = pw.MemoryImage(
    (await rootBundle.load('assets/images/payment/icon_paid.png')).buffer.asUint8List(),
  );
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) => pw.Center(
        child: pw.Container(
          padding: pw.EdgeInsets.only(bottom: 7),
          width: 310,
          height: 300,
          decoration: pw.BoxDecoration(
            color: PdfColors.white,
            borderRadius: pw.BorderRadius.only(
              bottomLeft: pw.Radius.circular(10),
              bottomRight: pw.Radius.circular(10),
            ),
            boxShadow: <pw.BoxShadow>[
              pw.BoxShadow(
                offset: PdfPoint(0, 2),
                blurRadius: 4,
                spreadRadius: 0,
                color: PdfColor.fromInt(0x40000000),
              ),
            ],
          ),
          child: pw.Column(
            children: [
              //COMPANY LOGO
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(imageVinet),
                  pw.Image(imageRtiga),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  //USER INFORMATION
                  pw.Container(
                    padding: pw.EdgeInsets.only(left: 20),
                    width: 200,
                    child: pw.Column(
                      children: [
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 43,
                              child: pw.Text(
                                "From",
                                style: pw.TextStyle(
                                  font: ttfNunitoSans,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                            pw.Flexible(
                              child: pw.Text(
                                payment.name.toString(),
                                overflow: pw.TextOverflow.span,
                                style: pw.TextStyle(
                                  font: ttfNunitoSans,
                                  fontSize: 9,
                                ),
                              ),
                            )
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 43,
                              child: pw.Text(
                                "Address",
                                style: pw.TextStyle(
                                  font: ttfNunitoSans,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                            pw.Flexible(
                              child: pw.Text(
                                payment.address.toString(),
                                overflow: pw.TextOverflow.span,
                                style: pw.TextStyle(
                                  font: ttfNunitoSans,
                                  fontSize: 9,
                                ),
                              ),
                            )
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 43,
                              child: pw.Text(
                                "Phone",
                                style: pw.TextStyle(
                                  font: ttfNunitoSans,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                            pw.Flexible(
                              child: pw.Text(
                                payment.phone.toString(),
                                overflow: pw.TextOverflow.span,
                                style: pw.TextStyle(
                                  font: ttfNunitoSans,
                                  fontSize: 9,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  //PAID IMAGE
                  pw.Image(imagePaid),
                ],
              ),

              //pw.Row 3-INFORMATIONS ABOUT PACKETS SPECIFICATION
              pw.Container(
                width: 200,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    //PACKET TYPE
                    pw.Container(
                      width: 52,
                      height: 52,
                      decoration: pw.BoxDecoration(
                        color: PdfColor.fromInt(0xBD4CB82F),
                        borderRadius: pw.BorderRadius.circular(15),
                        boxShadow: <pw.BoxShadow>[
                          pw.BoxShadow(
                            offset: PdfPoint(0, 2),
                            blurRadius: 4,
                            spreadRadius: 0,
                            color: PdfColor.fromInt(0x404CAF50),
                          ),
                        ],
                      ),
                      child: pw.Column(
                        children: [
                          pw.SizedBox(
                            height: 7,
                          ),
                          pw.Image(iconShoppingBag),
                          pw.SizedBox(
                            height: 3,
                          ),
                          pw.Text(
                            payment.packetType.toString(),
                            style: pw.TextStyle(
                              font: ttfNunitoSans,
                              fontSize: 7,
                              color: PdfColor.fromInt(0xFF004D72),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //PACKET SPEED
                    pw.Container(
                      width: 52,
                      height: 52,
                      decoration: pw.BoxDecoration(
                        color: PdfColor.fromInt(0xBD4CB82F),
                        borderRadius: pw.BorderRadius.circular(15),
                        boxShadow: <pw.BoxShadow>[
                          pw.BoxShadow(
                            offset: PdfPoint(0, 2),
                            blurRadius: 4,
                            spreadRadius: 0,
                            color: PdfColor.fromInt(0x404CAF50),
                          ),
                        ],
                      ),
                      child: pw.Column(
                        children: [
                          pw.SizedBox(
                            height: 7,
                          ),
                          pw.Image(iconNetWorkCheck),
                          pw.SizedBox(
                            height: 3,
                          ),
                          pw.Text(
                            "${payment.packetSpeed} Mbps",
                            style: pw.TextStyle(
                              font: ttfNunitoSans,
                              fontSize: 7,
                              color: PdfColor.fromInt(0xFF004D72),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //PACKET PRICE
                    pw.Container(
                      width: 52,
                      height: 52,
                      decoration: pw.BoxDecoration(
                        color: PdfColor.fromInt(0xBD4CB82F),
                        borderRadius: pw.BorderRadius.circular(15),
                        boxShadow: <pw.BoxShadow>[
                          pw.BoxShadow(
                            offset: PdfPoint(0, 2),
                            blurRadius: 4,
                            spreadRadius: 0,
                            color: PdfColor.fromInt(0x404CAF50),
                          ),
                        ],
                      ),
                      child: pw.Column(
                        children: [
                          pw.SizedBox(
                            height: 7,
                          ),
                          pw.Image(iconPaid),
                          pw.SizedBox(
                            height: 3,
                          ),
                          pw.Text(
                            "Rp.${moneyFormat.format(payment.packetPrice)}",
                            style: pw.TextStyle(
                              font: ttfNunitoSans,
                              fontSize: 7,
                              color: PdfColor.fromInt(0xFF004D72),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.Expanded(
                child: pw.Align(
                  alignment: pw.Alignment.bottomCenter,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      //RECEIVED BY
                      pw.Container(
                        child: pw.Row(
                          children: [
                            pw.Text(
                              "         ",
                              style: pw.TextStyle(
                                font: ttfNunitoSans,
                                fontSize: 8,
                                color: PdfColor.fromInt(0x80000000),
                              ),
                            ),
                            pw.SizedBox(
                              width: 2,
                            ),
                            pw.Container(
                              height: 4,
                              width: 4,
                              decoration: pw.BoxDecoration(
                                shape: pw.BoxShape.circle,
                                color: PdfColor.fromInt(0x80000000),
                              ),
                            ),
                            pw.SizedBox(
                              width: 2,
                            ),
                            pw.Text(
                              "Received by Rafika Amalia",
                              style: pw.TextStyle(
                                font: ttfNunitoSans,
                                fontSize: 8,
                                color: PdfColor.fromInt(0x80000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
  Printing.sharePdf(bytes: await pdf.save(), filename: 'test_pdf.pdf');
}
