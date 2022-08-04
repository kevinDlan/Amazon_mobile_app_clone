import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/admin/models/sales.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:amazon/features/admin/widgets/category_products_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminService adminService = AdminService();
  List<Sales>? sales;
  int? totalSales;

  @override
  void initState() {
    super.initState();
    getEarning();
  }

  void getEarning() async {
    var datas = await adminService.fetchEarning(context);
    sales = datas['sales'];
    totalSales = datas['totalEarning'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return sales == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                "\$$totalSales",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductsChart(seriesList: [
                  charts.Series(
                      id: "Sales",
                      data: sales!,
                      domainFn: (Sales sales, _) => sales.label,
                      measureFn: (Sales sales, _) => sales.earning)
                ]),
              )
            ],
          );
  }
}
