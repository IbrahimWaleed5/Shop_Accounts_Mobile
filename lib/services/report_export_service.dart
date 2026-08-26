import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../core/utils/money_utils.dart';
import '../models/report_model.dart';

class ReportExportService {
  ReportExportService._();

  static Future<void> sharePdf(
    ReportModel report,
  ) async {
    final bytes =
        await _pdf(report);

    await Printing.sharePdf(
      bytes: bytes,
      filename:
          _fileName(
        report,
        'pdf',
      ),
    );
  }

  static Future<void> printPdf(
    ReportModel report,
  ) async {
    final bytes =
        await _pdf(report);

    await Printing.layoutPdf(
      name:
          _fileName(
        report,
        'pdf',
      ),
      onLayout:
          (_) async =>
              bytes,
    );
  }

  static Future<void> shareExcel(
    ReportModel report,
  ) async {
    final bytes =
        _xlsx(report);

    final fileName =
        _fileName(
      report,
      'xlsx',
    );

    await SharePlus.instance.share(
      ShareParams(
        title:
            report.title,
        text:
            '${report.title} - '
            '${_date(report.from)} إلى '
            '${_date(report.to)}',
        files: [
          XFile.fromData(
            bytes,
            mimeType:
                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
          ),
        ],
        fileNameOverrides: [
          fileName,
        ],
      ),
    );
  }

  static Future<Uint8List> _pdf(
    ReportModel report,
  ) async {
    final regular =
        await PdfGoogleFonts
            .notoNaskhArabicRegular();

    final bold =
        await PdfGoogleFonts
            .notoNaskhArabicBold();

    final doc =
        pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat:
            PdfPageFormat.a4,
        margin:
            const pw.EdgeInsets.all(
          28,
        ),
        textDirection:
            pw.TextDirection.rtl,
        maxPages:
            100,
        theme:
            pw.ThemeData.withFont(
          base:
              regular,
          bold:
              bold,
        ),
        build:
            (_) => [
          pw.Text(
            report.title,
            style:
                pw.TextStyle(
              font:
                  bold,
              fontSize:
                  20,
            ),
          ),
          pw.SizedBox(
            height:
                4,
          ),
          pw.Text(
            'الفترة: '
            '${_date(report.from)}'
            ' إلى '
            '${_date(report.to)}',
          ),
          if (
            report.entityName !=
                null
          )
            pw.Text(
              'الاسم: '
              '${report.entityName}',
            ),
          pw.SizedBox(
            height:
                14,
          ),
          if (
            report.totals.isNotEmpty
          ) ...[
            pw.Text(
              'الملخص حسب العملة',
              style:
                  pw.TextStyle(
                font:
                    bold,
                fontSize:
                    14,
              ),
            ),
            pw.SizedBox(
              height:
                  6,
            ),
            _totalsTable(
              report,
              bold,
            ),
            pw.SizedBox(
              height:
                  14,
            ),
          ],
          if (
            report.balances.isNotEmpty
          ) ...[
            pw.Text(
              'أرصدة كشف الحساب',
              style:
                  pw.TextStyle(
                font:
                    bold,
                fontSize:
                    14,
              ),
            ),
            pw.SizedBox(
              height:
                  6,
            ),
            _balancesTable(
              report,
              bold,
            ),
            pw.SizedBox(
              height:
                  14,
            ),
          ],
          pw.Text(
            'الحركات',
            style:
                pw.TextStyle(
              font:
                  bold,
              fontSize:
                  14,
            ),
          ),
          pw.SizedBox(
            height:
                6,
          ),
          if (
            report.rows.isEmpty
          )
            pw.Text(
              'لا توجد حركات في الفترة المحددة.',
            )
          else
            _rowsTable(
              report,
              bold,
            ),
          if (
            report.truncated
          ) ...[
            pw.SizedBox(
              height:
                  8,
            ),
            pw.Text(
              'تنبيه: تم تصدير أول 3000 حركة فقط.',
            ),
          ],
        ],
      ),
    );

    return doc.save();
  }

  /// Creates a real XLSX file using the Office Open XML format.
  ///
  /// We intentionally avoid package:excel here because its current
  /// dependency range requires xml < 7 while pdf 3.13.x requires xml 7.
  static Uint8List _xlsx(
    ReportModel report,
  ) {
    final rows =
        <List<String>>[];

    void add(
      List<String> values,
    ) {
      rows.add(values);
    }

    add([
      report.title,
    ]);

    add([
      'الفترة',
      _date(report.from),
      _date(report.to),
    ]);

    if (
      report.entityName !=
          null
    ) {
      add([
        'الاسم',
        report.entityName!,
      ]);
    }

    add([]);

    add([
      'ملخص العملات',
    ]);

    add([
      'العملة',
      'عدد الحركات',
      'إجمالي التقرير',
      'الوارد النقدي',
      'الصادر النقدي',
    ]);

    for (
      final item
      in report.totals
    ) {
      add([
        item.currencyCode,
        item.rowsCount
            .toString(),
        _money(
          item.reportTotalMinor,
          item.decimalPlaces,
          item.currencySymbol,
        ),
        _money(
          item.cashInMinor,
          item.decimalPlaces,
          item.currencySymbol,
        ),
        _money(
          item.cashOutMinor,
          item.decimalPlaces,
          item.currencySymbol,
        ),
      ]);
    }

    if (
      report.balances.isNotEmpty
    ) {
      add([]);
      add([
        'أرصدة كشف الحساب',
      ]);

      add([
        'العملة',
        'مديونية أول المدة',
        'مديونية آخر المدة',
        'استحقاق أول المدة',
        'استحقاق آخر المدة',
        'سلف عامل أول المدة',
        'سلف عامل آخر المدة',
      ]);

      for (
        final item
        in report.balances
      ) {
        add([
          item.currencyCode,
          _money(
            item.openingReceivableMinor,
            item.decimalPlaces,
            item.currencySymbol,
          ),
          _money(
            item.closingReceivableMinor,
            item.decimalPlaces,
            item.currencySymbol,
          ),
          _money(
            item.openingPayableMinor !=
                    0
                ? item.openingPayableMinor
                : item.openingWorkerPayableMinor,
            item.decimalPlaces,
            item.currencySymbol,
          ),
          _money(
            item.closingPayableMinor !=
                    0
                ? item.closingPayableMinor
                : item.closingWorkerPayableMinor,
            item.decimalPlaces,
            item.currencySymbol,
          ),
          _money(
            item.openingWorkerAdvanceMinor,
            item.decimalPlaces,
            item.currencySymbol,
          ),
          _money(
            item.closingWorkerAdvanceMinor,
            item.decimalPlaces,
            item.currencySymbol,
          ),
        ]);
      }
    }

    add([]);
    add([
      'التاريخ',
      'رقم الحركة',
      'النوع',
      'الاسم',
      'البيان',
      'الحساب',
      'المبلغ',
      'العملة',
      'نقدي',
    ]);

    for (
      final item
      in report.rows
    ) {
      add([
        _date(
          item.occurredAt
              .toLocal(),
        ),
        item.transactionNo,
        _type(
          item.type,
        ),
        item.partyName ??
            item.workerName ??
            '',
        item.description ??
            item.notes ??
            '',
        item.financialAccountName ??
            '',
        MoneyUtils.formatMinor(
          item.reportAmountMinor,
          item.decimalPlaces,
        ),
        item.currencyCode,
        item.cashDirection ==
                'in'
            ? 'وارد'
            : item.cashDirection ==
                    'out'
                ? 'صادر'
                : '',
      ]);
    }

    final archive =
        Archive();

    void addXml(
      String path,
      String xml,
    ) {
      archive.add(
        ArchiveFile.string(
          path,
          xml,
        ),
      );
    }

    addXml(
      '[Content_Types].xml',
      _contentTypesXml,
    );

    addXml(
      '_rels/.rels',
      _rootRelationshipsXml,
    );

    addXml(
      'xl/workbook.xml',
      _workbookXml,
    );

    addXml(
      'xl/_rels/workbook.xml.rels',
      _workbookRelationshipsXml,
    );

    addXml(
      'xl/styles.xml',
      _stylesXml,
    );

    addXml(
      'xl/worksheets/sheet1.xml',
      _sheetXml(
        rows,
      ),
    );

    return ZipEncoder()
        .encodeBytes(
      archive,
    );
  }

  static String _sheetXml(
    List<List<String>> rows,
  ) {
    final buffer =
        StringBuffer();

    buffer.write(
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '<worksheet '
      'xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">',
    );

    buffer.write(
      '<sheetViews>'
      '<sheetView workbookViewId="0" rightToLeft="1"/>'
      '</sheetViews>',
    );

    buffer.write(
      '<sheetFormatPr defaultRowHeight="18"/>',
    );

    buffer.write(
      '<sheetData>',
    );

    for (
      var rowIndex = 0;
      rowIndex < rows.length;
      rowIndex++
    ) {
      final rowNumber =
          rowIndex + 1;

      buffer.write(
        '<row r="$rowNumber">',
      );

      final row =
          rows[rowIndex];

      for (
        var columnIndex = 0;
        columnIndex < row.length;
        columnIndex++
      ) {
        final cellReference =
            '${_columnName(columnIndex)}$rowNumber';

        final value =
            _xmlEscape(
          row[columnIndex],
        );

        buffer.write(
          '<c r="$cellReference" t="inlineStr">'
          '<is><t xml:space="preserve">'
          '$value'
          '</t></is>'
          '</c>',
        );
      }

      buffer.write(
        '</row>',
      );
    }

    buffer.write(
      '</sheetData>',
    );

    buffer.write(
      '<pageMargins '
      'left="0.4" right="0.4" '
      'top="0.5" bottom="0.5" '
      'header="0.2" footer="0.2"/>',
    );

    buffer.write(
      '</worksheet>',
    );

    return buffer.toString();
  }

  static String _columnName(
    int zeroBasedIndex,
  ) {
    var value =
        zeroBasedIndex + 1;

    final chars =
        <int>[];

    while (
      value > 0
    ) {
      value--;

      chars.add(
        65 +
            (
              value %
              26
            ),
      );

      value ~/=
          26;
    }

    return String.fromCharCodes(
      chars.reversed,
    );
  }

  static String _xmlEscape(
    String value,
  ) {
    return value
        .replaceAll(
          '&',
          '&amp;',
        )
        .replaceAll(
          '<',
          '&lt;',
        )
        .replaceAll(
          '>',
          '&gt;',
        )
        .replaceAll(
          '"',
          '&quot;',
        )
        .replaceAll(
          "'",
          '&apos;',
        );
  }

  static const String
      _contentTypesXml =
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">'
      '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>'
      '<Default Extension="xml" ContentType="application/xml"/>'
      '<Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>'
      '<Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>'
      '<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>'
      '</Types>';

  static const String
      _rootRelationshipsXml =
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
      '<Relationship '
      'Id="rId1" '
      'Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" '
      'Target="xl/workbook.xml"/>'
      '</Relationships>';

  static const String
      _workbookXml =
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '<workbook '
      'xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" '
      'xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">'
      '<bookViews><workbookView/></bookViews>'
      '<sheets>'
      '<sheet name="التقرير" sheetId="1" r:id="rId1"/>'
      '</sheets>'
      '</workbook>';

  static const String
      _workbookRelationshipsXml =
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
      '<Relationship '
      'Id="rId1" '
      'Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" '
      'Target="worksheets/sheet1.xml"/>'
      '<Relationship '
      'Id="rId2" '
      'Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" '
      'Target="styles.xml"/>'
      '</Relationships>';

  static const String
      _stylesXml =
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">'
      '<fonts count="1"><font><sz val="11"/><name val="Arial"/></font></fonts>'
      '<fills count="2">'
      '<fill><patternFill patternType="none"/></fill>'
      '<fill><patternFill patternType="gray125"/></fill>'
      '</fills>'
      '<borders count="1"><border/></borders>'
      '<cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs>'
      '<cellXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/></cellXfs>'
      '<cellStyles count="1"><cellStyle name="Normal" xfId="0" builtinId="0"/></cellStyles>'
      '</styleSheet>';

  static pw.Widget _totalsTable(
    ReportModel report,
    pw.Font bold,
  ) {
    return pw.Table(
      border:
          pw.TableBorder.all(
        width:
            .4,
      ),
      children: [
        _header(
          [
            'العملة',
            'الحركات',
            'الإجمالي',
            'الوارد',
            'الصادر',
          ],
          bold,
        ),
        ...report.totals.map(
          (item) =>
              _row([
            item.currencyCode,
            item.rowsCount
                .toString(),
            _money(
              item.reportTotalMinor,
              item.decimalPlaces,
              item.currencySymbol,
            ),
            _money(
              item.cashInMinor,
              item.decimalPlaces,
              item.currencySymbol,
            ),
            _money(
              item.cashOutMinor,
              item.decimalPlaces,
              item.currencySymbol,
            ),
          ]),
        ),
      ],
    );
  }

  static pw.Widget _balancesTable(
    ReportModel report,
    pw.Font bold,
  ) {
    return pw.Table(
      border:
          pw.TableBorder.all(
        width:
            .4,
      ),
      children: [
        _header(
          [
            'العملة',
            'مديونية أول',
            'مديونية آخر',
            'استحقاق أول',
            'استحقاق آخر',
          ],
          bold,
        ),
        ...report.balances.map(
          (item) =>
              _row([
            item.currencyCode,
            _money(
              item.openingReceivableMinor !=
                      0
                  ? item.openingReceivableMinor
                  : item.openingWorkerAdvanceMinor,
              item.decimalPlaces,
              item.currencySymbol,
            ),
            _money(
              item.closingReceivableMinor !=
                      0
                  ? item.closingReceivableMinor
                  : item.closingWorkerAdvanceMinor,
              item.decimalPlaces,
              item.currencySymbol,
            ),
            _money(
              item.openingPayableMinor !=
                      0
                  ? item.openingPayableMinor
                  : item.openingWorkerPayableMinor,
              item.decimalPlaces,
              item.currencySymbol,
            ),
            _money(
              item.closingPayableMinor !=
                      0
                  ? item.closingPayableMinor
                  : item.closingWorkerPayableMinor,
              item.decimalPlaces,
              item.currencySymbol,
            ),
          ]),
        ),
      ],
    );
  }

  static pw.Widget _rowsTable(
    ReportModel report,
    pw.Font bold,
  ) {
    return pw.Table(
      border:
          pw.TableBorder.all(
        width:
            .35,
      ),
      columnWidths:
          const {
        0:
            pw.FlexColumnWidth(
          1.1,
        ),
        1:
            pw.FlexColumnWidth(
          1.2,
        ),
        2:
            pw.FlexColumnWidth(
          1.4,
        ),
        3:
            pw.FlexColumnWidth(
          2.1,
        ),
        4:
            pw.FlexColumnWidth(
          1.4,
        ),
      },
      children: [
        _header(
          [
            'التاريخ',
            'النوع',
            'الاسم',
            'البيان',
            'المبلغ',
          ],
          bold,
        ),
        ...report.rows.map(
          (item) =>
              _row([
            _date(
              item.occurredAt
                  .toLocal(),
            ),
            _type(
              item.type,
            ),
            item.partyName ??
                item.workerName ??
                '-',
            item.description ??
                item.transactionNo,
            _money(
              item.reportAmountMinor,
              item.decimalPlaces,
              item.currencySymbol,
            ),
          ]),
        ),
      ],
    );
  }

  static pw.TableRow _header(
    List<String> values,
    pw.Font bold,
  ) {
    return pw.TableRow(
      decoration:
          const pw.BoxDecoration(
        color:
            PdfColors.grey200,
      ),
      children:
          values
              .map(
                (value) =>
                    _cell(
                  value,
                  bold:
                      bold,
                ),
              )
              .toList(),
    );
  }

  static pw.TableRow _row(
    List<String> values,
  ) {
    return pw.TableRow(
      children:
          values
              .map(
                _cell,
              )
              .toList(),
    );
  }

  static pw.Widget _cell(
    String value, {
    pw.Font? bold,
  }) {
    return pw.Padding(
      padding:
          const pw.EdgeInsets.all(
        4,
      ),
      child:
          pw.Text(
        value,
        textAlign:
            pw.TextAlign.right,
        style:
            pw.TextStyle(
          font:
              bold,
          fontSize:
              8,
        ),
      ),
    );
  }

  static String _money(
    int minor,
    int decimalPlaces,
    String symbol,
  ) {
    return '${MoneyUtils.formatMinor(minor, decimalPlaces)} $symbol';
  }

  static String _date(
    DateTime value,
  ) {
    String two(
      int n,
    ) =>
        n
            .toString()
            .padLeft(
              2,
              '0',
            );

    return '${value.year}-'
        '${two(value.month)}-'
        '${two(value.day)}';
  }

  static String _type(
    String type,
  ) {
    switch (type) {
      case 'sale':
        return 'بيع';
      case 'purchase':
        return 'شراء';
      case 'customer_collection':
        return 'تحصيل عميل';
      case 'supplier_payment':
        return 'دفع مورد';
      case 'expense':
        return 'مصروف';
      case 'other_income':
        return 'دخل آخر';
      case 'worker_salary_accrual':
        return 'استحقاق راتب';
      case 'worker_salary_payment':
        return 'دفع راتب';
      case 'worker_advance':
        return 'سلفة عامل';
      case 'worker_advance_recovery':
        return 'استرداد سلفة';
      case 'worker_deduction':
        return 'خصم عامل';
      case 'customer_opening_balance':
        return 'رصيد افتتاحي عميل';
      case 'supplier_opening_balance':
        return 'رصيد افتتاحي مورد';
      case 'worker_opening_payable':
        return 'رصيد افتتاحي عامل';
      case 'worker_opening_advance':
        return 'سلفة افتتاحية';
      case 'financial_account_opening_balance':
        return 'رصيد افتتاحي حساب';
      case 'transfer':
        return 'تحويل';
      default:
        return type;
    }
  }

  static String _fileName(
    ReportModel report,
    String extension,
  ) {
    final safe =
        report.title
            .replaceAll(
              RegExp(
                r'[\\/:*?"<>|]+',
              ),
              '_',
            )
            .replaceAll(
              ' ',
              '_',
            );

    return '${safe}_'
        '${_date(report.from)}_'
        '${_date(report.to)}.'
        '$extension';
  }
}
