/// Dart import
import 'dart:math' as math;

/// Packages import
import 'package:flutter/material.dart';

/// DataGrid import
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/team.dart';

/// Set team's data collection to data grid source.
class TeamDataGridSource extends DataGridSource {
  /// Creates the team data source class with required details.
  TeamDataGridSource() {
    _teams = _getTeams(_teamNames.length);
    buildDataGridRows();
  }

  List<Team> _teams = <Team>[];

  List<DataGridRow> _dataGridRows = <DataGridRow>[];

  /// Building DataGridRows
  void buildDataGridRows() {
    _dataGridRows = _teams.map<DataGridRow>((Team team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<Image>(columnName: 'image', value: team.image),
        DataGridCell<String>(columnName: 'team', value: team.team),
        DataGridCell<int>(columnName: 'wins', value: team.wins),
        DataGridCell<int>(columnName: 'losses', value: team.losses),
        DataGridCell<double>(columnName: 'pct', value: team.winPercentage),
        DataGridCell<double>(columnName: 'gb', value: team.gamesBehind),
      ]);
    }).toList();
  }

  // Overrides
  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: <Widget>[
      Container(
        padding: const EdgeInsets.all(8.0),
        child: row.getCells()[0].value,
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          row.getCells()[1].value.toString(),
          softWrap: true,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[4].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[5].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }

  // Team data's
  final List<String> _teamNames = <String>[
    'Denver',
    'Charllote',
    'Memphis',
    'New York',
    'Detroit',
    'L.A Lakers',
    'Miami',
    'Orlando',
    'L.A Clippers',
    'San Francisco',
    'Dallas',
    'Milwaukke',
    'Oklahoma',
    'Cleveland',
  ];

  final List<Image> _teamLogos = <Image>[
    Image.asset('images/DenverNuggets.png'),
    Image.asset('images/Hornets.png'),
    Image.asset('images/Memphis.png'),
    Image.asset('images/NewYork.png'),
    Image.asset('images/DetroitPistons.png'),
    Image.asset('images/LosAngeles.png'),
    Image.asset('images/Miami.png'),
    Image.asset('images/Orlando.png'),
    Image.asset('images/Clippers.png'),
    Image.asset('images/GoldenState.png'),
    Image.asset('images/Mavericks.png'),
    Image.asset('images/Milwakke.png'),
    Image.asset('images/Thunder_Logo.png'),
    Image.asset('images/Cavaliers.png'),
  ];

  final List<double> _gb = <double>[
    0,
    10,
    15.5,
    15.5,
    40.5,
    0,
    2,
    3,
    14.5,
    19,
    0,
    20,
    24.5,
    28.5,
    31,
    16.6,
    10.3
  ];
  final List<int> _wins = <int>[
    93,
    82,
    76,
    77,
    52,
    84,
    82,
    81,
    70,
    65,
    97,
    77,
    72,
    68,
    66,
    23,
    45
  ];
  final List<double> _pct = <double>[
    .616,
    .550,
    .514,
    .513,
    .347,
    .560,
    .547,
    .540,
    .464,
    .433,
    .642,
    .510,
    .480,
    .453,
    .437,
    .567,
    .345
  ];
  final List<int> _losses = <int>[
    58,
    67,
    72,
    73,
    98,
    66,
    68,
    69,
    81,
    85,
    54,
    74,
    78,
    82,
    85,
    68,
    78
  ];

  List<Team> _getTeams(int count) {
    final List<Team> teamData = <Team>[];
    for (int i = 0; i < count; i++) {
      teamData.add(Team(
        _teamNames[i],
        _pct[i],
        _gb[i],
        _wins[i],
        _losses[i],
        _teamLogos[i],
      ));
    }
    return teamData;
  }
}

/// Set employee's data collection to data grid source.
class EmployeeDataGridSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataGridSource() {
    _employees = _getEmployees(3);
    buildDataGridRows();
  }

  final math.Random _random = math.Random();
  List<DataGridRow> _dataGridRows = <DataGridRow>[];
  List<Employee> _employees = <Employee>[];

  /// Building DataGridRows
  void buildDataGridRows() {
    _dataGridRows = _employees.map<DataGridRow>((Employee employee) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(
            columnName: 'collector', value: employee.employeeName),
        DataGridCell<String>(
            columnName: 'designation', value: employee.designation),
        DataGridCell<String>(columnName: 'mail', value: employee.mail),
        DataGridCell<String>(columnName: 'location', value: employee.location),
        DataGridCell<String>(columnName: 'status', value: employee.status),
        DataGridCell<String>(columnName: 'accuracy', value: employee.accuracy),
        DataGridCell<String>(
            columnName: 'biodiversity', value: employee.biodiversity),
        DataGridCell<String>(columnName: 'altitude', value: employee.altitude),
      ]);
    }).toList();
  }

  // Overrides
  @override
  List<DataGridRow> get rows => _dataGridRows;

  Widget _buildEmployeeName(dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: _getWidget(
          Icon(Icons.account_circle, size: 30, color: Colors.blue[300]), value),
    );
  }

  Widget _buildLocation(dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: _getWidget(const Icon(Icons.location_on, size: 20), value),
    );
  }

  Widget _buildTrustWorthiness(String value) {
    final String trust = value;
    if (value == 'Perfect') {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: _getWidget(_images[trust]!, trust),
      );
    } else if (value == 'Insufficient') {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: _getWidget(_images[trust]!, trust),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: _getWidget(_images[trust]!, trust),
      );
    }
  }

  Widget _buildSoftwareProficiency(String value) {
    Widget getLinearProgressBar(double progressValue) {
      return SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 50,
                child: LinearProgressIndicator(
                  value: progressValue / 100,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      progressValue < 50 ? Colors.red : Colors.green),
                  backgroundColor:
                      progressValue < 50 ? Colors.red[100] : Colors.green[100],
                )),
            Text(' ' + (progressValue.toString() + '%')),
          ],
        ),
      );
    }

    return getLinearProgressBar(double.parse(value));
  }

  Widget _getWidget(Widget image, String text) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          Container(
            child: image,
          ),
          const SizedBox(width: 6),
          Expanded(
              child: Text(
            text,
            overflow: TextOverflow.ellipsis,
          ))
        ],
      ),
    );
  }

  TextStyle _getStatusTextStyle(dynamic value) {
    if (value == 'Done') {
      return const TextStyle(color: Colors.green);
    } else {
      return TextStyle(color: Colors.red[500]);
    }
  }

  final Map<String, Image> _images = <String, Image>{
    'Perfect': Image.asset('images/Perfect.png'),
    'Insufficient': Image.asset('images/Insufficient.png'),
    'Sufficient': Image.asset('images/Sufficient.png'),
  };

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: <Widget>[
      _buildEmployeeName(row.getCells()[0].value),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Text(row.getCells()[1].value.toString()),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Text(row.getCells()[2].value.toString()),
      ),
      _buildLocation(row.getCells()[3].value),
      Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(
            row.getCells()[4].value.toString(),
            style: _getStatusTextStyle(row.getCells()[4].value),
          )),
      //_buildTrustWorthiness(row.getCells()[5].value.toString()),
      _buildSoftwareProficiency(row.getCells()[5].value),

      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Text(row.getCells()[6].value),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Text(row.getCells()[7].value),
      ),
    ]);
  }

  // Employee Data's
  final List<String> _employeeNames = <String>[
    'Aaron',
    'Kelvin',
    'Sherryl',
  ];
  final List<String> _addresses = <String>[
    '59 rue de lAbbaye',
    'Luisenstr. 48',
    'Rua do Paço 67',
  ];
  final List<String> _designations = <String>[
    'Designer',
    'Manager',
    'Developer',
    'Project Lead',
    'Program Director',
    'System Analyst',
    'CFO'
  ];
  final List<String> _mails = <String>[
    'dkut.ac.ke',
    'marmanet.com',
    'inventory.com',
    'admin.com'
  ];
  final List<String> _status = <String>['Done', 'In Progress'];
  final List<String> _trusts = <String>[
    'Sufficient',
    'Perfect',
    'Insufficient'
  ];
  final List<String> _locations = <String>[
    'Marmanet',
  ];
  final List<String> _diversities = <String>[
    'Grass',
    'Trees',
    'Shrub',
  ];

  List<Employee> _getEmployees(int count) {
    final List<Employee> employeeData = <Employee>[];
    for (int i = 0; i < _employeeNames.length - 1; i++) {
      employeeData.add(Employee(
          _employeeNames[i],
          _designations[_random.nextInt(_designations.length - 1)],
          _employeeNames[i].toLowerCase() +
              '@' +
              _mails[_random.nextInt(_mails.length - 1)],
          _locations[0],
          _status[_random.nextInt(_status.length)],
          _trusts[_random.nextInt(_trusts.length - 1)],
          (20 + _random.nextInt(80)).toString(),
          (20 + _random.nextInt(80)).toString(),
          _diversities[_random.nextInt(_diversities.length)]));
    }
    return employeeData;
  }
}
