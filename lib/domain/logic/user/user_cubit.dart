import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:streamchat/data/contracts/contract.dart';
import 'package:streamchat/domain/models/usermodel.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final ContractUserDataSource _dataSource;
  UserCubit(ContractUserDataSource dataSource)
      : _dataSource = dataSource,
        super(UserState());

  Future getuser()async{
    try {
      emit(state.copyWith(enumuser: StateUser.loading));
      final resp = await _dataSource.user();
      emit(state.copyWith(user: resp, enumuser: StateUser.success));
    } catch (e) {
      emit(state.copyWith(enumuser: StateUser.error));
    }
  }


    Future contacts() async{
    try {
      emit(state.copyWith(enumlistuser: StateListUsers.loading));
      final resp = await _dataSource.contacts();
      emit(state.copyWith(listuser: resp, enumlistuser: StateListUsers.success));
    } catch (e) {
      emit(state.copyWith(enumlistuser: StateListUsers.error));
    }
  }
}
