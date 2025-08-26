import '../base/button_factory.dart' show IButtonFactory;
import '../factories/custom_button_factory.dart';

enum ButtonType { delete, confirm, cancel, update, standard }

IButtonFactory oButton = ButtonFactory();
