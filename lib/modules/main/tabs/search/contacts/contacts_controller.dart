import 'package:get/get.dart';

class ContactsController extends GetxController{
  var contactList = <ContactModel>[].obs;

  final String testUrl1 =
      'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80';
  final String testUrl2 =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
  final String testUrl3 =
      'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';


  @override
  void onInit() {
    callContactsApi();
    super.onInit();
  }

  Future<void> callContactsApi() async {
    contactList.add(
      ContactModel(testUrl1, 'Robert De Niro', 'Recommend'),
    );
    contactList.add(
      ContactModel(testUrl2, 'Katharine Hepburn', 'Recommend'),
    );
    contactList.add(
      ContactModel(testUrl3, 'Meryl Streep', 'Recommend'),
    );
    contactList.add(
      ContactModel(testUrl1, 'Sidney Poitier', 'Recommend'),
    );
    contactList.add(
      ContactModel(testUrl2, 'Elizabeth Taylor', 'Recommend'),
    );

  }
}

class ContactModel{
  final String profileImage;
  final String name;
  final String detail;

  ContactModel(this.profileImage, this.name, this.detail);

}