
REM http://www.skyfree.org/linux/references/coff.pdf
REM 6.2. The .drectve Section (Object Only)
REM
REM The linker removes a .drectve section after processing the information, 
REM  so the section does not appear in the image file being linked

%1 %2 | c:\Windows\System32\find.exe /C ".drectve"