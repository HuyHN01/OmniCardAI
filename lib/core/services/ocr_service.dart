import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class OcrService {
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final _picker = ImagePicker();

  //Open camera to capture image
  Future<XFile?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      return image;
    }
    catch (e) {
      throw Exception('Error picking image from camera: $e');
    }
  }

  //Process image and extract text
  Future<String> extractTextFromImage(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);

      return recognizedText.text;
    }
    catch (e) {
      throw Exception('Error extracting text from image: $e');
    }
  }

  void dispose() {
    _textRecognizer.close();
  }
}