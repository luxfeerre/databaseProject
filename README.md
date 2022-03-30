# databaseProject
This is a project for a Database Theoiry course.

It contains 4 files which are:
FileData.py which is used to read in file data and ceate the information for the File table.

GenerateCase.py which is used to read case data from the keyboard and greate information for the Investigation table.
ShodanLib.py is used to generate the data for the IP_Address table. This needs a api key which can be obtained by registering on Shodan.io.
MySqlQuery.py is the application to run the program atm. Here the menu is defiend and the tables and views can be created for the database.
Then it can generate the foreigen keys and created case data, file data and Ip data for the tables.
Then this data can be inserted by first puting data into the IP_Address table, the File table, last the Case table to avoid dangeling keys.

A video demonstrating this can be found here:
https://www.youtube.com/watch?v=HLA8B6Wjk5o
