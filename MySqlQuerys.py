# Import predefined

import mysql.connector
from mysql.connector import Error
import sys
from simple_term_menu import TerminalMenu

# Classes imported from the same directory
from FileData import FileData
from GenerateCase import GenerateCase
from ShodanLib import ShodanLib

class MySqlProgram:

    def __init__(self, user, password, database):
        # The parameters are used for the function which connects to the database.
        # Last a cursor object is created to interact with the database.

        self.__connectDB(user, password, database)
        self.cursor = self.connect.cursor()

    def __connectDB(self, userName, passwd, db):
        # This function connects to the database.
        # First it initalizes the self.connect to None
        # Then it trys to create a connection object
        # with database name and user and password
        # which where passed from the calle.
        # If it fails it will exit and print and error message.

        self.connect = None

        try:
            self.connect = mysql.connector.connect(
                    database=db,
                    user=userName,
                    password=passwd,
                    host = "localhost"
                    )
            if (self.connect.is_connected()):
                print("\n#####################################\n")
                print("Database is connected")
                print("\n#####################################\n")

        except Error as e:
            print(e)
            sys.exit(2)

    def createTable(self, tableCommand):
        # This function creates a table or a view by using the command given as an arugment
        # Then it ocmmits the change.
        # If it fails it prints an error and exits.

        try:
            self.cursor.execute(tableCommand)
            self.connect.commit()
        except Error as e:
            print(e)
            sys.exit(3)

    def __storeDataInDb(self, tableCommand, args):
        # This function executes a jobb aginst the database with arguments and command.

        try:
            self.cursor.execute(tableCommand, args)
            print("Data commited.")
        except Error as e:
            print(e)

    def insertCaseIntoDb(self, caseData):
        # # This function first creates variables with insert commands
        # Then it executes it.

        print("\n#####################################\n")
        print("Inserting Case data into Investigation Table.")
        query = "INSERT INTO Investigation(CaseNumber,InvestigationStart,Handler)" \
                "VALUES(%s, %s, %s)"

        self.__storeDataInDb(query, caseData)
        self.connect.commit()
        print("\n#####################################\n")

    def insertFileIntoDb(self, fileData):
        # # This function first creates variables with insert commands
        # Then it executes it.

        print("\n#####################################\n")
        print("Inserting File data into File Table.")
        query = "INSERT INTO File(Hash, FileName, CaseNumber)" \
                "VALUES(%s, %s, %s)"

        self.__storeDataInDb(query, fileData)
        self.connect.commit()
        print("\n#####################################\n")


    def insertIpIntoDb(self, ipData):
        # # This function first creates variables with insert commands
        # Then it executes it.

        print("\n#####################################\n")
        print("Inserting IP Address data into IP_Address Table.")
        query = "INSERT INTO IP_Address(IP_ID, IP, DomainName, Ports, CountryCode, GeoData)" \
                "VALUES(%s, %s, %s, %s, %s, %s)"

        self.__storeDataInDb(query, ipData)
        self.connect.commit()
        print("\n#####################################\n")

    def insertJunctionBetweenIPFileDb(self, relationData):
        # # This function first creates variables with insert commands
        # Then it executes it.

        print("\n#####################################\n")
        print("Creating a relation between File table and the IP table.")
        query = "INSERT INTO FileIpRelation(Hash, IP_ID)" \
                "VALUES(%s, %s)"

        self.__storeDataInDb(query, relationData)
        self.connect.commit()
        print("\n#####################################\n")

    def query1(self, ip):
        # This function querys the database for a specific IP address and it's IDs
        # Then it fetchesall into a result which iwll be a tuple which is then printed out
        query = "SELECT FileName, IP, IP_Address.IP_ID FROM File, IP_Address, FileIpRelation WHERE IP = %s AND FileIpRelation.IP_ID = IP_Address.IP_ID  AND File.Hash = FileIpRelation.Hash"

        self.cursor.execute(query, (ip,))

        result = self.cursor.fetchall()

        print("\n#####################################\n")
        for i in result:
            print("FileName: " + i[0] + ", IP: " + i[1] + "ID: " + i[2])

        print("\n#####################################\n")

    def query2(self, serchedHash):
        # This function seraches for a specific hash and prints out the casenubmer and the fiels realted.
        # Then it fetchesall into a result which iwll be a tuple which is then printed out

        query = "SELECT Investigation.CaseNumber, FileName FROM Investigation, File WHERE File.Hash = %s AND File.CaseNumber = Investigation.CaseNumber"
        self.cursor.execute(query, (serchedHash,))

        result = self.cursor.fetchall()

        print("\n#####################################\n")
        for i in result:
            print("CaseNumber: " + str(i[0]) + ", FileName: " + i[1])
        print("\n#####################################\n")


    def query3(self):
        # This function querys all investigations and joins theam with the file table based on Hashes
        # Then it fetchesall into a result which will be a tuple which is then printed out

        query = "SELECT Investigation.CaseNumber, FileName FROM Investigation JOIN File on File.CaseNumber = Investigation.CaseNumber"

        self.cursor.execute(query)

        result = self.cursor.fetchall()

        print("\n#####################################\n")
        for i in result:
            print("\nCaseNumber: " + str(i[0]) + ", FileName: " + i[1])
        print("\n#####################################\n")

    def query4(self, caseNumber):
        # This function counts the amount of diffrent files analyzed by a chase.
        # Then it fetchesall into a result which iwll be a tuple which is then printed out

        query = "SELECT COUNT(File.Hash) FROM File, Investigation WHERE File.CaseNumber = %s AND Investigation.CaseNumber = %s"

        self.cursor.execute(query, (caseNumber,caseNumber))

        result = self.cursor.fetchall()

        print("\n#####################################\n")
        print("CaseNumber: " + str(caseNumber))
        print("Count: " + str(result[0][0]))
        print("\n#####################################\n")

    def query5(self):
        # This function querys a specific view which returns all investigation details for all investigations.
        # Then it fetchesall into a result which iwll be a tuple which is then printed out

        query = "SELECT * FROM InvestigationDetails"

        self.cursor.execute(query)

        result = self.cursor.fetchall()

        print("\n#####################################\n")
        for i in result:
            print("\nCaseNumber: " + str(i[0]) + ", FileName: " + i[1] + ", Hash: " + i[2])
            print("IP: " + i[3] + ", DomainName:" + i[4] + ", Ports: " + i[5])
        print("\n#####################################\n")


    def handleClose(self):
        # This function closes the connection and cursor of the database.

        try:
            self.cursor.close()
            self.connect.close()
            print("\n#####################################\n")
            print("Database closed")
            print("\n#####################################\n")
        except Error as e:
            print(e)
            exit(5)

def main():
    # This function executes a insert to the database or creates tables.
    # This depndes on what is uncommented.
    # Uncomment createTable function to create tabes.
    # Otherwise uncomment what is below to execute inserts of data
    # which is given as an argument to the function in the terminal.

    if (len(sys.argv) < 3):
        print("Usage: %s <Username> <password> <database name>")
        sys.exit(1)

    # Create tables and junction tables for many to many relationship
    sqlTableCase = '''CREATE TABLE Investigation (
    CaseNumber BIGINT NOT NULL PRIMARY KEY,
    investigationStart DATETIME NOT NULL,
    Handler nvarchar(128) NOT NULL
    )
    '''

    sqlTableFile = '''CREATE TABLE File (
    Hash nvarchar(128) NOT NULL PRIMARY KEY,
    FileName nvarchar(500) NOT NULL,
    CaseNumber BIGINT,
    FOREIGN KEY (CaseNumber) REFERENCES Investigation(CaseNumber)
    )
    '''
 
    sqlJunctionTableFileIp = ''' CREATE TABLE FileIpRelation (
    Hash nvarchar(128) NOT NULL,
    IP_ID nvarchar(128) NOT NULL,
    FOREIGN KEY (Hash) REFERENCES File(Hash),
    FOREIGN KEY (IP_ID) REFERENCES IP_Address(IP_ID),
    UNIQUE (HASH, IP_ID)
    )
    '''

    sqlTableIP_Address = '''CREATE TABLE IP_Address(
    IP_ID nvarchar(128) NOT NULL PRIMARY KEY,
    IP nvarchar(32),
    DomainName nvarchar(500),
    Ports nvarchar(4000),
    CountryCode nvarchar(10),
    GeoData nvarchar(500)
    )
    '''

    # Create a specific view
    sqlTableView = ''' CREATE VIEW InvestigationDetails AS 
    SELECT Investigation.CaseNumber, FileName, File.Hash, IP, DomainName, Ports FROM Investigation 
    JOIN File on File.CaseNumber = Investigation.CaseNumber
    JOIN FileIpRelation on File.Hash = FileIpRelation.Hash
    JOIN IP_Address on IP_Address.IP_ID = FileIpRelation.IP_ID
    '''

    # Connect to the database
    database = MySqlProgram(sys.argv[1], sys.argv[2], sys.argv[3])

    # Loop variable for terminal and the menu choices for the terminal
    loop = True
    terminal_menu = TerminalMenu([
        "[A]. Create tables and views",
        "[B]. Create Case",
        "[C]. Read file data",
        "[D]. Read related IP address",
        "[E]. Add Case data",
        "[F]. Add File",
        "[G]. Add IP data",
        "[H]. Create relationship between File data and IP Data",
        "[I]. Query for files accoicted with specific IP address",
        "[J]. Query for a file that is associated with a specific investigation",
        "[K]. Query for a join table of case numbers, file names and the hashes",
        "[L]. Query for a count on how many files are investigated by a specific case",
        "[M]. Query for data in every case and present it in rows",
        "[N]. Exit"]
        )

    # Loop will iterate untill exit
    # it prints through the TerminalMenu modules and depnding on the choice
    # executes specific functions under that choice
    while loop:
        choice = terminal_menu.show()

        if(choice == 0):
            print("\n#####################################\n")
            
            # Create tables
            print("Creating Investigation, File, IP_Address table")
            #database.createTable(sqlTableCase)
            #database.createTable(sqlTableFile)
            #database.createTable(sqlTableIP_Address)
            
            # Creates forgien keys
            # Create junction tables for many to many relationship
            print("Creating bridge table FileIpRelation between File and IP_Address table")
            ##database.createTable(sqlJunctionTableFileIp)
            
            # Create view
            print("Creating View InvestigationDetails")
            database.createTable(sqlTableView)
            print("\n#####################################\n")
        elif(choice == 1):
            # Adds case data
            caseNumber = input("Give case number: ")
            caseHandler = input("Give handler name: ")
            case = GenerateCase(caseNumber, caseHandler)
        elif(choice == 2):
            # Adds file data
            fileName = input("Give filename: ")
            filePath = input("Give filepath: ")
            fData = FileData(fileName, filePath)
        elif(choice == 3):
            # Adds IP information
            ip = input("Give IPv4 address to input: ")
            shodanInfo = ShodanLib()
            shodanInfo.ipInfo(ip)
            shodanInfo.generateId()
        elif(choice == 4):
            # Insert data into the table for Investigation
            database.insertCaseIntoDb(case.getCaseTable())
        elif(choice == 5):
            # Insert data into the table for File
            fileTable = fData.getFileTable()
            fileTable.append(case.getCaseNumber())
            database.insertFileIntoDb(fileTable)
        elif(choice == 6):
            # Insert data into the table for IP_Address
            database.insertIpIntoDb(shodanInfo.getIpTable())
        elif(choice == 7):
            # Insert the relation between a file and an IP Address
            relation = [fData.getHash(), shodanInfo.getIpId()]
            database.insertJunctionBetweenIPFileDb(relation)
        elif(choice == 8):
            # Querys for specific IP and IP
            ip = input("IP to be searched for: ")
            database.query1(ip)
        elif(choice == 9):
            # Query for specific hash
            searchForHash = input("Input Sha256 hash to search for: ")
            database.query2(searchForHash)
        elif(choice == 10):
            # Query a join that writes out Case and file information
            database.query3()
        elif(choice == 11):
            # Writes out files realted to specific case
            caseNr = input("Choose casenumber to search for: ")
            database.query4(caseNr)
        elif(choice == 12):
            # Writes out the view for all investigations
            database.query5()
        elif(choice == 13):
            # Exits the loop
            loop = False
        else:
            # If wrong input is given print out an error message
            print("\n#####################################\n")
            print("\n Wrong input try again. \n")
            print("\n#####################################\n")

    # Close the connection to the database
    database.handleClose()

# Executes if this program is executed directly from the terminal
if (__name__ == "__main__"):
    main()
