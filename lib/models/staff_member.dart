enum StaffRole { secretario, preparador, medico, psicologo, juvenil }

class StaffMember {
  final String name;
  final StaffRole role;
  final int level; // 1 a 5 estrellas
  final double salary;
  final String description;

  StaffMember({
    required this.name,
    required this.role,
    required this.level,
    required this.salary,
    required this.description,
  });
}