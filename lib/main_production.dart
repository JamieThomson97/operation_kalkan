import 'package:operation_kalkan/app/app.dart';
import 'package:operation_kalkan/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
