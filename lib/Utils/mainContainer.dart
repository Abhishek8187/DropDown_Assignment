import 'package:drop_down/Utils/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MainContainer extends StatefulWidget {
  MainContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.borderRadius,
  }) : super(key: key);

  final double height;
  final double width;
  final double borderRadius;

  @override
  _MainContainerState createState() => _MainContainerState();
}
TextEditingController controller = TextEditingController();



class _MainContainerState extends State<MainContainer> {
  int selectedOptionIndex = -1;
  final List<IconData> icons = [Icons.link, Icons.photo, Icons.text_fields];


  File? image;
  ImagePicker picker = ImagePicker();

  bool loading = false;

  //*************** THIS FUNCTION IS USED TO PICK IMAGE FROM GALLERY ********//
  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80); //max image quality is 100
    setState(
          () {
        if (pickedFile != null) {
          image = File(pickedFile.path);
        } else {
          Utils().toastMessage('No file selected');
        }
      },
    );
  }

  void selectOption(int index) {
    setState(() {
      selectedOptionIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(color: Colors.grey),
      ),

      //*************** SHOWING MULTIPLE OPTIONS LIKE IMAGE, LINK, TEXT ************//
      child: selectedOptionIndex == -1
          ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => selectOption(0),
            child: Icon(icons[0]),
          ),
          GestureDetector(
            onTap: () async{

              await getGalleryImage();
              selectOption(1);
            },
            child: Icon(icons[1]),
          ),
          GestureDetector(
            onTap: () => selectOption(2),
            child: Icon(icons[2]),
          ),
        ],
      )
          : _buildSelectedOption(),
    );
  }

  //************ ACTION ACCORDING TO SELECTED OPTION AMONG LINK, IMAGE, TEXT ***********//

  Widget _buildSelectedOption() {
    IconData selectedIcon = icons[selectedOptionIndex];

    if (selectedIcon == Icons.link) {
      return  TextField(
            decoration: const InputDecoration(
            hintText: '   Paste your link',),
            keyboardType: TextInputType.url,
            controller: controller,
      );
    }

    else if (selectedIcon == Icons.photo) {
      return image != null
    ? Image.file(image!.absolute,fit: BoxFit.fill,)
        : const Center(child: Icon(Icons.photo));
    }

    else if (selectedIcon == Icons.text_fields) {
      return const TextField(
        decoration: InputDecoration(
          hintText: 'Write here'
        ),
      );
    }

    return Container(); // Default case
  }
}

