import 'dart:io';
import 'package:car_tracking/features/setting/business_logic/setting_cubit.dart';
import 'package:car_tracking/presentation/widgets/CustomTextFormField.dart';
import 'package:car_tracking/presentation/widgets/customSelectButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart'; // استيراد الباكدج

void CustomAddTypeBottomSheet(BuildContext context) {
  TextEditingController CarTypeController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final settingsCubit = BlocProvider.of<settingCubit>(context);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? selectedImage;
  File? selectedImage1;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) {
      return BlocProvider.value(
        value: settingsCubit,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Form(
            key: _formKey,
            child: StatefulBuilder(
              builder: (context, setState) {

                Future<File?> _pickImage(ImageSource source) async {
                  try {
                    final pickedFile = await _picker.pickImage(
                      source: source,
                    );
                    if (pickedFile != null) {
                      return File(pickedFile.path); // حفظ الصورة المختارة
                    } else {
                      print("No image selected.");
                      return null; // إذا لم يتم اختيار صورة
                    }
                  } catch (e) {
                    print("Error picking image: $e");
                    return null;
                  }
                }

                void _showPickerDialog(BuildContext context) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("selectSource"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.camera),
                              title: Text('pick_image'),
                              onTap: () async {
                                Navigator.pop(context);
                                selectedImage1 = await _pickImage(ImageSource.camera);
                                setState(() {});
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.photo_library),
                              title: Text('select_from_galary'),
                              onTap: () async {
                                Navigator.pop(context);
                                selectedImage1 = await _pickImage(ImageSource.gallery);
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      child: Divider(
                        thickness: 5,
                        color: Color(0xff6C6C89),
                      ),
                    ),
                    SizedBox(height: 24),
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Add Car Type",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 12),

                            CustomTextField(
                              controller: CarTypeController,
                              hintText: 'Car Type',
                              validator: (value){
                                if (value!.isEmpty) {
                                  return 'Enter Car Type ';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12),

                            // ✅ عرض الصورة إن وجدت
                            if (selectedImage1 != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  selectedImage1!,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                            SizedBox(height: 12),

                            // ✅ زرار رفع الصورة
                            customSelectButton(
                              btnText: "Upload Photo",
                              borderColor: Colors.blue,
                              behindIcon: Icons.upload,
                              iconColor: Colors.blue,
                              btnTextColor: Colors.blue,
                              ontap: () {
                                _showPickerDialog(context);

                              },
                              btnheight: 40,
                              btnHorzontalWidth: 0,
                            ),
                            SizedBox(height: 60),

                            // ✅ أزرار Add و Cancel
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 14),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.grey)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final allowedExtensions = ['jpg', 'jpeg', 'png', 'gif'];

                                        if (selectedImage1 == null) {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text('Please select an image'),
                                          ));
                                          return;
                                        }

                                        final extension = selectedImage1!.path.split('.').last.toLowerCase();
                                        if (!allowedExtensions.contains(extension)) {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text('Only JPEG, PNG, and GIF images are allowed'),
                                          ));
                                          return;
                                        }

                                        await BlocProvider.of<settingCubit>(context)
                                            .addCarType(CarTypeController.text, selectedImage1!);

                                        CarTypeController.clear();
                                        Navigator.pop(context); // يقفل الشييت بعد الفلترة
                                      } else {
                                        // لو التواريخ مش موجودة، ممكن تظهر رسالة تنبيه للمستخدم
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text('Please enter Car Type'),
                                        ));
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 14),
                                      decoration: BoxDecoration(
                                        color: Color(0xff167AD8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Add',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))
                  ],
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
