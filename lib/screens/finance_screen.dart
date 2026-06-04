import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/database_service.dart';
import '../models/finance_model.dart';
import '../models/team.dart';

class FinanceScreen extends StatefulWidget {
  final Team userTeam;
  final DatabaseService dbService;

  const FinanceScreen({
    super.key,
    required this.userTeam,
    required this.dbService,
  });

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final double _annualInterestRate = 0.10; // 10% de interés anual bancario

  @override
  Widget build(BuildContext context) {
    // Gastos proporcionales fijos basados en la plantilla estática
    final double wageBillBase = widget.userTeam.budget * 0.012; // 1.2% semanal base

    final financeInfo = widget.userTeam.expectations;

    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        title: Text(
          "FINANZAS Y GESTIÓN",
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: const Color(0xFFDEFF9A),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFFDEFF9A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<ClubFinance?>(
        // Escuchamos reactivamente la única instancia de finanzas del club (ID 1)
        stream: widget.dbService.isar.clubFinances.watchObject(1, fireImmediately: true),
        builder: (context, snapshot) {
          final finance = snapshot.data;
          if (finance == null) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFDEFF9A)),
            );
          }

          // Capacidad total sumando la ampliación de gradas desde la base de datos
          final int totalCapacity = widget.userTeam.stadiumCapacity + finance.stadiumExtraCapacity;

          // Cálculo del coste de mantenimiento dinámico del estadio
          final double maintenanceCost = totalCapacity * 1.5; 

          // Cálculo de la cuota fija del préstamo si existe deuda activa en Isar
          double weeklyLoanPayment = 0.0;
          if (finance.loanAmount > 0 && finance.loanWeeks > 0) {
            double totalInterest = finance.loanAmount * (_annualInterestRate * (finance.loanWeeks / 52));
            weeklyLoanPayment = (finance.loanAmount + totalInterest) / finance.loanWeeks;
          }

          // Proyección de ingresos de taquilla basada en el precio de las entradas guardado
          double attendanceFactor = (1.0 - (finance.ticketPrice - 15) / 120).clamp(0.4, 1.0);
          double estimatedAttendance = totalCapacity * attendanceFactor;
          double ticketIncome = estimatedAttendance * finance.ticketPrice;

          // Balance proyectado combinando los patrocinadores reales y amortizaciones
          double totalProjection = ticketIncome +
              finance.sponsorIncomePerMatch -
              wageBillBase -
              maintenanceCost -
              weeklyLoanPayment;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildClubHeader(widget.userTeam, totalCapacity),
                const SizedBox(height: 24),

                // SECCIÓN 1: BALANCE GENERAL (Datos reales desde ClubFinance)
                _sectionTitle("ESTADO DE CAJA"),
                _financeTile("Balance General", finance.balance, const Color(0xFFDEFF9A)),
                _financeTile("Presupuesto de Fichajes", finance.transferBudget, Colors.white),

                const SizedBox(height: 16),

                // SECCIÓN 2: GESTIÓN DE INGRESOS
                _sectionTitle("GESTIÓN DE INGRESOS"),
                _managementCard(
                  label: "Precio de Entrada",
                  value: "${finance.ticketPrice.toStringAsFixed(0)} €",
                  icon: Icons.confirmation_number_outlined,
                  onEdit: () => _showPriceSlider(finance),
                ),
                _managementCard(
                  label: "Ingreso por Vallas",
                  value: "+ ${(finance.sponsorIncomePerMatch / 1000).toStringAsFixed(0)}k € / part.",
                  icon: Icons.ad_units_outlined,
                  onEdit: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFF0F172A),
                        content: Text(
                          "Gestiona tus vallas desde el panel de Estadio",
                          style: GoogleFonts.urbanist(
                            color: const Color(0xFFDEFF9A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                // SECCIÓN 3: GESTIÓN DE CRÉDITOS Y DEUDA PERSISTENTE
                _sectionTitle("SOLICITUD DE CRÉDITOS"),
                _managementCard(
                  label: finance.loanAmount > 0 ? "Crédito Activo (Pendiente)" : "Financiación Bancaria",
                  value: finance.loanAmount > 0
                      ? "${(finance.loanAmount / 1000).toStringAsFixed(0)}k € (${finance.loanWeeks} sem.)"
                      : "Solicitar Crédito",
                  icon: Icons.account_balance_outlined,
                  onEdit: () => _showLoanDialog(finance),
                ),

                const SizedBox(height: 16),

                // SECCIÓN 4: GASTOS SEMANALES OPERATIVOS
                _sectionTitle("GASTOS SEMANALES OPERATIVOS"),
                _financeTile("Sueldos Plantilla (Base)", wageBillBase, Colors.orangeAccent, isSmall: true),
                _financeTile("Mant. Estadio", maintenanceCost, Colors.redAccent, isSmall: true),
                if (weeklyLoanPayment > 0)
                  _financeTile("Amortización Crédito", weeklyLoanPayment, Colors.red.shade300, isSmall: true),

                const SizedBox(height: 24),

                // PANEL DE BALANCE PROYECTADO
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: totalProjection >= 0
                        ? const Color(0xFF064E3B).withOpacity(0.3)
                        : const Color(0xFF7F1D1D).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: totalProjection >= 0
                          ? const Color(0xFF10B981).withOpacity(0.3)
                          : Colors.red.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "PROYECCIÓN PRÓXIMO PARTIDO EN CASA",
                        style: GoogleFonts.urbanist(
                          color: Colors.white60,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${totalProjection >= 0 ? '+' : ''}${(totalProjection / 1000).toStringAsFixed(1)}k €",
                        style: GoogleFonts.urbanist(
                          color: totalProjection >= 0 ? const Color(0xFFDEFF9A) : Colors.redAccent,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Asistencia: ${estimatedAttendance.toStringAsFixed(0)} espectadores (${(attendanceFactor * 100).toStringAsFixed(0)}% aforo)",
                        style: GoogleFonts.urbanist(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // SECCIÓN 5: OBJETIVOS DIRECTIVA
                _sectionTitle("EXIGENCIAS DE LA JUNTA"),
                _buildExpectationsCard(financeInfo),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildClubHeader(Team team, int dynamicCapacity) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Image.network(
            team.logoUrl,
            errorBuilder: (_, __, ___) => const Icon(Icons.shield, color: Colors.white24),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                team.name.toUpperCase(),
                style: GoogleFonts.urbanist(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
              ),
              Text(
                "Estadio: ${team.stadium} ($dynamicCapacity cap.)",
                style: GoogleFonts.urbanist(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10, top: 12),
      child: Text(
        title,
        style: GoogleFonts.urbanist(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.5),
      ),
    );
  }

  Widget _financeTile(String label, double value, Color color, {bool isSmall = false}) {
    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String mathFunc(Match match) => '${match[1]}.';
    String formattedValue = '${value.toInt().toString().replaceAllMapped(reg, mathFunc)} €';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: isSmall ? 14 : 18),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.urbanist(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
          ),
          Text(
            formattedValue,
            style: GoogleFonts.urbanist(color: color, fontSize: isSmall ? 16 : 20, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  Widget _managementCard({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onEdit,
  }) {
    return GestureDetector(
      onTap: onEdit,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFDEFF9A).withOpacity(0.15)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFDEFF9A), size: 24),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.urbanist(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.urbanist(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.edit_note_rounded, color: Colors.white30, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildExpectationsCard(Map<String, String> info) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.01),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.flag_rounded, color: Color(0xFFDEFF9A), size: 16),
              const SizedBox(width: 8),
              Text(
                "OBJETIVO: ",
                style: GoogleFonts.urbanist(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: Text(
                  info["objetivo"]!,
                  style: GoogleFonts.urbanist(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.bolt_rounded, color: Colors.orangeAccent, size: 16),
              const SizedBox(width: 8),
              Text(
                "EXIGENCIA: ",
                style: GoogleFonts.urbanist(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: Text(
                  info["exigencia"]!,
                  style: GoogleFonts.urbanist(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPriceSlider(ClubFinance finance) {
    double tempPrice = finance.ticketPrice;
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(2)),
              ),
              Text(
                "TAQUILLA Y BOLETERÍA",
                style: GoogleFonts.urbanist(color: Colors.white54, fontWeight: FontWeight.w800, fontSize: 11, letterSpacing: 1.5),
              ),
              const SizedBox(height: 8),
              Text(
                "${tempPrice.toStringAsFixed(0)} €",
                style: GoogleFonts.urbanist(color: const Color(0xFFDEFF9A), fontSize: 36, fontWeight: FontWeight.w900),
              ),
              Slider(
                value: tempPrice,
                min: 10,
                max: 150,
                divisions: 28,
                activeColor: const Color(0xFFDEFF9A),
                inactiveColor: Colors.white10,
                onChanged: (val) => setModalState(() => tempPrice = val),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDEFF9A),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  onPressed: () async {
                    finance.ticketPrice = tempPrice;
                    await widget.dbService.isar.writeTxn(() => widget.dbService.isar.clubFinances.put(finance));
                    if (!mounted) return;
                    Navigator.pop(context);
                  },
                  child: Text(
                    "ESTABLECER PRECIO",
                    style: GoogleFonts.urbanist(fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showLoanDialog(ClubFinance finance) {
    double selectedLoan = 1000000.0; 
    int selectedWeeks = 20; 

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          double totalInterest = selectedLoan * (_annualInterestRate * (selectedWeeks / 52));
          double estimatedWeeklyPayment = (selectedLoan + totalInterest) / selectedWeeks;

          return Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(2)),
                ),
                Text(
                  "CRÉDITO Y FINANCIACIÓN",
                  style: GoogleFonts.urbanist(color: Colors.white54, fontWeight: FontWeight.w800, fontSize: 11, letterSpacing: 1.5),
                ),
                const SizedBox(height: 16),
                if (finance.loanAmount > 0) ...[
                  Text(
                    "Tienes un préstamo activo.",
                    style: GoogleFonts.urbanist(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Debes liquidar las cuotas restantes de ${(finance.loanAmount / 1000).toStringAsFixed(0)}k € antes de solicitar otro.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(color: Colors.white60, fontSize: 12),
                  ),
                  const SizedBox(height: 24),
                ] else ...[
                  Text(
                    "${(selectedLoan / 1000000).toStringAsFixed(1)} M €",
                    style: GoogleFonts.urbanist(color: const Color(0xFFDEFF9A), fontSize: 32, fontWeight: FontWeight.w900),
                  ),
                  Slider(
                    value: selectedLoan,
                    min: 500000,
                    max: 10000000,
                    divisions: 19, 
                    activeColor: const Color(0xFFDEFF9A),
                    inactiveColor: Colors.white10,
                    onChanged: (val) => setModalState(() => selectedLoan = val),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Plazo de Devolución: $selectedWeeks Semanas",
                    style: GoogleFonts.urbanist(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    value: selectedWeeks.toDouble(),
                    min: 10,
                    max: 50,
                    divisions: 4, 
                    activeColor: Colors.orangeAccent,
                    inactiveColor: Colors.white10,
                    onChanged: (val) => setModalState(() => selectedWeeks = val.toInt()),
                  ),
                  const Divider(color: Colors.white10, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Interés Anual:", style: GoogleFonts.urbanist(color: Colors.white38, fontSize: 13)),
                      Text("${(_annualInterestRate * 100).toStringAsFixed(0)}%",
                          style: GoogleFonts.urbanist(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Cuota Semanal Estimada:", style: GoogleFonts.urbanist(color: Colors.white38, fontSize: 13)),
                      Text("${estimatedWeeklyPayment.toStringAsFixed(0)} €",
                          style: GoogleFonts.urbanist(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDEFF9A),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        // Inyectamos el capital concedido al balance de operaciones del club
                        finance.balance += selectedLoan;
                        finance.loanAmount = selectedLoan;
                        finance.loanWeeks = selectedWeeks;

                        await widget.dbService.isar.writeTxn(() => widget.dbService.isar.clubFinances.put(finance));
                        
                        if (!mounted) return;
                        Navigator.pop(context);
                      },
                      child: Text(
                        "FIRMAR CRÉDITO BANCARIO",
                        style: GoogleFonts.urbanist(fontWeight: FontWeight.w900, letterSpacing: 1),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}