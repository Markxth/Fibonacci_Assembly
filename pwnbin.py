import sys
import pefile as pe 

file = pe.PE('fib.exe') #hardcode for ease of use 

for section in file.sections : 
    if b'.text' in section.Name : 
        shellcode = section.get_data() 
        print(shellcode.hex() ) 
        break 
    