# import hashlib to generate sha256 hash for files
import hashlib

class FileData:

    # Initlize file with the name of the file and path used 
    # To hash the file
    def __init__(self, filename, filepath):
        self.filename = filename
        self.filepath = filepath
        self.setSha256Hash()

    # generate the hash of the file
    def setSha256Hash(self):
        BLOCKSIZE = 65536
        hashSha256 = hashlib.sha256()

        with open(self.filepath, "rb") as analyzedFile:
            fBuffer = analyzedFile.read(BLOCKSIZE)
            while (len(fBuffer) > 0):
                hashSha256.update(fBuffer)
                fBuffer = analyzedFile.read(BLOCKSIZE)

        self.hash = hashSha256.hexdigest()

    # Output a list which can be used as input to an insert statment in sql
    def getFileTable(self):

        fileTable = [self.hash, self.filename]

        return fileTable

    # Return the hash for a file
    def getHash(self):

        return self.hash




