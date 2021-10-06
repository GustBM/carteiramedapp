enum ImageSourceType { gallery, camera }

class user_img extends StatelessWidget {
  void _handleURLButtonPress(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGallery(type)));
  }
  
  # fazer tela com botões bonitos
    onPressed: () {
                  _handleURLButtonPress(context, ImageSourceType.gallery);
                },
    onPressed: () {
                  _handleURLButtonPress(context, ImageSourceType.camera);
                },
