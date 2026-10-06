import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/player_model.dart';
import '../models/team.dart';
import '../widgets/radar_chart.dart';
import '../core/database_service.dart';
import '../core/finance_service.dart';
import 'transfer_negotiation_screen.dart';

/// Cached text styles to avoid recreating on every build
class _PlayerDetailStyles {
  static final TextStyle appBarTitle = GoogleFonts.urbanist(
    fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1.5);
  static final TextStyle label = GoogleFonts.urbanist(
    color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.1);
  static final TextStyle value = GoogleFonts.urbanist(
    color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16);
  static final TextStyle valueAverage = GoogleFonts.urbanist(
    color: const Color(0xFFDEFF9A), fontWeight: FontWeight.w900, fontSize: 28);
  static final TextStyle buttonText = GoogleFonts.urbanist(
    fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5);
  static final TextStyle buttonTextSmall = GoogleFonts.urbanist(
    fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1.2);
  static final TextStyle dialogTitle = GoogleFonts.urbanist(
    color: Colors.white, fontWeight: FontWeight.bold);
  static final TextStyle injuryText = GoogleFonts.urbanist(
    color: Colors.redAccent, fontWeight: FontWeight.bold);
  static final TextStyle suspendedText = GoogleFonts.urbanist(
    color: Colors.amber, fontWeight: FontWeight.bold);
}

class PlayerDetailScreen extends StatefulWidget {
  final Player player;
  final DatabaseService dbService;
  final Team userTeam;

  const PlayerDetailScreen({
    super.key,
    required this.player,
    required this.dbService,
    required this.userTeam,
  });

  @override
  State<PlayerDetailScreen> createState() => _PlayerDetailScreenState();
}

class _PlayerDetailScreenState extends State<PlayerDetailScreen> {
  late Player _currentPlayer;

  @override
  void initState() {
    super.initState();
    _currentPlayer = widget.player;
  }

  // Refresca los datos del jugador desde Isar si hay cambios (ej. renovaciones)
  Future<void> _refreshPlayer() async {
    final updated = await widget.dbService.isar.players.get(_currentPlayer.id);
    if (updated != null && mounted) {
      setState(() {
        _currentPlayer = updated;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: Text(
          _currentPlayer.name.toUpperCase(), 
          style: _PlayerDetailStyles.appBarTitle
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // SECCIÓN SUPERIOR: GRÁFICO DE RADAR
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFDEFF9A).withValues(alpha: 0.02),
                      border: Border.all(color: const Color(0xFFDEFF9A).withValues(alpha: 0.05), width: 2),
                    ),
                  ),
                  SizedBox(
                    width: 260,
                    height: 260,
                    child: CustomPaint(
                      painter: PlayerRadarChartPainter(stats: _currentPlayer.stats),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            
            // TARJETA DE INFORMACIÓN HÍBRIDA
            _buildInfoCard(),
            
            const SizedBox(height: 10),
            
            // BOTONES DE ACCIÓN DINÁMICOS
            _buildActionButtons(context),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        children: [
          _rowInfo("Media Global", _currentPlayer.average.toStringAsFixed(1), isAverage: true),
          const Divider(color: Colors.white10, height: 30),
          
          _rowInfo("Posición", _currentPlayer.position),
          _rowInfo("Edad", "${_currentPlayer.age} Años"),
          _rowInfo("Personalidad", _currentPlayer.personality.name.toUpperCase()),
          
          const SizedBox(height: 15),
          const Divider(color: Colors.white10, height: 10),
          const SizedBox(height: 15),
          
          _rowInfo("Valor de Mercado", "${(_currentPlayer.marketValue / 1000000).toStringAsFixed(1)}M €"),
          _rowInfo("Ficha Anual", "${(_currentPlayer.salary / 1000).toStringAsFixed(0)}K €"),
          _rowInfo("Contrato", "${_currentPlayer.contractYearsRemaining} temporada(s)"),
          if (_currentPlayer.onLoanFromTeamApiId > 0)
            _rowInfo("Cesión", "Hasta jornada ${_currentPlayer.onLoanUntilMatchday}"),
          if (_currentPlayer.nationality.isNotEmpty) _rowInfo("Nacionalidad", _currentPlayer.nationality),
          if (_currentPlayer.age <= 20 && _currentPlayer.potential >= 88)
            _rowInfo("Perfil", "APUESTA DE FUTURO"),
          _rowInfo("Potencial", "${_currentPlayer.potential}"),
        ],
      ),
    );
  }

  Widget _rowInfo(String label, String value, {bool isAverage = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label.toUpperCase(), style: _PlayerDetailStyles.label),
          Text(value, style: isAverage ? _PlayerDetailStyles.valueAverage : _PlayerDetailStyles.value),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final isOurs = _currentPlayer.teamApiId == widget.userTeam.apiId && !_currentPlayer.isYouth;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          if (_currentPlayer.injuredDays > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'LESIONADO — ${_currentPlayer.injuredDays} días',
                style: _PlayerDetailStyles.injuryText,
              ),
            ),
          if (_currentPlayer.suspendedMatches > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'SANCIONADO — ${_currentPlayer.suspendedMatches} partido(s)',
                style: _PlayerDetailStyles.suspendedText,
              ),
            ),

          if (!isOurs) ...[
            // OPERACIÓN DE FICHAJE DE MERCADO EXTERNO
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDEFF9A),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 65),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TransferNegotiationScreen(
                      player: _currentPlayer,
                      userTeam: widget.userTeam,
                      dbService: widget.dbService,
                    ),
                  ),
                );
                _refreshPlayer();
              },
              child: Text("NEGOCIAR FICHAJE", style: _PlayerDetailStyles.buttonText),
            ),
          ] else ...[
            // PANEL DE GESTIÓN INTERNA DE NUESTRO PROPIO FUTBOLISTA
            // 1. RENOVAR CONTRATO
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDEFF9A),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              onPressed: () => _renewContractDialog(context),
              icon: const Icon(Icons.history_edu, size: 20),
              label: Text("RENOVAR CONTRATO", style: _PlayerDetailStyles.buttonTextSmall),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                // 2. CEDER JUGADOR
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white24),
                      minimumSize: const Size(0, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () => _loanPlayerDialog(context),
                    icon: const Icon(Icons.swap_horiz, size: 18),
                    label: const Text('CEDER', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ),
                const SizedBox(width: 12),
                
                // 3. DESPEDIR / RESCINDIR CONTRATO
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      side: const BorderSide(color: Colors.redAccent),
                      minimumSize: const Size(0, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () => _firePlayerDialog(context),
                    icon: const Icon(Icons.gavel, size: 18),
                    label: const Text('DESPEDIR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // Diálogo Interactiva para renovar el contrato del futbolista
  Future<void> _renewContractDialog(BuildContext context) async {
    int extraYears = 1;
    final double salaryProposal = _currentPlayer.salary * 1.10; // Incremento estándar por renovación

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF0F172A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('RENOVACIÓN DE PLANTILLA', style: _PlayerDetailStyles.dialogTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Propuesta de renovación para ${_currentPlayer.name}:', style: const TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Años adicionales:', style: TextStyle(color: Colors.white38)),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: Colors.white),
                        onPressed: extraYears > 1 ? () => setDialogState(() => extraYears--) : null,
                      ),
                      Text('$extraYears', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: Color(0xFFDEFF9A)),
                        onPressed: extraYears < 5 ? () => setDialogState(() => extraYears++) : null,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Nueva Ficha Anual:', style: TextStyle(color: Colors.white38)),
                  Text('${(salaryProposal / 1000).toStringAsFixed(0)}K €', style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('CANCELAR', style: TextStyle(color: Colors.white38))),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('FIRMAR RENOVACIÓN', style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );

    if (result != true || !mounted) return;

    // Ejecución transaccional en la BD de Isar
    await widget.dbService.isar.writeTxn(() async {
      _currentPlayer.contractYearsRemaining += extraYears;
      _currentPlayer.salary = salaryProposal;
      await widget.dbService.isar.players.put(_currentPlayer);
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_currentPlayer.name} ha renovado por $extraYears año(s) más.')),
      );
      _refreshPlayer();
    }
  }

  // Lógica y confirmación para Ceder al futbolista a préstamo
  Future<void> _loanPlayerDialog(BuildContext context) async {
    final double estimatedLoanFee = _currentPlayer.marketValue * 0.15; // Comisión de cesión típica

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F172A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('BUSCAR CESIÓN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text(
          '¿Deseas tramitar la cesión de ${_currentPlayer.name} hasta el final de la temporada actual?\n\nRecibirás una compensación inmediata de aproximadamente ${(estimatedLoanFee / 1000).toStringAsFixed(0)}K € y el club de destino asumirá la ficha.',
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('CANCELAR', style: TextStyle(color: Colors.white38))),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('BUSCAR DESTINO', style: TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (ok != true || !mounted) return;

    final msg = await FinanceService(widget.dbService.isar).sellPlayer(_currentPlayer, widget.userTeam.apiId);
    
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    if (msg.startsWith('Vendido') || msg.contains('cedido')) {
      Navigator.pop(context);
    }
  }

  // Despido fulminante pagando indemnización contractual de rescisión
  Future<void> _firePlayerDialog(BuildContext context) async {
    // Cálculo de la indemnización: Años de contrato pendientes x 75% del salario anual
    final double severancePay = _currentPlayer.contractYearsRemaining * (_currentPlayer.salary * 0.75);

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F172A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('CARTA DE DESPIDO', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
        content: Text(
          '¡ATENCIÓN!\n¿Estás seguro de que quieres rescindir el contrato de ${_currentPlayer.name}?\n\nLa indemnización por despido fulminante costará ${(severancePay / 1e6).toStringAsFixed(2)} M€ directos de tu presupuesto de finanzas.',
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('CANCELAR', style: TextStyle(color: Colors.white38))),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('DESPEDIR JUGADOR', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (ok != true || !mounted) return;

    // Procesamos la liquidación económica y la eliminación del equipo en Isar
    await widget.dbService.isar.writeTxn(() async {
      // 1. Modificamos el perfil o desvinculamos al jugador (libre/sin equipo)
      _currentPlayer.teamApiId = null;
      _currentPlayer.teamId = '';
      await widget.dbService.isar.players.put(_currentPlayer);
      
      // NOTA: Aquí puedes descontar `severancePay` de tu modelo de GameSave/Finanzas si tienes el método implementado
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_currentPlayer.name} ha rescindido su contrato y ya no pertenece al club.')),
      );
      Navigator.pop(context); // Volvemos a la pantalla de plantilla
    }
  }
}