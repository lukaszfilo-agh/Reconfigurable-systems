def reg_to_bin(reg: str):
    match reg.upper():
        case "R0":
            return "000"
        case "R1":
            return "001"
        case "R2":
            return "010"
        case "R3":
            return "011"
        case "R4":
            return "100"
        case "R5":
            return "101"
        case "R6":
            return "110"
        case "R7":
            return "111"
        case "PC":
            return "111"
        case _:
            raise Exception('Wrong argument!')


def assembly(line: str):
    if line == "":
        return ""

    splited = line.split(" ")
    instr = splited[0]
    instr = instr.replace(" ", "").replace("\n", "")
    args = []
    machine_code = ""
    if len(splited) > 1:
        for i in range(1, len(splited)):
            """remove redundant comas and spaces"""
            args.append(splited[i].replace(
                ",", "").replace(" ", "").replace("\n", ""))
    if instr == "nop":
        return "00000000_00000000_00000110_00000000"
    if instr == "mov":
        machine_code = "00000000_00010"
        """rx_op"""
        machine_code += reg_to_bin(args[1])
        machine_code += "_00000"
        """d_op"""
        machine_code += reg_to_bin(args[0])
        machine_code += "_" + 8 * "0"
        return machine_code
    if instr == "movi":
        machine_code = "00000000_00110000_10000"
        machine_code += reg_to_bin(args[0]) + "_"
        machine_code += "{0:08b}".format(int(args[1], 16))
        return machine_code
    if instr == "add":
        machine_code = "00000000_00010" + reg_to_bin(args[1]) + "_" + "0" + reg_to_bin(args[2]) + "0" + reg_to_bin(
            args[0]) + "_" + 8 * "0"
        return machine_code
    if instr == "addi":
        machine_code = "00000000_00010" + \
            reg_to_bin(args[1])+"_10000"+reg_to_bin(args[0]) + \
            "_" + "{0:08b}".format(int(args[2], 16))
        return machine_code
    if instr == "jump":
        machine_code = "00000001_00010" + \
            reg_to_bin(args[0]) + "_10000110_00000000"
        return machine_code
    if instr == "jumpi":
        machine_code = "00000001_00110000_10000110" + \
            "_{0:08b}".format(int(args[0], 16))
        return machine_code
    if instr == "jz":
        machine_code = "00000010_00110" + \
            reg_to_bin(args[0]) + "_10000110" + \
            "_{0:08b}".format(int(args[1], 16))
        return machine_code
    if instr == "jnz":
        machine_code = "00000011_00110" + \
            reg_to_bin(args[0]) + "_10000110" + \
            "_{0:08b}".format(int(args[1], 16))
        return machine_code
    if instr == "and":
        machine_code = "00000000_00000" + reg_to_bin(args[1]) + "_" + "0" + reg_to_bin(args[2]) + "0" + reg_to_bin(
            args[0]) + "_" + 8 * "0"
        return machine_code
    if instr == "andi":
        machine_code = "00000000_00000" + \
            reg_to_bin(args[1])+"_10000"+reg_to_bin(args[0]) + \
            "_" + "{0:08b}".format(int(args[2], 16))
        return machine_code
    if instr == "load":
        machine_code = "00000000_00010" + \
            reg_to_bin(args[1]) + "_10001"+reg_to_bin(args[0]) + "_" + 8 * "0"
        return machine_code
    if instr == "loadi":
        machine_code = "00000000_00110000_10001" + \
            reg_to_bin(args[0]) + "_" + "{0:08b}".format(int(args[1], 16))
        return machine_code


def main():
    lines = []
    with open("code_gpio.asm") as f:
        line = f.readline()
        while line:
            lines.append(line)
            line = f.readline()

    f = open("code.txt", "w")

    i = 0
    for l in lines:
        code_line = "assign program[{}] = 32'b".format(i) + assembly(l) + ";"
        f.write('//' + l)
        f.write(code_line + "\n")
        print(code_line)
        i += 1

    f.close()


if __name__ == "__main__":
    main()
