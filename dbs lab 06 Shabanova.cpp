

#include <iostream>
#include <string>
#include <occi.h>

using oracle::occi::Environment;
using oracle::occi::Connection;
using namespace oracle::occi;
using namespace std;
void header(int num, const char* report);
void display(Number id, string firstname, string lastname, string phone, string ext);

int main(void) {
	Environment* env = nullptr;
	Connection* conn = nullptr;
	Statement* stmt = nullptr;
	ResultSet* rs = nullptr;

	string user = "dbs211_241zii30";
	string pass = "26384312";
	string srv = "myoracle12c.senecacollege.ca:1521/oracle12c";

	env = Environment::createEnvironment(Environment::DEFAULT);
	conn = env->createConnection(user, pass, srv);

	try {
		string sql_1 = "SELECT e.employeenumber, e.firstname, e.lastname, o.phone, e.extension From dbs211_employees e LEFT JOIN dbs211_offices o ON e.officecode = o.officecode WHERE o.city = 'San Francisco' ORDER BY e.employeenumber";

		stmt = conn->createStatement(sql_1);
		rs = stmt->executeQuery();

		header(1, "Employee Report");
		if (!rs->next()) {
			cout << "Empty Results!" << endl;
		}
		else {
			do {
				Number id = (int)rs->getNumber(1);
				string firstName = rs->getString(2);
				string lastName = rs->getString(3);
				string phone = rs->getString(4);
				string ext = rs->getString(5);
				display(id, firstName, lastName, phone, ext);
			} while (rs->next());
			cout << endl;
		}
	}
	catch (SQLException& sqlExcp) {
		cerr << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
	}

	try {
		string sql_2 = "SELECT DISTINCT m.employeenumber, m.firstname, m.lastname, o.phone, m.extension FROM dbs211_employees e INNER JOIN dbs211_employees m ON e.reportsto = m.employeenumber LEFT JOIN dbs211_offices o ON m.officecode = o.officecode ORDER BY employeenumber";

		stmt = conn->createStatement(sql_2);
		rs = stmt->executeQuery();

		header(2, "Manager Report");
		if (!rs->next()) {
			cout << "Empty Results!" << endl;
		}
		else {
			do {
				Number id = (int)rs->getNumber(1);
				string firstName = rs->getString(2);
				string lastName = rs->getString(3);
				string phone = rs->getString(4);
				string ext = rs->getString(5);
				display(id, firstName, lastName, phone, ext);
			} while (rs->next());
			cout << endl;
		}
	}
	catch (SQLException& sqlExcp) {
		cerr << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
	}

	conn->terminateStatement(stmt);
	env->terminateConnection(conn);
	Environment::terminateEnvironment(env);

	return 0;
}

void header(int num, const char* report) {
	cout.fill('-');
	cout.width(30);
	cout << "";
	cout << " Report " << num << " (" << report << ") ";
	cout.width(30);
	cout << "" << endl;
	cout.fill(' ');
	cout.setf(ios::left);
	cout.width(12);
	cout << "Employee ID" << "  ";
	cout.width(17);
	cout << "First Name" << "  ";
	cout.width(17);
	cout << "Last Name" << "  ";
	cout.width(16);
	cout << "Phone" << "  ";
	cout.width(10);
	cout << "Extension" << endl;
	cout.fill('-');
	cout.width(12);
	cout << "" << "  ";
	cout.width(17);
	cout << "" << "  ";
	cout.width(17);
	cout << "" << "  ";
	cout.width(16);
	cout << "" << "  ";
	cout.width(10);
	cout << "" << endl;
	cout.fill(' ');
}

void display(Number id, string firstname, string lastname, string phone, string ext) {
	cout.setf(ios::left);
	cout.width(12);
	cout << (int)id << "  ";
	cout.width(17);
	cout << firstname << "  ";
	cout.width(17);
	cout << lastname << "  ";
	cout.width(16);
	cout << phone << "  ";
	cout.width(10);
	cout << ext << endl;
}

//#include <iostream>
//#include <occi.h>
//
//using oracle::occi::Environment;
//using oracle::occi::Connection;
//using namespace oracle::occi;
//using namespace std;
//
//int main(void)
//{
//    /* OCCI Variables */
//    Environment* env = nullptr;
//    Connection* conn = nullptr;
//    /* Used Variables */
//    string user = "dbs211_241zii30";
//    string pass = "26384312";
//    string constr = "myoracle12c.senecacollege.ca:1521/oracle12c";
//    try {
//        env = Environment::createEnvironment(Environment::DEFAULT);
//        conn = env->createConnection(user, pass, constr);
//        cout << "Connection is Successful!" << endl;
//        env->terminateConnection(conn);
//        Environment::terminateEnvironment(env);
//    }
//    catch (SQLException& sqlExcp) {
//        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
//    }
//    return 0;
//}
