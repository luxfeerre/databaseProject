# databaseProject
This is a project for a Database Theoiry course.

It contains 4 files which are:
FileData.py which is used to read in file data and ceate the information for the File table.

GenerateCase.py which is used to read case data from the keyboard and greate information for the Investigation table.
ShodanLib.py is used to generate the data for the IP_Address table. This needs a api key which can be obtained by registering on Shodan.io.
MySqlQuery.py is the application to run the program atm. Here the menu is defiend and the tables and views can be created for the database.
Then it can generate the foreigen keys and created case data, file data and Ip data for the tables.
Then this data can be inserted by first puting data into the IP_Address table, the File table, last the Case table to avoid dangeling keys.

Then there are five querys which are:
Get fiels accoicated with speicific IP_Table by inputing IP address and the specific ID for the table.
Get file names that are accoicated with specific investigations by inputing a sha256 hash.
Then there is a SQL JOIB statment that searches for specific cases releated to specific hashes and joins the tables.
Then there is an aggreation that counts how many times a specific IP address has been related to specific files.
Last a View is defined called InvestigationDetails that can be selected from in the last Query.
The information here is FileName, File hashes, IP addresses realted to a specific CaseNumber and realted Files tables and IP_Address tables.

A video demonstrating this can be found here:
