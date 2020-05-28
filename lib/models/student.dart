//This is the original class for model Student
class Student {
  int _studentId;
  String _studentName;
  String _studentAge;
  String _studentEmail;
  String _studentClass;
  String _studentAddress;

  Student(this._studentId, this._studentName, this._studentAge,
      this._studentEmail, this._studentClass, this._studentAddress);

  int get studentId => _studentId;
  String get studentName => _studentName;
  String get studentAge => _studentAge;
  String get studentEmail => _studentEmail;
  String get studentClass => _studentClass;
  String get studentAddress => _studentAddress;

  set studentId(int newStudentId) {
    this._studentId = newStudentId;
  }

  set studentName(String newStudentName) {
    this.studentName = newStudentName;
  }

  set studentAge(String newStudentAge) {
    this._studentAge = newStudentAge;
  }

  set studentEmail(String newStudentEmail) {
    this._studentEmail = newStudentEmail;
  }

  set studentClass(String newStudentClass) {
    this._studentClass = newStudentClass;
  }

  set studentAddress(String newStudentAddress) {
    this._studentAddress = newStudentAddress;
  }
}
