# EstSemRol
EstUD with te annotation of Semantic Roles

# Eesti keele semantilise analüüsi baasvahendid
Projekti käigus märgendasime eesti kirjakeele universaalsete sõltuvuste korpuse EDT semantiliste rollidega vastavalt PropBanki (Proposition Bank https://propbank.github.io/ ; Palmer jt 2005) märgendusskeemile. Valisime märgendamiseks  sagedasemate ühesõnalisete verbide (sagedasem kui 9 esinemist 440000-sõnalises korpuses) argumendistruktuuri,  selle käigus tuli luua ka minimaalne verbi tähenduste jaotus, mis sagedasemate vebide puhul (saama, tulema, minema, panema jne) võib koosneda kuni 15 erineva tähenduse eristamisest. 

Märgendati 625 erineva verbi 36760 esinemist, nende 848 erinevat tähendust ja nende 57792 argumenti.

Verbimärgendus on Misc-väljal kujul Verb=verbilemma või Verb=verbilemma_nr, kus number eristab verbi erinevaid tähendusi ja ka argumendistruktuuri konfiguratsioone.
Argumendid on kujul Arg=verbilemma_Arg_nr, kus nr = 0 .. 5. Arg_0 on tüüpiliselt alus, Arg_1 on protsessiverbi alus või muu verbi sihitis. Argumendistruktuuri numeratsioonil ei ole kindlat nummerdamisreeglit, tihedamalt seotud argumendid on väiksema numeratsiooniga, kuid on ka muid seaduspärasusi, näiteks Arg_2 on liikumis- ja liigutamisverbide lähtekoht, Arg_3 on liikumis- ja liigutamisverbide sihtkoht.

Ülevaade märgendatud ja märgendamata verbidest on leitav [docs/argumendid.tsv](docs/argumendid.tsv).

```
# sent_id = aja_ee199920_2202
# text = Tema dialektiline meetod ei jäta hüperboolideks ruumi.
1	Tema	tema	PRON	P	Case=Gen|Number=Sing|Person=3|PronType=Prs	3	nmod	3:nmod	_
2	dialektiline	dialektiline	ADJ	A	Case=Nom|Degree=Pos|Number=Sing	3	amod	3:amod	_
3	meetod	meetod	NOUN	S	Case=Nom|Number=Sing	5	nsubj	5:nsubj	Arg=jätma_Arg_0
4	ei	ei	AUX	V	Polarity=Neg	5	aux	5:aux	_
5	jäta	jätma	VERB	V	Connegative=Yes|Mood=Ind|Tense=Pres|VerbForm=Fin|Voice=Act	0	root	0:root	Verb=jätma_8
6	hüperboolideks	hüperbool	NOUN	S	Case=Tra|Number=Plur	5	obl	5:obl	Arg=jätma_Arg_2
7	ruumi	ruum	NOUN	S	Case=Par|Number=Sing	5	obj	5:obj	Arg=jätma_Arg_1|SpaceAfter=No
8	.	.	PUNCT	Z	_	5	punct	5:punct	_
```


