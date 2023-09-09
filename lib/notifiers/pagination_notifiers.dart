import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/enums/PagesEnum.dart';

class PaginationNotifier extends StateNotifier<PageLocale> {
  PaginationNotifier() : super(PageLocale.dashboard);

  void changevalue(PageLocale newvalue) {
    state = newvalue;
  }
}
