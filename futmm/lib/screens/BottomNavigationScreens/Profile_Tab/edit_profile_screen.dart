import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:futmm/models/user_models.dart';
import 'package:futmm/services/database_services.dart';
import 'package:futmm/services/storage_service.dart';
import 'package:futmm/utilities/custom_buttons.dart';
import 'package:futmm/utilities/custom_textform.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

/* DEVELOPED BASED ON ASUS MEASUREMENTS (CHECK size_config file at the end of uncommented code*/

class EditProfileScreen extends StatefulWidget {

  final User user;
  EditProfileScreen({this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final _formKey = GlobalKey<FormState>();
  File _profileImage;
  String _name = '';
  String _password = '';
  bool _isLoadingImage = false;

  @override
  void initState(){
    super.initState();
    _name = widget.user.name;
  }

  _handleImageFromGallery() async{
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null){
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  _displayProfileImage(){
    if (_profileImage == null){
      if(widget.user.profileImageUrl.isEmpty){
        //display placeholder
        return AssetImage('assets/images/UserApp/user_placeholder.jpg');
      }else{
        return CachedNetworkImageProvider(widget.user.profileImageUrl);
      }
    }else{
      return FileImage(_profileImage);
    }
  }

  _submit() async{
    if (_formKey.currentState.validate()){
      // Update user in database
      _formKey.currentState.save();
      setState(() {_isLoadingImage = true;});
      String _profileImageUrl = '';
      if(_profileImage == null){
        _profileImageUrl = widget.user.profileImageUrl;
      }else {
        _profileImageUrl = await StorageService.uploadUserProfileImage(
            widget.user.profileImageUrl, _profileImage);}
      User user = User(
        id: widget.user.id,
        name: _name,
        profileImageUrl: _profileImageUrl,
      );
      // Database update
      DataBaseService.updateUser(user);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.fromLTRB(5 * SizeConfig.widthMultiplier, 6.5 * SizeConfig.heightMultiplier, 5 * SizeConfig.widthMultiplier , 0.0), /* 40.0 */
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              child: Icon(
                                Icons.arrow_back,
                                size: 7.5 * SizeConfig.widthMultiplier, /* 30 */
                              ),
                              onTap: () => Navigator.pop(context),
                            ),
                            Text('Editar o perfil',
                                style: kTitleStyle),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.12 * SizeConfig.heightMultiplier, /* 40 */
                        child: ListView(
                          children: <Widget>[
                            _isLoadingImage ?
                            LinearProgressIndicator(
                              backgroundColor: ColorsApp.lightGreenColor,
                              valueColor: AlwaysStoppedAnimation(ColorsApp.normalGreenColor),
                            ) : SizedBox.shrink(),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.56 * SizeConfig.heightMultiplier), /* 20 */
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorsApp.lightGreyColor2,
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                          onTap: () => _handleImageFromGallery(),
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundColor: checkDarkTheme(context) ? ColorsApp.blackColor : ColorsApp.whiteColor,
                            backgroundImage: _displayProfileImage(),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.28 * SizeConfig.heightMultiplier), /* 10 */
                      Text('Clique no círculo para alterar', style: kSubtitleStyle),
                      SizedBox(height: 5.12 * SizeConfig.heightMultiplier), /* 40 */
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.8 * SizeConfig.widthMultiplier), /* 40 */
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10.2 * SizeConfig.heightMultiplier, /* 80 */
                              child: EditProfileFormField(
                                labelText: 'Nome',
                                initialValue: _name,
                                obscureText: false,
                                validator: (input) => input.trim().isEmpty ? 'Introduza um nome válido' : null,
                                onSaved: (input) => _name = input,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            /*SizedBox(
                            height: 80,
                            child: EditProfileFormField(
                              labelText: 'Password',
                              initialValue: _password,
                              obscureText: true,
                              validator: (input) => input.length < 8 ? 'A password deve conter pelo menos 8 caracteres' : null,
                              onSaved: (input) => _password = input,
                              keyboardType: null,
                            ),
                          ),*/
                            SizedBox(height: 6.41 * SizeConfig.heightMultiplier), /* 50 */
                            SizedBox(
                              width: double.infinity,
                              height: 6.28 * SizeConfig.heightMultiplier, /* new: 49 old: 52 -> 6.66 */
                              child: FilledButton(
                                text: 'Guardar alterações',
                                onPressed: _submit,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
