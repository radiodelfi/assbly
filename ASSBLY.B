10 rem assbly tool
20 poke 36879,8
25 print chr$(5)chr$(147)
30 print "**** assbly tool ****"
35 print chr$(17)" by radio delfi 1984"
40 print chr$(17)chr$(17)chr$(17)"memoria da riservare? (pagine di 256 byte)"
45 input n:n=30-n
50 poke 52,n:poke 56,n
55 print chr$(147)
60 print "che opzione scegli?"
65 print chr$(13);"caricamento (c):"
70 print chr$(13);"esame (e):"
75 print chr$(13);"salto (b):"
80 print chr$(13);"run (r):"
85 print chr$(13);"basic (m):"
90 input o$
100 if o$="c"then goto 150
110 if o$="e"then goto 480
120 if o$="b"then goto 650
130 if o$="r"then goto 860
135 if o$="m"then goto 910
140 goto 90
150 rem caricamento in  memoria
155 print chr$(147)
160 print chr$(13);"inizio del programma?:"
170 input de$:a$=de$
180 gosub 280: dc=s
190 print chr$(13);"codice?"
200 input co$:a$=co$
210 if co$="^"then goto 10
220 gosub 280:cc=s
230 print chr$(13);spc(6);de$;spc(2);co$
240 poke dc,cc
250 dc=dc+1:n=dc
260 gosub 410:de$=a$
270 goto 190
280 rem hex/decimale
290 t$="0123456789abcdef"
300 s=0
310 x=len(a$)
320 for i=1 to x
330 b$=mid$(a$,i,1)
340 for j=1 to16
350 e$=mid$(t$,j,1)
360 if e$=b$ then j1=j
370 next j
380 r=(j1-1)*16^(x-i)
390 s=s+r
400 next i: return
410 rem decimale/hex
420 t$="0123456789abcdef"
430 for i=4 to 1 step-1
440 r=int(n/16^(i-1))
450 a$(i)=mid$(t$,r+1,1)
460 n=n-r*16^(i-1):nexti
470 a$=a$(4)+a$(3)+a$(2)+a$(1):return
480 rem lettura della memoria
485 print chr$(147)
490 print "indirizzo iniziale?:"
500 input de$:a$=de$
510 gosub 280:dc=s
520 print chr$(13);spc(3);"ind.   dato"
530 n=peek(dc)
540 gosub 410:co$=a$
550 print spc(3);de$;spc(3);right$(co$,2)
560 input y$
570 if y$="/"then goto 620
580 if y$="^"then goto 10
590 a$=y$:gosub 280
600 cc=s:poke dc,cc
610 print spc(3);de$;spc(3);right$(a$,2):goto 560
620 dc=dc+1:n=dc
630 gosub 410:de$=a$
640 goto 530
650 rem calcolo dell'offset
655 print chr$(147)
660 print chr$(13);"indirizzo dell'i-"
670 print chr$(13);"struzione di salto"
680 print chr$(13);"condizionato?:"
690 input de$:a$=de$
700 if de$="^"then goto 10
710 gosub 280:dc=s
720 print chr$(13);"indirizzo del salto?:"
740 input df$:a$=df$
750 gosub 280:db=s
760 br=db-dc
770 if br>=127 or br<=-128 then print chr$(147)"offset troppo alto"
780 br=br-2
790 if br>0 then goto 810
800 br=br+256
810 n=br
820 gosub 410:de$=a$
830 print chr$(17)chr$(13);"offset relativo:";right$(de$,2)
840 goto 660
850 goto 10
860 rem run
865 print chr$(147)
870 print chr$(13);"indirizzo?":input de$
880 a$=de$:gosub 280
890 sys(s)
900 goto 10
910 print chr$(147)
920 end