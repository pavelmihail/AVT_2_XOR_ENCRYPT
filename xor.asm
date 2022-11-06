.model large
include fisio.h
.stack 10h
.data
    file_name db 'tema.txt',0
    encrypt_name db 'encrasm.txt',0
    handInitial dw ? ;handler
    hand2 dw ?
    buf db 16 dup(2) ;buffer pentru citire
    key db 0Fh ;random value for the key
    rez dw ? ;rezultat operatii asupra fisierelor
    OctCit dw ?
    OctScr dw ?
    crypt dw ?
.code
start:
    mov ax, @data
    mov ds, ax
    
    ;open the plain text file
    DeschideFisier file_name,0,handInitial,rez

    ;create the encrypted text file
    CreazaFisier encrypt_name,6, hand2,rez

    ;open encrypted text file
    DeschideFisier encrypt_name,1,hand2,rez
    
bucla:
    CitesteDinFisier handInitial,buf,1,OctCit,rez
    
    mov SI, OctCit
    mov AL, buf
    xor AL, key
    mov buf, AL
    ScrieInFisier hand2, buf, 1, OctScr,rez
    mov byte ptr buf[SI], '$' 

    mov dx, offset buf ;lea dx,buff
    mov ah,09h
    int 21h
    ; puts buf
    cmp OctCit, 1
    jb gata
    jmp bucla


gata:
    InchideFisier handInitial,rez
    InchideFisier hand2,rez
    jmp iesire
iesire:
    exit_dos
end start