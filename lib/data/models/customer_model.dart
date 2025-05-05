class Customer {
  final int id;
  final bool notFound;
  final String companyName;
  final String clientCode;
  final String customerName;
  final String customerSurname;
  final String cell;
  final String email;
  final String address;
  final List<Machine> machines;
  final List<QuickSupport> quickSupports;
  final List<Ticket> tickets;
  final List<Machine> machinesPurchased;
  final List<Notification> notifications;
  final List<dynamic> training;

  Customer({
    required this.id,
    required this.notFound,
    required this.companyName,
    required this.clientCode,
    required this.customerName,
    required this.customerSurname,
    required this.cell,
    required this.email,
    required this.address,
    required this.machines,
    required this.quickSupports,
    required this.tickets,
    required this.machinesPurchased,
    required this.notifications,
    required this.training,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['Id'] as int,
      notFound: json['NotFound'] as bool,
      companyName: json['CompanyName'] as String,
      clientCode: json['ClientCode'] as String,
      customerName: json['CustomerName'] as String,
      customerSurname: json['CustomerSurname'] as String,
      cell: json['Cell'] as String,
      email: json['Email'] as String,
      address: json['Address'] as String,
      machines: (json['Machines'] as List<dynamic>)
          .map((machineJson) => Machine.fromJson(machineJson as Map<String, dynamic>))
          .toList(),
      quickSupports: (json['QuickSupports'] as List<dynamic>)
          .map((supportJson) => QuickSupport.fromJson(supportJson as Map<String, dynamic>))
          .toList(),
      tickets: (json['Tickets'] as List<dynamic>)
          .map((ticketJson) => Ticket.fromJson(ticketJson as Map<String, dynamic>))
          .toList(),
      machinesPurchased: (json['MachinesPurchased'] as List<dynamic>)
          .map((machineJson) => 
              machineJson is Map<String, dynamic> 
                  ? Machine.fromJson(machineJson) 
                  : Machine(machineId: 0, machineName: 'Unknown'))
          .toList(),
      notifications: (json['Notifications'] as List<dynamic>)
          .map((notifJson) => Notification.fromJson(notifJson as Map<String, dynamic>))
          .toList(),
      training: json['Training'] as List<dynamic>? ?? [],
    );
  }
}

class Machine {
  final int machineId;
  final String machineName;
  final String? installDate;
  final String? salesPerson;
  final String? warranty;

  Machine({
    required this.machineId,
    required this.machineName,
    this.installDate,
    this.salesPerson,
    this.warranty,
  });

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      machineId: json['MachineId'] as int,
      machineName: json['MachineName'] as String,
      installDate: json['InstallDate'] as String?,
      salesPerson: json['SalesPerson'] as String?,
      warranty: json['Warranty'] as String?,
    );
  }
}

class QuickSupport {
  final int machineId;
  final String machineName;
  final String date;
  final String issue;
  final String? solution;
  final String takenBy;

  QuickSupport({
    required this.machineId,
    required this.machineName,
    required this.date,
    required this.issue,
    this.solution,
    required this.takenBy,
  });

  factory QuickSupport.fromJson(Map<String, dynamic> json) {
    return QuickSupport(
      machineId: json['MachineId'] as int,
      machineName: json['MachineName'] as String,
      date: json['Date'] as String,
      issue: json['Issue'] as String,
      solution: json['Solution'] as String?,
      takenBy: json['TakenBy'] as String,
    );
  }
}

class Ticket {
  final int machineId;
  final String machineName;
  final String date;
  final String fault;
  final String status;

  Ticket({
    required this.machineId,
    required this.machineName,
    required this.date,
    required this.fault,
    required this.status,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      machineId: json['MachineId'] as int,
      machineName: json['MachineName'] as String,
      date: json['Date'] as String,
      fault: json['Fault'] as String,
      status: json['Status'] as String,
    );
  }
}

class Notification {
  final String note;
  final String dateTime;
  final String addedBy;

  Notification({
    required this.note,
    required this.dateTime,
    required this.addedBy,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      note: json['Note'] as String,
      dateTime: json['DateTime'] as String,
      addedBy: json['AddedBy'] as String,
    );
  }
} 