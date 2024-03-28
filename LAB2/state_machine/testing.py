test = ""

with open("asci.txt", 'r') as file:
    file_lines = file.readlines()

    for line in file_lines:
        for byte in line:
            test += "0001"
            test += format(ord(byte), '08b')[::-1]

with open("binary.txt", 'w+') as file:
    file.write(test)
