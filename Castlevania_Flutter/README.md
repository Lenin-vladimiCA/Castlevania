# Castlevania (Flutter)
APK en la nube: sube TODO el contenido de esta carpeta a un repo de GitHub -> Actions -> Build APK -> descarga castlevania-apk.
Local: flutter create --platforms=android . ; agrega INTERNET al AndroidManifest ; flutter build apk --release
Antes de subir: cambia tu correo y telefono en lib/main.dart (busca TU_CORREO).
PDF: python3 make_pdf.py "LINK_DE_TU_APK"
