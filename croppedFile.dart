// https://pub.dev/packages/image_cropper
                  
croppedFile == null
? Container()
: Image.file(croppedFile),
IconButton(
  icon: Icon(Icons.send),
  onPressed: () async{
    PickedFile imageFile = await imagePicker.getImage(source: ImageSource.gallery);
    if(imageFile == null ) return;
    croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    setState(() {});
  },
),
