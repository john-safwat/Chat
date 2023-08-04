import 'package:chat/Domain/Models/User/Users.dart';
import 'package:chat/Domain/Repository/UsersRepositoryContract.dart';

class GetUsersListUseCase{
  UsersRepository repository;
  GetUsersListUseCase(this.repository);

  Future<List<Users>> invoke({required String roomId})async{
    var response = await repository.getUsersList(roomId);
    return response;
  }
}