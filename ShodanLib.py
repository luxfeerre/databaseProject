
# Import the shodan python API to get info on IP addresses
# hashlib to generate a uniqe id for an IP address
from shodan import Shodan
import hashlib
# To handle Errors
import sys

class ShodanLib:

    # Initalize the Shodan API
    def __init__(self):
        self.api = Shodan('j5xP0muNB0N3gG4fo8MenaJCaCZO4Bzd')

    # Query Shodan for a specific Ip and store it in a dictoary
    # Then divide the values into variables 
    # which are used as information for the database
    def ipInfo(self, ip):

        self.ip = ip
        
        # Load the dictionary data which is in json format
        try:
            self.json_data = self.api.host(self.ip)
            
            self.countryCode = self.json_data["country_code"]
            self.ports = self.json_data["ports"]
            self.geoData = str(self.json_data["latitude"]) + "," + str(self.json_data["longitude"])
            self.domainName = self.json_data["hostnames"]
        except Error as e:
            print("Failed to upload " + self.ip)
            print("Error: " + e)

    # Generate a uniqe ID based on the Object from shodans values
    # So if the same IP address is queryed again but it changed 
    # It wont be seen as the same object.
    def generateId(self):

        hashSha256 = hashlib.sha256()

        tempStr = str(self.ip) + str(self.countryCode) + str(self.ports) + str(self.geoData) + str(self.domainName)

        hashSha256.update(bytes(tempStr, encoding = 'utf8'))

        self.ipId = hashSha256.hexdigest()

    # Return a table for the information i nthe class
    def getIpTable(self):

        ipTable = [self.ipId, self.ip, str(self.domainName), str(self.ports), self.countryCode, self.geoData]

        return ipTable

    # Return the specific ID for the object
    def getIpId(self):

        return self.ipId

