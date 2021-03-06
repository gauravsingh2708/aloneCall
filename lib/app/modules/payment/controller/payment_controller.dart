import 'package:alonecall/app/data/model/bank_detail_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final HomeController _controller = Get.find();
  AddBankModel addBankModel = AddBankModel();
  TextEditingController amountEdit = TextEditingController();
  bool isLoading = true;
  String confirmAccount = '';
  bool initial = false;

  @override
  void onInit() async {
    getBankDetail();
    update();
    super.onInit();
  }

  void getBankDetail() async {
    await Repository().checkBank().then((value) async {
      initial = value;
      Utility.printDLog('Bank details is added $value');
      if (value) {
        await Repository().getBankDetails().then((value) {
          addBankModel = value;
          confirmAccount = value.accountNumber;
          Utility.printDLog('Bank details $value');

        });
      }
    });
    isLoading = false;
    update();
  }

  void onClickAdd() async{
    if (addBankModel.accountNumber.isEmpty ||
        addBankModel.ifsc.isEmpty ||
        addBankModel.name.isEmpty) {
      Utility.showError('Enter all Details');
    } else if (addBankModel.accountNumber != confirmAccount) {
      Utility.showError('Confirm account number is not correct');
    } else {
      Utility.showLoadingDialog();
      await Repository()
          .addBankDetails(addBankModel);
      await _controller.fetchBankDetails().then((value) => Utility.closeDialog());
    }
  }
}
