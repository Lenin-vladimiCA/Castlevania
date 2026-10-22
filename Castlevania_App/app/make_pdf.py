# Uso: python3 make_pdf.py "https://tu-link-al-apk"
import sys
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from reportlab.graphics.barcode import qr
from reportlab.graphics.shapes import Drawing
from reportlab.graphics import renderPDF
url=sys.argv[1]
c=canvas.Canvas("Entrega_Castlevania_2023-1403.pdf",pagesize=letter);W,H=letter
c.setFillColorRGB(.04,.03,.06);c.rect(0,0,W,H,fill=1)
c.setFillColorRGB(.83,.65,.23);c.setFont("Times-Bold",30);c.drawCentredString(W/2,H-70,"CASTLEVANIA - App Móvil")
c.drawImage("www/img/lenin.jpg",W/2-70,H-260,140,140,mask=None)
c.setFont("Times-Bold",20);c.drawCentredString(W/2,H-290,"Lenin Vladimir Calderón")
c.setFillColorRGB(.9,.86,.77);c.setFont("Times-Roman",16);c.drawCentredString(W/2,H-315,"Matrícula: 2023-1403")
c.drawCentredString(W/2,H-355,"Descarga el APK:");c.setFont("Times-Roman",11);c.drawCentredString(W/2,H-375,url)
q=qr.QrCodeWidget(url);b=q.getBounds();s=200;d=Drawing(s,s,transform=[s/(b[2]-b[0]),0,0,s/(b[3]-b[1]),0,0]);d.add(q)
c.setFillColorRGB(1,1,1);c.rect(W/2-110,H-610,220,220,fill=1);renderPDF.draw(d,c,W/2-100,H-600)
c.linkURL(url,(W/2-200,H-380,W/2+200,H-368));c.save()
