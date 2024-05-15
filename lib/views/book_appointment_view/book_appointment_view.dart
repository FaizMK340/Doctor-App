import 'package:doctor_app/controllers/appointment_controller.dart';
import 'package:doctor_app/res/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../res/components/custom_elevated_button.dart';

class BookAppointmentView extends StatelessWidget {
  final String docId;
  final String docName;
  const BookAppointmentView({super.key,required this.docId,required this.docName});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:  Text(
          docName,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select appointment day",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              CustomTextField(hint: "Select day",textController: controller.appDayController,),
              const Gap(20),
              Text(
                "Select appointment time",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              CustomTextField(hint: "Select time",textController: controller.appTimeController,),
              const Gap(20),
              Text(
                "Mobile Number",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              CustomTextField(hint: "Enter Your Mobile Number",textController: controller.appPhoneController,),
              const Gap(20),
              Text(
                "Full Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              CustomTextField(hint: "Enter Your Name",textController: controller.appNameController,),
              const Gap(20),
              Text(
                "Message",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              CustomTextField(hint: "Enter Your Message",textController: controller.appMessageController,),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(()=>
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: controller.isLoading.value?Center(
            child: CircularProgressIndicator(),
          ):CustomElevatedButton(
              buttonText: "Book an appointment",
              onTap: () async{
               await controller.bookAppointment(docId,docName, context);
        
              }),
        ),
      ),
    );
  }
}
