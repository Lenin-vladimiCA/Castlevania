import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

const bg = Color(0xFF0B0710), panel = Color(0xFF17101F), blood = Color(0xFFA3121F);
const gold = Color(0xFFD4A73A), bone = Color(0xFFE8DCC4);
const serif = 'serif';

class Ch {
  final String id, name, role, desc, moment, momentDesc, video;
  const Ch(this.id, this.name, this.role, this.desc, this.moment, this.momentDesc, this.video);
  String get img => 'assets/img/$id.jpg';
}

const chars = [
  Ch('trevor', 'Trevor Belmont', 'Cazavampiros',
      'Último de la legendaria familia Belmont, desterrada por la Iglesia. Bebedor, cínico y sarcástico, pero de gran corazón. Maneja un látigo sagrado con enorme destreza.',
      'Trevor vs Alucard',
      'Trevor y Sypha creen que Alucard es un monstruo y lo enfrentan. Látigo contra espada: una de las peleas mejor animadas de la serie, que termina en empate… y en alianza.',
      'wCBdaDvybsc'),
  Ch('alucard', 'Alucard (Adrian Tepes)', 'Dhampir, hijo de Dracula',
      'Mitad humano, mitad vampiro. Elegante, letal y melancólico. Duerme en el castillo de su padre hasta que despierta para ayudar a la humanidad.',
      'Alucard vs Dracula',
      'El momento más doloroso: hijo contra padre. Alucard debe enfrentar a Dracula con el corazón roto, por el sueño de su madre Lisa.',
      'qMNnU4CwmUc'),
  Ch('sypha', 'Sypha Belnades', 'Hechicera Speaker',
      'Joven maga de la orden de los Speakers. Domina el hielo, el fuego y el rayo. Inteligente, valiente y el corazón del grupo.',
      'Batalla del castillo de Dracula',
      'Sypha, Trevor y Alucard asaltan el castillo de Dracula al ritmo de "Bloody Tears". Aquí brilla su magia en plena batalla.',
      'jwrqNI0Y8Jk'),
  Ch('hector', 'Hector', 'Forjador demoníaco',
      'Antiguo Forjador de Dracula que crea criaturas de la noche. Caído en manos de Carmilla, termina buscando redención.',
      'Isaac confronta a Hector',
      'Isaac llega al castillo de Styria. Un enfrentamiento cargado de traición, venganza y sangre entre dos Forjadores.',
      'jnYt_4srN2s'),
  Ch('dracula', 'Dracula (Vlad Tepes)', 'Señor de los vampiros',
      'Antiguo noble de Wallachia, brillante científico y vampiro poderoso. Perdió a su esposa Lisa y juró acabar con la humanidad.',
      'El trío contra Dracula',
      'Trevor, Alucard y Sypha se enfrentan juntos al Señor Oscuro en la gran batalla final de la temporada 2.',
      '22lIKww32iQ'),
];

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Castlevania',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: bg,
          fontFamily: serif,
          colorScheme: const ColorScheme.dark(primary: gold, secondary: blood, surface: panel),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF050308), foregroundColor: gold),
        ),
        home: const Shell(),
      );
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int i = 0;
  @override
  Widget build(BuildContext c) {
    final pages = [const Home(), const Chars(), const Moments(), const About(), const GamePage(), const Hire()];
    return Scaffold(
      body: SafeArea(child: IndexedStack(index: i, children: pages)),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF050308),
        indicatorColor: blood,
        selectedIndex: i,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (v) => setState(() => i = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.castle), label: 'Portada'),
          NavigationDestination(icon: Icon(Icons.people), label: 'Personajes'),
          NavigationDestination(icon: Icon(Icons.flash_on), label: 'Momentos'),
          NavigationDestination(icon: Icon(Icons.menu_book), label: 'Acerca de'),
          NavigationDestination(icon: Icon(Icons.sports_esports), label: 'Juega'),
          NavigationDestination(icon: Icon(Icons.work), label: 'Contrátame'),
        ],
      ),
    );
  }
}

Widget title(String t) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(t.toUpperCase(),
          style: const TextStyle(color: gold, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
    );

Widget bigBtn(String t, VoidCallback f) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: blood,
              padding: const EdgeInsets.all(14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3), side: const BorderSide(color: gold))),
          onPressed: f,
          child: Text(t, style: const TextStyle(letterSpacing: 1.5, fontSize: 15)),
        ),
      ),
    );

Future<void> open(String u) => launchUrl(Uri.parse(u), mode: LaunchMode.externalApplication);

// ---------------- Portada ----------------
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final pc = PageController();
  Timer? tm;
  int p = 0;
  @override
  void initState() {
    super.initState();
    tm = Timer.periodic(const Duration(seconds: 3), (_) {
      p = (p + 1) % chars.length;
      if (pc.hasClients) pc.animateToPage(p, duration: const Duration(milliseconds: 900), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    tm?.cancel();
    pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext c) => Container(
        decoration: const BoxDecoration(
            gradient: RadialGradient(center: Alignment(0, -1.1), radius: 1.1, colors: [Color(0xFF3A0C18), bg])),
        child: ListView(padding: const EdgeInsets.all(16), children: [
          const Center(
              child: Text('CASTLEVANIA',
                  style: TextStyle(color: gold, fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 4,
                      shadows: [Shadow(color: blood, blurRadius: 20)]))),
          const Center(child: Text('Serie animada · Netflix', style: TextStyle(color: Colors.grey))),
          const SizedBox(height: 12),
          Container(
            height: 320,
            decoration: BoxDecoration(border: Border.all(color: gold, width: 2)),
            child: PageView(
              controller: pc,
              children: [
                for (final h in chars)
                  Stack(fit: StackFit.expand, children: [
                    Image.asset(h.img, fit: BoxFit.cover),
                    Container(decoration: const BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.center, end: Alignment.bottomCenter, colors: [Colors.transparent, bg]))),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(h.name.toUpperCase(), style: const TextStyle(color: gold, fontSize: 20, letterSpacing: 3)))),
                  ]),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
              'Dracula perdió a su esposa Lisa, condenada a la hoguera por la Iglesia, y juró que la humanidad pagaría con sangre. Solo un Belmont caído en desgracia, una hechicera y el hijo del propio vampiro pueden detenerlo.',
              style: TextStyle(color: bone, fontSize: 16, height: 1.5)),
          const SizedBox(height: 8),
          bigBtn('▶  VER INTRO', () => Navigator.push(c, MaterialPageRoute(
              builder: (_) => VideoPage('Intro · Castlevania', 'yy_FWdbnvM0', 'Opening title · Netflix', null, auto: true)))),
        ]),
      );
}

// ---------------- Video ----------------
class VideoPage extends StatefulWidget {
  final String t, id, d;
  final String? img;
  final bool auto;
  const VideoPage(this.t, this.id, this.d, this.img, {super.key, this.auto = false});
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late final YoutubePlayerController yc = YoutubePlayerController(
      initialVideoId: widget.id, flags: YoutubePlayerFlags(autoPlay: widget.auto, forceHD: false));
  @override
  void dispose() {
    yc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext c) => YoutubePlayerBuilder(
        player: YoutubePlayer(controller: yc, progressIndicatorColor: blood),
        builder: (ctx, player) => Scaffold(
          appBar: AppBar(title: Text(widget.t)),
          body: ListView(padding: const EdgeInsets.all(14), children: [
            if (widget.img != null)
              Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                      decoration: BoxDecoration(border: Border.all(color: gold, width: 2)),
                      child: Image.asset(widget.img!, height: 240, width: double.infinity, fit: BoxFit.cover))),
            Text(widget.d, style: const TextStyle(color: bone, fontSize: 16, height: 1.5)),
            const SizedBox(height: 14),
            player,
          ]),
        ),
      );
}

// ---------------- Personajes ----------------
class Chars extends StatelessWidget {
  const Chars({super.key});
  @override
  Widget build(BuildContext c) => ListView(padding: const EdgeInsets.all(16), children: [
        title('Personajes'),
        for (final h in chars)
          Card(
            color: panel,
            shape: const RoundedRectangleBorder(side: BorderSide(color: blood, width: 1)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: CircleAvatar(radius: 32, backgroundImage: AssetImage(h.img)),
              title: Text(h.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              subtitle: Text(h.role),
              onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => Detail(h))),
            ),
          ),
      ]);
}

class Detail extends StatelessWidget {
  final Ch h;
  const Detail(this.h, {super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: AppBar(title: Text(h.name)),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          Container(
              decoration: BoxDecoration(border: Border.all(color: gold, width: 2)),
              child: Image.asset(h.img, height: 340, width: double.infinity, fit: BoxFit.cover)),
          const SizedBox(height: 14),
          Text(h.name.toUpperCase(), style: const TextStyle(color: gold, fontSize: 24, letterSpacing: 2)),
          Text(h.role, style: const TextStyle(color: Colors.grey, fontSize: 16)),
          const SizedBox(height: 10),
          Text(h.desc, style: const TextStyle(color: bone, fontSize: 16, height: 1.5)),
        ]),
      );
}

// ---------------- Momentos ----------------
class Moments extends StatelessWidget {
  const Moments({super.key});
  @override
  Widget build(BuildContext c) => ListView(padding: const EdgeInsets.all(16), children: [
        title('Momentos de batalla'),
        for (final h in chars)
          Card(
            color: panel,
            shape: const RoundedRectangleBorder(side: BorderSide(color: blood, width: 1)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: ClipRRect(borderRadius: BorderRadius.circular(4), child: Image.asset(h.img, width: 64, height: 64, fit: BoxFit.cover)),
              title: Text(h.moment, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text('Favorito de ${h.name.split(' ').first}'),
              trailing: const Icon(Icons.play_circle, color: gold),
              onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => VideoPage(h.moment, h.video, h.momentDesc, h.img))),
            ),
          ),
      ]);
}

// ---------------- Acerca de ----------------
class About extends StatelessWidget {
  const About({super.key});
  @override
  Widget build(BuildContext c) {
    const s = TextStyle(color: bone, fontSize: 16, height: 1.6);
    return ListView(padding: const EdgeInsets.all(16), children: [
      title('Acerca de'),
      const Text('Castlevania es una serie animada para adultos de Netflix, basada en la saga de videojuegos de Konami (principalmente Castlevania III: Dracula\'s Curse).', style: s),
      const SizedBox(height: 12),
      const Text('Creador / guionista: Warren Ellis\nProductor: Adi Shankar\nEstudio: Powerhouse Animation\nEstreno: 7 de julio de 2017\nTemporadas: 4 (37 episodios)\nFinal: 13 de mayo de 2021', style: s),
      const SizedBox(height: 12),
      const Text('Su spin-off, Castlevania: Nocturne, continúa la historia con Richter Belmont.', style: s),
    ]);
  }
}

// ---------------- Juega conmigo ----------------
class En {
  bool bat;
  double x, y;
  En(this.bat, this.x, this.y);
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with SingleTickerProviderStateMixin {
  static const gy = 160.0;
  late final Ticker tk;
  Duration last = Duration.zero;
  double acc = 0, py = gy, vy = 0, t = 0;
  bool running = false;
  int score = 0, lives = 3, hi = 0, whip = 0;
  List<En> en = [];
  final rnd = Random();

  @override
  void initState() {
    super.initState();
    tk = createTicker((d) {
      var dt = (d - last).inMicroseconds / 1e6;
      last = d;
      if (dt > .1) dt = .1;
      acc += dt;
      var ch = false;
      while (acc >= 1 / 60) {
        acc -= 1 / 60;
        if (running) step();
        ch = true;
      }
      if (ch && mounted) setState(() {});
    })..start();
  }

  @override
  void dispose() {
    tk.dispose();
    super.dispose();
  }

  void start() {
    py = gy; vy = 0; t = 0; score = 0; lives = 3; whip = 0; en = []; running = true;
  }

  void jump() { if (!running) { start(); return; } if (py >= gy) vy = -9.5; }
  void lash() { if (!running) { start(); return; } whip = 10; }

  void step() {
    t += 3;
    vy += .55;
    py = min(gy, py + vy);
    if (py >= gy) vy = 0;
    if (whip > 0) whip--;
    if (rnd.nextDouble() < .018 + t / 60000) {
      final bat = rnd.nextBool();
      en.add(En(bat, 370, bat ? gy - 45 - rnd.nextDouble() * 25 : gy));
    }
    final keep = <En>[];
    for (final e in en) {
      e.x -= 2.5 + t / 2500;
      final dx = e.x - 50;
      if (e.bat && whip > 0 && dx > 10 && dx < 95) { score += 10; continue; }
      if (dx > -8 && dx < 22) {
        final hit = e.bat ? (e.y - py).abs() < 26 : py > gy - 18;
        if (hit) {
          lives--;
          if (lives < 1) { running = false; hi = max(hi, score); }
          continue;
        }
      }
      if (e.x < -20) { score += 1; continue; }
      keep.add(e);
    }
    en = keep;
  }

  @override
  Widget build(BuildContext c) {
    const s = TextStyle(color: bone, fontSize: 16, height: 1.5);
    return ListView(padding: const EdgeInsets.all(16), children: [
      title('Juega conmigo'),
      const Text('Cacería en el castillo: toca LÁTIGO para destruir murciélagos y SALTAR para esquivar esqueletos. ¿Cuánto aguantas?', style: s),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Puntos: $score', style: const TextStyle(color: gold)),
          Text('Vidas: $lives', style: const TextStyle(color: gold)),
          Text('Récord: $hi', style: const TextStyle(color: gold)),
        ]),
      ),
      GestureDetector(
        onTap: () { if (!running) start(); },
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: gold, width: 2)),
          child: AspectRatio(aspectRatio: 1.8, child: CustomPaint(painter: GamePainter(this))),
        ),
      ),
      Row(children: [
        Expanded(child: bigBtn('⚔ LÁTIGO', lash)),
        const SizedBox(width: 10),
        Expanded(child: bigBtn('⤒ SALTAR', jump)),
      ]),
      const SizedBox(height: 10),
      const Text('EL CASTLEVANIA ORIGINAL (1986)', style: TextStyle(color: gold, fontSize: 18, letterSpacing: 1.5)),
      const SizedBox(height: 6),
      const Text('El juego más antiguo de la saga que se puede jugar en el teléfono es Castlevania: 40th Anniversary, el port directo del clásico de NES, con controles táctiles y modo offline.', style: s),
      bigBtn('ANDROID · GOOGLE PLAY', () => open('https://play.google.com/store/search?q=Castlevania%2040th%20Anniversary&c=apps')),
      bigBtn('iPHONE · APP STORE', () => open('https://apps.apple.com/search?term=Castlevania%2040th%20Anniversary')),
      const Text('Gratis hasta el 24 de octubre de 2026; quien lo descargue en ese plazo lo conserva.', style: TextStyle(color: Colors.grey)),
    ]);
  }
}

class GamePainter extends CustomPainter {
  final _GamePageState g;
  GamePainter(this.g);

  void txt(Canvas c, String s, double x, double y, double fs, [Color col = bone]) {
    final tp = TextPainter(text: TextSpan(text: s, style: TextStyle(fontSize: fs, color: col, fontFamily: serif)), textDirection: TextDirection.ltr)..layout();
    tp.paint(c, Offset(x, y));
  }

  @override
  void paint(Canvas c, Size sz) {
    c.save();
    c.scale(sz.width / 360, sz.height / 200);
    c.drawRect(const Rect.fromLTWH(0, 0, 360, 200), Paint()..color = const Color(0xFF120A1C));
    c.drawCircle(const Offset(300, 40), 18, Paint()..color = bone);
    final cp = Paint()..color = const Color(0xFF1D1030);
    for (var i = 0; i < 6; i++) {
      c.drawRect(Rect.fromLTWH(i * 70 - (g.t % 70), 90, 40, 70), cp);
    }
    c.drawRect(const Rect.fromLTWH(0, 184, 360, 16), Paint()..color = const Color(0xFF3B2447));
    txt(c, '🧔', 50, g.py - 4, 26);
    if (g.whip > 0) {
      c.drawLine(Offset(78, g.py + 10), Offset(78 + g.whip * 9, g.py + 4), Paint()..color = gold..strokeWidth = 3);
    }
    for (final e in g.en) {
      txt(c, e.bat ? '🦇' : '💀', e.x, (e.bat ? e.y : _GamePageState.gy) - 4, 26);
    }
    if (!g.running) {
      c.drawRect(const Rect.fromLTWH(0, 0, 360, 200), Paint()..color = const Color(0xAA000000));
      final m = g.score > 0 ? 'GAME OVER · ${g.score} pts' : 'Toca para empezar';
      txt(c, m, 180 - m.length * 5.2, 90, 20, gold);
    }
    c.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter o) => true;
}

// ---------------- Contrátame ----------------
class Hire extends StatelessWidget {
  const Hire({super.key});
  @override
  Widget build(BuildContext c) => ListView(padding: const EdgeInsets.all(16), children: [
        title('Contrátame'),
        Center(child: CircleAvatar(radius: 75, backgroundColor: gold, child: CircleAvatar(radius: 72, backgroundImage: const AssetImage('assets/img/lenin.jpg')))),
        const SizedBox(height: 12),
        const Center(child: Text('Lenin Vladimir Calderón', style: TextStyle(color: gold, fontSize: 22, fontWeight: FontWeight.bold))),
        const Center(child: Text('Desarrollador de aplicaciones móviles', style: TextStyle(color: bone, fontSize: 16))),
        const Center(child: Text('Matrícula 2023-1403 · ITLA', style: TextStyle(color: Colors.grey))),
        const SizedBox(height: 12),
        bigBtn('✉  TU_CORREO@ejemplo.com', () => open('mailto:TU_CORREO@ejemplo.com')),
        bigBtn('☎  +1 (809) 000-0000', () => open('tel:+18090000000')),
        const Center(child: Text('Santo Domingo, República Dominicana', style: TextStyle(color: Colors.grey))),
      ]);
}
