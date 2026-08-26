import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/config/app_config.dart';
import 'core/network/api_client.dart';
import 'core/storage/secure_storage_service.dart';
import 'data/local/app_database.dart';
import 'data/remote/auth_remote_data_source.dart';
import 'data/remote/account_request_remote_data_source.dart';
import 'data/remote/party_remote_data_source.dart';
import 'data/remote/reference_remote_data_source.dart';
import 'data/remote/user_management_remote_data_source.dart';
import 'data/remote/worker_remote_data_source.dart';
import 'data/remote/accounting_remote_data_source.dart';
import 'data/remote/ledger_remote_data_source.dart';
import 'data/remote/product_remote_data_source.dart';
import 'data/remote/commerce_remote_data_source.dart';
import 'data/remote/simple_sale_remote_data_source.dart';
import 'data/remote/sync_remote_data_source.dart';
import 'data/remote/dashboard_remote_data_source.dart';
import 'data/remote/attachment_remote_data_source.dart';
import 'data/remote/manager_dashboard_remote_data_source.dart';
import 'data/remote/report_remote_data_source.dart';
import 'data/remote/report_request_remote_data_source.dart';
import 'data/remote/system_admin_remote_data_source.dart';
import 'providers/auth_provider.dart';
import 'providers/account_request_provider.dart';
import 'providers/party_provider.dart';
import 'providers/reference_data_provider.dart';
import 'providers/user_management_provider.dart';
import 'providers/worker_provider.dart';
import 'providers/accounting_provider.dart';
import 'providers/ledger_provider.dart';
import 'providers/product_provider.dart';
import 'providers/commerce_provider.dart';
import 'providers/simple_sale_provider.dart';
import 'providers/sync_provider.dart';
import 'providers/dashboard_provider.dart';
import 'providers/attachment_provider.dart';
import 'providers/manager_dashboard_provider.dart';
import 'providers/report_provider.dart';
import 'providers/report_request_provider.dart';
import 'providers/system_admin_provider.dart';
import 'repositories/auth_repository.dart';
import 'repositories/account_request_repository.dart';
import 'repositories/party_repository.dart';
import 'repositories/reference_repository.dart';
import 'repositories/user_management_repository.dart';
import 'repositories/worker_repository.dart';
import 'repositories/accounting_repository.dart';
import 'repositories/ledger_repository.dart';
import 'repositories/product_repository.dart';
import 'repositories/commerce_repository.dart';
import 'repositories/simple_sale_repository.dart';
import 'repositories/sync_repository.dart';
import 'repositories/dashboard_repository.dart';
import 'repositories/attachment_repository.dart';
import 'repositories/manager_dashboard_repository.dart';
import 'repositories/report_repository.dart';
import 'repositories/report_request_repository.dart';
import 'repositories/system_admin_repository.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();
  final storage = SecureStorageService();
  final apiClient = ApiClient(storage);

  final authRepository = AuthRepository(
    database: database,
    storage: storage,
    remote: AuthRemoteDataSource(apiClient),
  );

  final accountRequestRepository =
      AccountRequestRepository(
    remote:
        AccountRequestRemoteDataSource(
      apiClient,
    ),
  );

  final userRepository =
      UserManagementRepository(
    remote:
        UserManagementRemoteDataSource(
      apiClient,
    ),
  );

  final referenceRepository =
      ReferenceRepository(
    database: database,
    remote:
        ReferenceRemoteDataSource(
      apiClient,
    ),
  );

  final partyRepository =
      PartyRepository(
    database: database,
    remote:
        PartyRemoteDataSource(
      apiClient,
    ),
  );

  final workerRepository =
      WorkerRepository(
    database: database,
    remote:
        WorkerRemoteDataSource(
      apiClient,
    ),
  );

  final accountingRepository =
      AccountingRepository(
    database: database,
    remote:
        AccountingRemoteDataSource(
      apiClient,
    ),
  );

  final ledgerRepository =
      LedgerRepository(
    database: database,
    remote:
        LedgerRemoteDataSource(
      apiClient,
    ),
  );

  final productRepository =
      ProductRepository(
    database: database,
    remote:
        ProductRemoteDataSource(
      apiClient,
    ),
  );

  final commerceRepository =
      CommerceRepository(
    database: database,
    remote:
        CommerceRemoteDataSource(
      apiClient,
    ),
  );

  final simpleSaleRepository =
      SimpleSaleRepository(
    database: database,
    remote:
        SimpleSaleRemoteDataSource(
      apiClient,
    ),
  );

  final syncRepository =
      SyncRepository(
    database: database,
    remote:
        SyncRemoteDataSource(
      apiClient,
    ),
    accountingRemote:
        AccountingRemoteDataSource(
      apiClient,
    ),
    productRemote:
        ProductRemoteDataSource(
      apiClient,
    ),
  );

  final dashboardRepository =
      DashboardRepository(
    database: database,
    remote:
        DashboardRemoteDataSource(
      apiClient,
    ),
  );

  final attachmentRepository =
      AttachmentRepository(
    database: database,
    remote:
        AttachmentRemoteDataSource(
      apiClient,
    ),
  );

  final managerDashboardRepository =
      ManagerDashboardRepository(
    remote:
        ManagerDashboardRemoteDataSource(
      apiClient,
    ),
  );

  final reportRepository =
      ReportRepository(
    remote:
        ReportRemoteDataSource(
      apiClient,
    ),
  );

  final reportRequestRepository =
      ReportRequestRepository(
    remote:
        ReportRequestRemoteDataSource(
      apiClient,
    ),
  );

  final systemAdminRepository =
      SystemAdminRepository(
    remote:
        SystemAdminRemoteDataSource(
      apiClient,
    ),
  );

  runApp(
    ShopAccountsApp(
      authRepository: authRepository,
      accountRequestRepository:
          accountRequestRepository,
      userRepository: userRepository,
      referenceRepository:
          referenceRepository,
      partyRepository: partyRepository,
      workerRepository: workerRepository,
      accountingRepository:
          accountingRepository,
      ledgerRepository:
          ledgerRepository,
      productRepository:
          productRepository,
      commerceRepository:
          commerceRepository,
      simpleSaleRepository:
          simpleSaleRepository,
      syncRepository:
          syncRepository,
      dashboardRepository:
          dashboardRepository,
      attachmentRepository:
          attachmentRepository,
      managerDashboardRepository:
          managerDashboardRepository,
      reportRepository:
          reportRepository,
      reportRequestRepository:
          reportRequestRepository,
      systemAdminRepository:
          systemAdminRepository,
    ),
  );
}

class ShopAccountsApp
    extends StatelessWidget {
  final AuthRepository authRepository;

  final AccountRequestRepository
      accountRequestRepository;

  final UserManagementRepository
      userRepository;

  final ReferenceRepository
      referenceRepository;

  final PartyRepository partyRepository;

  final WorkerRepository workerRepository;

  final AccountingRepository
      accountingRepository;

  final LedgerRepository
      ledgerRepository;

  final ProductRepository
      productRepository;

  final CommerceRepository
      commerceRepository;

  final SimpleSaleRepository
      simpleSaleRepository;

  final SyncRepository
      syncRepository;

  final DashboardRepository
      dashboardRepository;

  final AttachmentRepository
      attachmentRepository;

  final ManagerDashboardRepository
      managerDashboardRepository;

  final ReportRepository
      reportRepository;

  final ReportRequestRepository
      reportRequestRepository;

  final SystemAdminRepository
      systemAdminRepository;

  const ShopAccountsApp({
    super.key,
    required this.authRepository,
    required this.accountRequestRepository,
    required this.userRepository,
    required this.referenceRepository,
    required this.partyRepository,
    required this.workerRepository,
    required this.accountingRepository,
    required this.ledgerRepository,
    required this.productRepository,
    required this.commerceRepository,
    required this.simpleSaleRepository,
    required this.syncRepository,
    required this.dashboardRepository,
    required this.attachmentRepository,
    required this.managerDashboardRepository,
    required this.reportRepository,
    required this.reportRequestRepository,
    required this.systemAdminRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              AuthProvider(
            authRepository,
          )..bootstrap(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              AccountRequestProvider(
            accountRequestRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              UserManagementProvider(
            userRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              ReferenceDataProvider(
            referenceRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              PartyProvider(
            partyRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              WorkerProvider(
            workerRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              AccountingProvider(
            accountingRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              LedgerProvider(
            ledgerRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              ProductProvider(
            productRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              CommerceProvider(
            commerceRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              SimpleSaleProvider(
            simpleSaleRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              SyncProvider(
            syncRepository,
          )..refreshCounts(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              DashboardProvider(
            dashboardRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              AttachmentProvider(
            attachmentRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              ManagerDashboardProvider(
            managerDashboardRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              ReportProvider(
            reportRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              ReportRequestProvider(
            reportRequestRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              SystemAdminProvider(
            systemAdminRepository,
          ),
        ),
      ],
      child: MaterialApp(
        title: AppConfig.appName,
        debugShowCheckedModeBanner:
            false,
        builder: (
          context,
          child,
        ) {
          return Directionality(
            textDirection:
                TextDirection.rtl,
            child:
                child ??
                    const SizedBox
                        .shrink(),
          );
        },
        theme: ThemeData(
          useMaterial3: true,
          inputDecorationTheme:
              const InputDecorationTheme(
            filled: true,
          ),
          cardTheme:
              const CardThemeData(
            margin: EdgeInsets.zero,
          ),
        ),
        home: const AuthGate(),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final auth =
        context.watch<AuthProvider>();

    if (auth.isBootstrapping) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    if (auth.isAuthenticated) {
      return const HomeScreen();
    }

    return const LoginScreen();
  }
}
