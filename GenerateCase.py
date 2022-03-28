# Get modules to generate the time of the investigation start
from datetime import datetime

class GenerateCase:

    # Init the class with the case number and who
    # is handeling the case.
    # Generate a starttime with datetime module
    def __init__(self, caseNr, handler):
        self.caseNumber = caseNr
        self.handler = handler

        # Set time for when the investigation started
        self.investigationStart = datetime.now()

    # Return a table with the class information
    def getCaseTable(self):

        caseTable = [self.caseNumber, str(self.investigationStart), self.handler]
        return caseTable

    # Return the case number
    def getCaseNumber(self):

        return self.caseNumber

