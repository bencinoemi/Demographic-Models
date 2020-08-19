***********Mini-project
clear
 
cd "C:\Users\UTENTE\Documents\Noemi\Università\in_corso\Modelli_Demografici\Miniproject" 
import delimited C:\Users\UTENTE\Documents\Noemi\Università\in_corso\Modelli_Demografici\Miniproject\MICRODATI\ISTAT_MFR_InsProLau_Microdati_2015_DELIMITED.txt, delimiter("^") 

marty.pacifico@libero.it	


*keep cod_uni_mfr tiplau subpop reg_prima gruppo sesso l1_1 l1_2 l1_20 l1_22 l1_31 l2_60 l2_61 l2_64 l2_71 l2_72 l4_11 mesi_i_lavoro
*rename cod_uni_mfr cod_uni
rename subpop grado_edu
rename l1_1 tipo_dipl 
rename l1_2 luogo_dipl 
rename l1_20 fuori_corso
*rename l1_22 voto_lau creo dummy
rename l1_31 albo 


**** OPPORTUNITA' 
encode l2_60, gen(opp_postlau)

replace opp_postlau=0 if opp_postlau==2 
tab opp_postlau
*///nessuna opportunità=0
label define opp_postlau 1 "Almeno_una_opportunità" opp_postlau 0 "Nessuna_opportunità"
label value opp_postlau opp_postlau
tab opp_postlau

encode l2_61, gen(opp_accettata)
replace oppo_accettata=0 if oppo_accettata==2 
*///nessuna_accettata
label define oppo_accettata 1"Almeno_una_opportunità_accettata" 0"Nessuna_opp_accettata"
label value oppo_accettata oppo_accettata
tab opp_accettata

tab oppo_accettata oppo_postlau
**** Risulta essere problematica la trattazione delle opportunità di lavoro 
**** per problemi relativi al dataset 


*rename l2_72 luogo_lavoro
rename l4_11 trasfer_dl

** dummy da creare:
* SPOSTAMENTO LAUREA-LAVORO
*cambiare GRADO_EDU 
*chiedere ALBO


**** CREAZIONE VARIABILI UTILI
*aggregazione gruppi
rename gruppo app
gen gruppo=.
replace gruppo=1 if app==8   /*solo*/
replace gruppo=2 if app==1|app==2 /*scientifico = scientifico+ chimico farmaceutico*/
replace gruppo=3 if app==3 | app==7  /*Biologico = Geobiologico+ agraria*/
replace gruppo=4 if app==4  /*medico solo*/
replace gruppo=5 if app==5 |app==6 /*Ingegeneria+ architettura*/
replace gruppo=6 if app==9 |app==16 /*politico-sociale + difesa e sicurezza */
replace gruppo=7 if app==10 /*Giuridico*/
replace gruppo=8 if app==11|app==12 /*letterario + Linguistico*/
replace gruppo=9 if app==13| app==14| app==15 /* isegnamento e psicologia*/
label define gruppo 1"Economic-Statistics" 2"Scientific" 3"Biological" 4"Medical" 5"Engineering" 6"SocialScience" 7"Juridical" 8"Literary" 9"Psycho-pedagogical" 
label values gruppo gruppo
*VOTO SUPERIORE A 100
gen voto_lau=.
replace voto_lau=0 if l1_22<100
replace voto_lau=1 if l1_22>=100
*sesso*
replace sesso=sesso-1
label define sesso 0"maschio" 1"femmina"
label values sesso sesso 
*Raggruppamento cod_uni_mfr per Regione
generate luogo_conseguimento=""
replace luogo_conseguimento = "Abruzzo" if cod_uni_mfr=="06701" | cod_uni_mfr=="06601" | cod_uni_mfr=="06901"
replace luogo_conseguimento = "Basilicata" if cod_uni_mfr=="07601"
replace luogo_conseguimento = "Calabria" if cod_uni_mfr=="08001" | cod_uni_mfr=="07901"| cod_uni_mfr=="07801"
replace luogo_conseguimento = "Campania" if cod_uni_mfr=="06201" | cod_uni_mfr=="06301" | cod_uni_mfr=="06302" | cod_uni_mfr=="06303" | cod_uni_mfr=="06304" | cod_uni_mfr=="06306" | cod_uni_mfr=="06501"
replace luogo_conseguimento = "Emilia_Romagna" if cod_uni_mfr=="03401" | cod_uni_mfr=="03601" | cod_uni_mfr=="03701" | cod_uni_mfr== "03801"
replace luogo_conseguimento = "Friuli_Venezia_Giulia" if cod_uni_mfr=="03001" | cod_uni_mfr=="03201" | cod_uni_mfr=="03202"
replace luogo_conseguimento = "Lazio" if cod_uni_mfr=="06001" | cod_uni_mfr=="05809" | cod_uni_mfr=="05808" | cod_uni_mfr=="05807" | cod_uni_mfr=="05806" | cod_uni_mfr=="05805" | cod_uni_mfr=="05803" | cod_uni_mfr=="05802" | cod_uni_mfr=="05801" | cod_uni_mfr=="05601"
replace luogo_conseguimento = "Liguria" if cod_uni_mfr=="01001"
replace luogo_conseguimento = "Lombardia" if cod_uni_mfr=="01201" | cod_uni_mfr=="01202" | cod_uni_mfr=="01501" | cod_uni_mfr=="01502" | cod_uni_mfr=="01503"| cod_uni_mfr=="01504" | cod_uni_mfr=="01505" | cod_uni_mfr=="01508" | cod_uni_mfr=="01509" | cod_uni_mfr=="01601" | cod_uni_mfr=="01701" | cod_uni_mfr=="01801" | cod_uni_mfr== "01802"
replace luogo_conseguimento = "Marche" if cod_uni_mfr=="04101" | cod_uni_mfr=="04201" | cod_uni_mfr=="04301" | cod_uni_mfr=="04302"
replace luogo_conseguimento = "Molise" if cod_uni_mfr=="07001"
replace luogo_conseguimento = "Piemonte" if cod_uni_mfr=="00101"| cod_uni_mfr=="00102" | cod_uni_mfr=="00201"
replace luogo_conseguimento = "Puglia" if cod_uni_mfr=="07101" | cod_uni_mfr=="07201"| cod_uni_mfr=="07202" | cod_uni_mfr=="07501"
replace luogo_conseguimento = "Sardegna" if cod_uni_mfr=="09001" | cod_uni_mfr=="09201"
replace luogo_conseguimento = "Sicilia" if cod_uni_mfr=="08201" | cod_uni_mfr=="08301" | cod_uni_mfr=="08601" | cod_uni_mfr=="08701"
replace luogo_conseguimento = "Toscana" if cod_uni_mfr=="04601" | cod_uni_mfr=="04801" | cod_uni_mfr=="04803" | cod_uni_mfr=="05001" | cod_uni_mfr=="05002" | cod_uni_mfr=="05003" | cod_uni_mfr=="05201" | cod_uni_mfr=="05202"
replace luogo_conseguimento = "Trentino_Alto_Adige" if cod_uni_mfr=="02101" | cod_uni_mfr=="02201"
replace luogo_conseguimento = "Umbria" if cod_uni_mfr=="05401" | cod_uni_mfr=="05403"
replace luogo_conseguimento = "Val_d_Aosta" if cod_uni_mfr=="00701" 
replace luogo_conseguimento = "Veneto" if cod_uni_mfr=="02301" | cod_uni_mfr=="02701" | cod_uni_mfr=="02702" | cod_uni_mfr=="02801"
replace luogo_conseguimento = "Telematica" if cod_uni_mfr=="01301" | cod_uni_mfr=="05810" | cod_uni_mfr=="05814" | cod_uni_mfr=="05816" | cod_uni_mfr=="06202" | cod_uni_mfr=="06307"
replace luogo_conseguimento = "Estero" if cod_uni_mfr=="99999"
** Telematica ed estero aggregati dovuto a poche osservazioni
** genera dummy uni privata e pubblica
*università privata o pubblica
gen privata=0
replace privata=1 if cod_uni_mfr=="01201"|cod_uni_mfr=="01503"|cod_uni_mfr=="01504"|cod_uni_mfr=="01505"|cod_uni_mfr=="01508"|cod_uni_mfr=="02101"|cod_uni_mfr=="05803"|cod_uni_mfr=="05805"|cod_uni_mfr=="05808"|cod_uni_mfr=="05809"|cod_uni_mfr=="06304"|cod_uni_mfr=="08601"
label define privata 0"pubblica" 1"privata"
label values privata privata
*aggregazioni in regione
gen ita=.
replace ita=0 if luogo_conseguimento=="Friuli_Venezia_Giulia"| luogo_conseguimento=="Lombardia"| luogo_conseguimento=="Piemonte"| luogo_conseguimento=="Veneto"| luogo_conseguimento=="Valle_d'Aosta"| luogo_conseguimento=="Trentino_Alto_Adige"
replace ita=1 if luogo_conseguimento=="Liguria"| luogo_conseguimento=="Emilia_Romagna"|luogo_conseguimento=="Toscana"| luogo_conseguimento=="Marche"|luogo_conseguimento=="Umbria"| luogo_conseguimento=="Lazio"| luogo_conseguimento=="Abruzzo"
replace ita=2 if luogo_conseguimento=="Molise"| luogo_conseguimento=="Campania"|luogo_conseguimento=="Puglia"|luogo_conseguimento=="Basilicata"| luogo_conseguimento=="Calabria"
replace ita=3 if luogo_conseguimento=="Sicilia"|luogo_conseguimento=="Sardegna"
replace ita=4 if luogo_conseguimento=="Telematica"|luogo_conseguimento=="Estero"
label define ita 0"Nord" 1"Centro" 2"Sud" 3"Isole" 4"Telematica&Estero"
label values ita ita

*creazione etichette per "tiplau"
label define tiplau 1"Ciclo_Unico/V.O." 2"Specialistica"  3"Triennale"
label values tiplau tiplau
*creazione etichette per "tipo_dipl"
label define tipo_dipl 1"Liceo_Classico" 2"Liceo_Scientifico" 3"Liceo_Linguistico" 4"Liceo_Socio-Psico-Pedagogico" 5"Liceo_Artistico/Istituto_Arte" 6"Istituto_Tecnico" 7"Istituto_Professionale" 8"Scuola_Straniera"
label values tipo_dipl tipo_dipl
*master primo livello
gen master_i_2=0
replace master_i_2=1 if l1_32a==1|l1_32a==2
*master secondo livello	
gen master_ii_2=0
replace master_ii_2=1 if l1_32b==1|l1_32b==2
*magistrale
gen magistr_2=0
replace magistr_2=1 if l1_32c==1|l1_32c==2
*ciclo unico
gen ciclo_unic_2=0
replace ciclo_unic_2=1 if l1_32d==1|l1_32d==2
*triennale
gen trienn_2=0
replace trienn_2=1 if l1_32e==1|l1_32e==2
** creazione Variabili contesto familiare: 
*istruzione genitori: l5_4 l5_9
*istr_madre
gen istr_madre=.
replace istr_madre= 0 if l5_9==1 |l5_9==2
replace istr_madre= 1 if l5_9==3 |l5_9==6
replace istr_madre= 2 if l5_9==4 |l5_9==5
*istr_padre
gen istr_padre=.
replace istr_padre= 0 if l5_4==1 |l5_4==2
replace istr_padre= 1 if l5_4==3 |l5_4==6
replace istr_padre= 2 if l5_4==4 |l5_4==5
*istr_genitori
gen istr_genitori=.
replace istr_genitori=0 if istr_madre==0 & istr_padre==0
replace istr_genitori=1 if (istr_madre==1 & istr_padre==0) |(istr_madre==0 & istr_padre==1)
replace istr_genitori=2 if istr_madre==1 & istr_padre==1
replace istr_genitori=3 if (istr_madre==1 & istr_padre==2) |(istr_madre==2 & istr_padre==1)|(istr_madre==2 & istr_padre==0)| (istr_madre==0 & istr_padre==2)
replace istr_genitori=4 if istr_madre==2 & istr_padre==2

label define istr_genitori 0"entrambi max medie" 1"almeno uno diploma" 2"entrambi diplomati" 3"almeno un laureato" 4"entrambi laureati"
label values istr_genitori istr_genitori
tab istr_genitori
*occupazione genitori: l5_10 l5_5 
gen occ_genitori =0
replace occ_genitori=1 if (l5_11=="1" &l5_6=="1") | (l5_11=="0" &l5_6=="1")| (l5_11=="1" &l5_6=="0") 
replace occ_genitori=2 if (l5_11=="1" &l5_6=="2")| (l5_11=="0" &l5_6=="2") | (l5_11=="2" &l5_6=="1")| (l5_11=="2" &l5_6=="2") | (l5_11=="2" &l5_6=="0")
label define occ_genitori 0"entrambi pensionati/disoccupati" 1"almeno un dipendente" 2"almeno un autonomo"
label values occ_genitori occ_genitori
*time
tab mesi_i_lavoro
drop if mesi_i_lavoro=="-1"
encode mesi_i_lavoro, gen(time)
tab time
replace time=60 if mesi_i_lavoro== "  "
*event
gen event=1
replace event=0 if mesi_i_lavoro== "  "
rename progr id

**** DESCRITTIVE
tab time event 
sort id
ltable time event, hazard 
ltable time event, by(gruppo) graph
ltable time event, by(gruppo) interval(6) graph

**** STSET
stset time, id(id) failure(event)
sts graph
sts graph, hazard
graph save Graph "C:\Users\UTENTE\Documents\Noemi\Università\in_corso\Modelli_Demografici\Miniproject\hazard_insieme.gph"

sts graph, by(gruppo)
sts graph, by(gruppo) hazard
graph save Graph "C:\Users\UTENTE\Documents\Noemi\Università\in_corso\Modelli_Demografici\Miniproject\hazard_gruppo.gph"

sts graph, by(sesso)
sts graph, by(sesso) hazard
graph save Graph "C:\Users\UTENTE\Documents\Noemi\Università\in_corso\Modelli_Demografici\Miniproject\hazard_sesso.gph"

sts graph, by(tiplau)
sts graph, by(tiplau) hazard
graph save Graph "C:\Users\UTENTE\Documents\Noemi\Università\in_corso\Modelli_Demografici\Miniproject\hazard_tiplau.gph"

sts graph if gruppo==1, title("Kaplan-Meier per laurea scientifica")
sts graph, by(ita)
sts graph, by(ita) hazard
graph save Graph "C:\Users\UTENTE\Documents\Noemi\Università\in_corso\Modelli_Demografici\Miniproject\hazard_ita.gph"



sts list, failure 
sts list, survival
sts list, by(gruppo)


/*Dai grafici si nota come: 
- per sesso non ci siano differenze ne di timing ne di probabilià
- per gruppo si hanno sia differenze per timing sia per probabilità
- per tipo di laurea sia per timing sia per probabilità
- per area geografica sia per timing sia per probabilità */
******************************** PROVE MODELLI

*per la scelta del modello si guardano gli hazard osservati nel 
*campione per stabilire la distribuzione.
sts graph, by(gruppo) hazard
* dalla forma degli hazard si intuisce una forma monotona crescente 
* e convessa per ogni gruppo quindi potremmo ipotizzare una distribuzione 
* Gompertz, oppure optare per un modello Piece-wise constant (dividendo il 
* in opportuni intervalli. Infine potremmo applicare un modello di COX
* semiparametrico per confrontarlo con gli altri.

*** MODELLO GOMPERTZ
streg i.gruppo i.ita i.sesso, d(gomp)
streg i.gruppo i.ita i.sesso, d(gomp) nohr
estimate store m_gomp
**dal modello stimato si evince che tra i coefficienti dei 16
** gruppi di laurea risultano non significativi (rispetto ad un individuo
* maschio laureato al nord nel settore scientifico(baseline)),
** i gruppi relativi a chimico-farmaceutico, ingegneria, architettura
* agraria, economico-statistico, politico sociale, giuridico, linguistico,
*educazione fisica, difesa e sicurezza. Neanche il coefficiente 
*relativo al sesso risulta essere significativo.
* I coefficienti significativi sotto 1%:
** geo biologico -> effetto negativo sull'odds di baseline (maschio- scientifico)
** medico -> effeto positivo
** psicologico -> effetto negativo
** educazione fisica -> effetto negativo
** Coefficienti significativi al 5%:
** chimico-farmaceutico -> effetto positivo
** ingegneria -> effetto positivo
** politico-sociale -> effetto positivo
** letterario -> effetto negativo

** per quanto rigurda il luogo di conseguimento del titolo si ha che 
** tutti i coefficeinti sono altamente significativi rispetto alla baseline


*** MODELLO DI COX
stcox i.gruppo i.sesso i.ita

stcurve, survival
stcurve, cumhaz

** i coefficienti stimati seguono il pattern individuato nell'interpretazione 
*del modello Gompertz
*** MODELLO PIECE-WISE CONSTANT


stsplit time_int, at(0,6,12,18,24,30,36,42,48)
stptime, by(_t0)

streg i.gruppo i.time_int, d(e) 
estimate store piece_wise_univariato
coefplot, xline(0) keep(1.gruppo 2.gruppo 3.gruppo 4.gruppo 5.gruppo 6.gruppo 7.gruppo 8.gruppo 9.gruppo) title("Estimated coefficients for Field of education")

streg i.gruppo ib3.tiplau##i.time_int, d(e) 
estimate store piece_wise_interazione
coefplot, xline(0) keep(1.gruppo 2.gruppo 3.gruppo 4.gruppo 5.gruppo 6.gruppo 7.gruppo 8.gruppo 9.gruppo ) title("Estimated coefficients for Field of education")


streg ib3.tiplau##i.time_int  i.gruppo i.ita i.voto_lau i.privata i.ciclo_unic_2 i.trienn_2 i.magistr_2 i.master_i_2 i.master_ii_2 i.sesso ib2.tipo_dipl i.occ_genitori ib2.istr_genitori, d(e)
estimate store piece_wise_ultimo
coefplot, xline(0) keep(1.gruppo 2.gruppo 3.gruppo 4.gruppo 5.gruppo 6.gruppo 7.gruppo 8.gruppo 9.gruppo ) title("Estimated coefficients for Field of education")

streg ib3.tiplau##i.time_int  i.gruppo i.ita i.voto_lau i.privata i.ciclo_unic_2 i.trienn_2 i.magistr_2 i.master_i_2 i.master_ii_2 i.sesso ib2.tipo_dipl i.occ_genitori ib2.istr_genitori, d(e)

estate phtest,detail

coefplot, xline(0) nolabels
coefplot, xline(0) keep(1.gruppo 2.gruppo 3.gruppo 4.gruppo 5.gruppo 6.gruppo 7.gruppo 8.gruppo 9.gruppo 10.gruppo 11.gruppo 12.gruppo 13.gruppo 14.gruppo 15.gruppo 16.gruppo) title("Estimated coefficients for Field of education")
coefplot, xline(0) keep(6.time_int 12.time_int 18.time_int 24.time_int 30.time_int 36.time_int 42.time_int 48.time_int) title("Estimated coefficients for time intervals")
coefplot, xline(0) keep(1.ciclo_unic_2 1.trienn_2 1.magistr_2 1.master_i_2 1.master_ii_2 ) title("Estimated coefficients for continue the studings")
coefplot, xline(0) keep(1.ita 2.ita 3.ita 4.ita) title("Estimated coefficients for Grographiical area")


streg i.time_int##ib8.gruppo i.ita i.voto_lau i.privata i.ciclo_unic_2 i.trienn_2 i.magistr_2 i.master_i_2 i.master_ii_2 i.sesso ib3.tiplau ib2.tipo_dipl i.occ_genitori ib2.istr_genitori, d(e) 
estimate store piece_wise_interazione

stcurve, cumhaz																					
stcurve, survival yline(0.5) at1(gruppo=1) 
stcurve, survival yline(0.5) at1(gruppo=1) at2(gruppo=2) at3(gruppo=3) at4(gruppo=4) at5(gruppo=5) at6(gruppo=6) at7(gruppo=7) at8(gruppo=8) at9(gruppo=9) legend(lab(1 "Economic-Statistics") lab(2 "Scientific") lab( 3 "Biological") lab( 4 "Medical") lab( 5 "Engineering") lab( 6 "SocialScience") lab( 7 "Juridical") lab( 8 "Literary") lab( 9 "Psycho-pedagogical" ))


predict time_hat

** i coefficienti stimati seguono il pattern individuato nell'interpretazione 
*del modello Gompertz

*** MODELLO ESPONENZIALE
streg i.gruppo  i.ita i.sesso, d(e) nohr

**dal modello stimato si evince che tra i coefficienti dei 16
** gruppi di laurea risultano non significativi (rispetto al settore scientifico (baseline)
** i gruppi relativi a chimico-farmaceutico ingegneria, architettura
* agraria, economico-statistico, politico sociale, giuridico, linguistico,
*educazione fisica, difesa e sicurezza. Neanche il coefficiente 
*relativo al sesso risulta essere significativo.
* I coefficienti significativi:
** geo biologico -> effetto negativo sull'odds di baseline (maschio- scientifico)
** medico -> effeto positivo
** letteratura -> effetto negativo
** insegnamento -> effetto positivo
** psicologico -> effetto negativo
** educazione fisica -> effetto negativo
** coefficienti ita-> tutti altamente significativi

************************************ MODELLO SCELTO -> GOMPERTZ
** Poichè i tre modelli stimati sono tutti molto simili e, poichè abbiamo individuato la distribuzione
** dei dati abbiamo deciso di utilizare il modello Gompertz
streg i.gruppo i.ita i.sesso i.tiplau i.tipo_dipl i.occ_genitori i.istr_genitori, d(gomp) nohr
**modello finale
streg i.gruppo i.ita i.voto_lau i.privata i.ciclo_unic_2 i.trienn_2 i.magistr_2 i.master_i_2 i.master_ii_2 i.sesso i.tiplau i.tipo_dipl i.occ_genitori i.istr_genitori, d(gomp) nohr
estimate store gomp

stcurve, hazard
stcurve, survival
stcurve, cumhaz


estimate stats gomp piece_wise

** stesso modello con baseline diversa
streg ib8.gruppo i.ita i.voto_lau i.privata i.ciclo_unic_2 i.trienn_2 i.magistr_2 i.master_i_2 i.master_ii_2 i.sesso ib3.tiplau ib2.tipo_dipl i.occ_genitori ib2.istr_genitori, d(gomp) nohr
streg ib8.gruppo i.ita i.voto_lau i.privata i.ciclo_unic_2 i.trienn_2 i.magistr_2 i.master_i_2 i.master_ii_2 i.sesso ib3.tiplau ib2.tipo_dipl i.occ_genitori ib2.istr_genitori, d(gomp) 
estimate store mfinale
*** stesso modello con interazione tra guppo e area
streg ib8.gruppo##i.ita i.voto_lau i.privata i.ciclo_unic_2 i.trienn_2 i.magistr_2 i.master_i_2 i.master_ii_2 i.sesso ib3.tiplau ib2.tipo_dipl i.occ_genitori i.istr_genitori, d(gomp) 

*** modello solo gender
streg i.sesso, d(gomp)
streg ib8.gruppo##i.sesso , d(gomp)
streg ib8.gruppo##i.sesso i.ita i.voto_lau i.privata i.ciclo_unic_2 i.trienn_2 i.magistr_2 i.master_i_2 i.master_ii_2 ib3.tiplau ib2.tipo_dipl i.occ_genitori i.istr_genitori, d(gomp)

***PREVISIONI
stcurve

estimate restore piece_wise
predict time_hat
list  tiplau time_hat if gruppo==3
** durata attesa per gruppo
tabstat time_hat, stats(mean) by(gruppo)
** durata attesa per gruppo e area

tabstat time_hat if ita==0 , stats(mean) by(gruppo) //nord
tabstat time_hat if ita==1 , stats(mean) by(gruppo) //centro
tabstat time_hat if ita==2 , stats(mean) by(gruppo) //sud
tabstat time_hat if ita==3 , stats(mean) by(gruppo) //isole
tabstat time_hat if ita==4 , stats(mean) by(gruppo) // telematica & estero


** tempi medi per tipo di laurea
tab tiplau
tabstat time_hat if tiplau==1, stats(mean) by(gruppo) //Ciclo Unico
tabstat time_hat if tiplau==2, stats(mean) by(gruppo)  //Specialistica
tabstat time_hat if tiplau==3, stats(mean) by(gruppo) // Triennale
** tempi medi per luogo conseguimento
tab ita
tabstat time_hat if ita==1, stats(mean) by(gruppo) // Nord
tabstat time_hat if ita==2, stats(mean) by(gruppo) //Centro
tabstat time_hat if ita==3, stats(mean) by(gruppo) //Sud
tabstat time_hat if ita==4, stats(mean) by(gruppo) //Isole
tabstat time_hat if ita==5, stats(mean) by(gruppo) //Estero e telematica
** tempi medi per sesso
tab sesso, nol
tabstat time_hat if sesso==0, stats(mean) by(gruppo) // Maschi
tabstat time_hat if sesso==1, stats(mean) by(gruppo) // Femmine
**tempi medi per occ_genitori
tab occ_genitori
tab occ_genitori, nol
tabstat time_hat if occ_genitori==0, stats(mean) by(gruppo) //pensionati/disoccupati
tabstat time_hat if occ_genitori==1, stats(mean) by(gruppo) // Almeno un dipendente
tabstat time_hat if occ_genitori==2, stats(mean) by(gruppo)  //almeno un autonomo

margins, base
sort id
twoway (scatter  time_hat id) (scatter time id), by(gruppo)
twoway (scatter  time_hat id) (scatter time id) if(gruppo==1 & id>=400 & id <=2500)
gen res=time_hat-time
twoway (scatter res id), by(gruppo)
summ time_hat

tab time_hat gruppo

** DA FARE:
** INTERPRETAZIONE MODELLO







************************************** RISCHI COMPETITIVI
clear
import delimited C:\Users\UTENTE\Documents\Noemi\Università\in_corso\Modelli_Demografici\Miniproject\MICRODATI\ISTAT_MFR_InsProLau_Microdati_2015_DELIMITED.txt, delimiter("^") 

ssc install stcompet, replace

gen offerta=0
replace offerta=1 if l2_60=="1" & l2_61=="1"

gen attuale=0
replace attuale=1 if (l2_60=="2"| l2_61=="2") &l2_1==1

gen formazione =0
replace formazione=1 if (l1_36a==1| l1_36a==2 |l1_36a==3)| (l1_36b==1| l1_36b==2 |l1_36b==3)|(l1_36c==1| l1_36c==2 |l1_36c==3)|(l1_36d==1| l1_36d==2 |l1_36d==3) | (l1_36e==1| l1_36e==2 |l1_36e==3)| (l1_36f==1| l1_36f==2 |l1_36f==3) | (l1_36g==1| l1_36g==2 |l1_36g==3) | (l1_36h==1| l1_36h==2 |l1_36h==3)

gen retri_form =0
replace retri_form =1 if l1_38a=="1" | l1_38b=="1" | l1_38c=="1" | l1_38d=="1" | l1_38e=="1"|l1_38f=="1"| l1_38g=="1"| l1_38h=="1"

**** CREAZIONE VARIABILI UTILI
*VOTO SUPERIORE A 100
gen voto_lau=.
replace voto_lau=0 if l1_22<100
replace voto_lau=1 if l1_22>=100
*sesso*
replace sesso=sesso-1
label define sesso 0"maschio" 1"femmina"
label values sesso sesso 
*Raggruppamento cod_uni_mfr per Regione
generate luogo_conseguimento=""
replace luogo_conseguimento = "Abruzzo" if cod_uni_mfr=="06701" | cod_uni_mfr=="06601" | cod_uni_mfr=="06901"
replace luogo_conseguimento = "Basilicata" if cod_uni_mfr=="07601"
replace luogo_conseguimento = "Calabria" if cod_uni_mfr=="08001" | cod_uni_mfr=="07901"| cod_uni_mfr=="07801"
replace luogo_conseguimento = "Campania" if cod_uni_mfr=="06201" | cod_uni_mfr=="06301" | cod_uni_mfr=="06302" | cod_uni_mfr=="06303" | cod_uni_mfr=="06304" | cod_uni_mfr=="06306" | cod_uni_mfr=="06501"
replace luogo_conseguimento = "Emilia_Romagna" if cod_uni_mfr=="03401" | cod_uni_mfr=="03601" | cod_uni_mfr=="03701" | cod_uni_mfr== "03801"
replace luogo_conseguimento = "Friuli_Venezia_Giulia" if cod_uni_mfr=="03001" | cod_uni_mfr=="03201" | cod_uni_mfr=="03202"
replace luogo_conseguimento = "Lazio" if cod_uni_mfr=="06001" | cod_uni_mfr=="05809" | cod_uni_mfr=="05808" | cod_uni_mfr=="05807" | cod_uni_mfr=="05806" | cod_uni_mfr=="05805" | cod_uni_mfr=="05803" | cod_uni_mfr=="05802" | cod_uni_mfr=="05801" | cod_uni_mfr=="05601"
replace luogo_conseguimento = "Liguria" if cod_uni_mfr=="01001"
replace luogo_conseguimento = "Lombardia" if cod_uni_mfr=="01201" | cod_uni_mfr=="01202" | cod_uni_mfr=="01501" | cod_uni_mfr=="01502" | cod_uni_mfr=="01503"| cod_uni_mfr=="01504" | cod_uni_mfr=="01505" | cod_uni_mfr=="01508" | cod_uni_mfr=="01509" | cod_uni_mfr=="01601" | cod_uni_mfr=="01701" | cod_uni_mfr=="01801" | cod_uni_mfr== "01802"
replace luogo_conseguimento = "Marche" if cod_uni_mfr=="04101" | cod_uni_mfr=="04201" | cod_uni_mfr=="04301" | cod_uni_mfr=="04302"
replace luogo_conseguimento = "Molise" if cod_uni_mfr=="07001"
replace luogo_conseguimento = "Piemonte" if cod_uni_mfr=="00101"| cod_uni_mfr=="00102" | cod_uni_mfr=="00201"
replace luogo_conseguimento = "Puglia" if cod_uni_mfr=="07101" | cod_uni_mfr=="07201"| cod_uni_mfr=="07202" | cod_uni_mfr=="07501"
replace luogo_conseguimento = "Sardegna" if cod_uni_mfr=="09001" | cod_uni_mfr=="09201"
replace luogo_conseguimento = "Sicilia" if cod_uni_mfr=="08201" | cod_uni_mfr=="08301" | cod_uni_mfr=="08601" | cod_uni_mfr=="08701"
replace luogo_conseguimento = "Toscana" if cod_uni_mfr=="04601" | cod_uni_mfr=="04801" | cod_uni_mfr=="04803" | cod_uni_mfr=="05001" | cod_uni_mfr=="05002" | cod_uni_mfr=="05003" | cod_uni_mfr=="05201" | cod_uni_mfr=="05202"
replace luogo_conseguimento = "Trentino_Alto_Adige" if cod_uni_mfr=="02101" | cod_uni_mfr=="02201"
replace luogo_conseguimento = "Umbria" if cod_uni_mfr=="05401" | cod_uni_mfr=="05403"
replace luogo_conseguimento = "Val_d_Aosta" if cod_uni_mfr=="00701" 
replace luogo_conseguimento = "Veneto" if cod_uni_mfr=="02301" | cod_uni_mfr=="02701" | cod_uni_mfr=="02702" | cod_uni_mfr=="02801"
replace luogo_conseguimento = "Telematica" if cod_uni_mfr=="01301" | cod_uni_mfr=="05810" | cod_uni_mfr=="05814" | cod_uni_mfr=="05816" | cod_uni_mfr=="06202" | cod_uni_mfr=="06307"
replace luogo_conseguimento = "Estero" if cod_uni_mfr=="99999"
** Telematica ed estero aggregati dovuto a poche osservazioni
** genera dummy uni privata e pubblica
*università privata o pubblica
gen privata=0
replace privata=1 if cod_uni_mfr=="01201"|cod_uni_mfr=="01503"|cod_uni_mfr=="01504"|cod_uni_mfr=="01505"|cod_uni_mfr=="01508"|cod_uni_mfr=="02101"|cod_uni_mfr=="05803"|cod_uni_mfr=="05805"|cod_uni_mfr=="05808"|cod_uni_mfr=="05809"|cod_uni_mfr=="06304"|cod_uni_mfr=="08601"
label define privata 0"pubblica" 1"privata"
label values privata privata
*aggregazioni in regione
gen ita=.
replace ita=0 if luogo_conseguimento=="Friuli_Venezia_Giulia"| luogo_conseguimento=="Lombardia"| luogo_conseguimento=="Piemonte"| luogo_conseguimento=="Veneto"| luogo_conseguimento=="Valle_d'Aosta"| luogo_conseguimento=="Trentino_Alto_Adige"
replace ita=1 if luogo_conseguimento=="Liguria"| luogo_conseguimento=="Emilia_Romagna"|luogo_conseguimento=="Toscana"| luogo_conseguimento=="Marche"|luogo_conseguimento=="Umbria"| luogo_conseguimento=="Lazio"| luogo_conseguimento=="Abruzzo"
replace ita=2 if luogo_conseguimento=="Molise"| luogo_conseguimento=="Campania"|luogo_conseguimento=="Puglia"|luogo_conseguimento=="Basilicata"| luogo_conseguimento=="Calabria"
replace ita=3 if luogo_conseguimento=="Sicilia"|luogo_conseguimento=="Sardegna"
replace ita=4 if luogo_conseguimento=="Telematica"|luogo_conseguimento=="Estero"
label define ita 0"Nord" 1"Centro" 2"Sud" 3"Isole" 4"Telematica&Estero"
label values ita ita
*variabile gruppo
rename gruppo app
gen gruppo=.
replace gruppo=1 if app==8
replace gruppo=2 if app==1|app==2
replace gruppo=3 if app==3 | app==7
replace gruppo=4 if app==4
replace gruppo=5 if app==5 |app==6
replace gruppo=6 if app==9 |app==16
replace gruppo=7 if app==10
replace gruppo=8 if app==11|app==12
replace gruppo=9 if app==13| app==14| app==15
label define gruppo  1"Economic-Statistics" 2"Scientific" 3"Biological" 4"Medical" 5"Engineering" 6"SocialScience" 7"Juridical" 8"Literary" 9"Psycho-pedagogical" 
label values gruppo gruppo
*creazione etichette per "tiplau"
label define tiplau 1"Ciclo_Unico/V.O." 2"Specialistica"  3"Triennale"
label values tiplau tiplau
*creazione etichette per "tipo_dipl"
rename l1_1 tipo_dipl
label define tipo_dipl 1"Liceo_Classico" 2"Liceo_Scientifico" 3"Liceo_Linguistico" 4"Liceo_Socio-Psico-Pedagogico" 5"Liceo_Artistico/Istituto_Arte" 6"Istituto_Tecnico" 7"Istituto_Professionale" 8"Scuola_Straniera"
label values tipo_dipl tipo_dipl
*master primo livello
gen master_i_2=0
replace master_i_2=1 if l1_32a==1|l1_32a==2
*master secondo livello	
gen master_ii_2=0
replace master_ii_2=1 if l1_32b==1|l1_32b==2
*magistrale
gen magistr_2=0
replace magistr_2=1 if l1_32c==1|l1_32c==2
*ciclo unico
gen ciclo_unic_2=0
replace ciclo_unic_2=1 if l1_32d==1|l1_32d==2
*triennale
gen trienn_2=0
replace trienn_2=1 if l1_32e==1|l1_32e==2
** creazione Variabili contesto familiare: 
*istruzione genitori: l5_4 l5_9
*istr_madre
gen istr_madre=.
replace istr_madre= 0 if l5_9==1 |l5_9==2
replace istr_madre= 1 if l5_9==3 |l5_9==6
replace istr_madre= 2 if l5_9==4 |l5_9==5
*istr_padre
gen istr_padre=.
replace istr_padre= 0 if l5_4==1 |l5_4==2
replace istr_padre= 1 if l5_4==3 |l5_4==6
replace istr_padre= 2 if l5_4==4 |l5_4==5
*istr_genitori
gen istr_genitori=.
replace istr_genitori=0 if istr_madre==0 & istr_padre==0
replace istr_genitori=1 if (istr_madre==1 & istr_padre==0) |(istr_madre==0 & istr_padre==1)
replace istr_genitori=2 if istr_madre==1 & istr_padre==1
replace istr_genitori=3 if (istr_madre==1 & istr_padre==2) |(istr_madre==2 & istr_padre==1)|(istr_madre==2 & istr_padre==0)| (istr_madre==0 & istr_padre==2)
replace istr_genitori=4 if istr_madre==2 & istr_padre==2

label define istr_genitori 0"entrambi max medie" 1"almeno uno diploma" 2"entrambi diplomati" 3"almeno un laureato" 4"entrambi laureati"
label values istr_genitori istr_genitori
tab istr_genitori
*occupazione genitori: l5_10 l5_5 
gen occ_genitori =0
replace occ_genitori=1 if (l5_11=="1" &l5_6=="1") | (l5_11=="0" &l5_6=="1")| (l5_11=="1" &l5_6=="0") 
replace occ_genitori=2 if (l5_11=="1" &l5_6=="2")| (l5_11=="0" &l5_6=="2") | (l5_11=="2" &l5_6=="1")| (l5_11=="2" &l5_6=="2") | (l5_11=="2" &l5_6=="0")
label define occ_genitori 0"entrambi pensionati/disoccupati" 1"almeno un dipendente" 2"almeno un autonomo"
label values occ_genitori occ_genitori

*time
tab mesi_i_lavoro
drop if mesi_i_lavoro=="-1"
encode mesi_i_lavoro, gen(time)
tab time
replace time=60 if mesi_i_lavoro== "  "
*event
gen event=1
replace event=0 if mesi_i_lavoro== "  "
rename progr id

**rename l2_64 
**al fine di accorpare collaborazione e prestazione/ assegno e borsa di ricerca genero la var "contratto"
tab l2_64

gen contratto=0
replace contratto=2 if (offerta==1)&(l2_64=="1"|l2_64=="5")
replace contratto=1 if  (offerta==1)& (l2_64=="2"|l2_64=="3" | l2_64=="4"|l2_64=="6" | l2_64=="7")
replace contratto=2 if (attuale==1)& (l2_6=="2" | (l2_6=="1" & l2_18=="2"))
replace contratto=1 if  (attuale==1)& (l2_6=="3"| l2_6=="4" | (l2_6=="2" &(l2_17=="2" | l2_18=="1")) )
replace contratto=1 if retri_form==1 
label define contratto 1"Determinato" 2"Indeterminato" 
label values contratto contratto
tab time contratto

drop if time==60& contratto!=0 /*eliminazione osservazioni con censura di tempo ma contratto di lavoro (?)*/
drop if time!=60 & contratto==0 /*eliminaazione osservazioni con tempo al 1 lavoro ma senza contratto di lavoro (?)*/

**** IMPORTANTE: il tipo di contratto risulta avere più di 23000 missing, 
**** guardando se i missing sono per coloro che non hanno mai lavorato 
**** (che sarebbe più che sensato) abbiamo riscontrato che 17 217 sono 
**** coloro che hanno event==1 ossia quelli che hanno lavorato.
**** Come li trattiamo per l'analisi a rischi competitivi??

**rename l2_71 contratto : è il tipo di lavoro che svolgeva a 1 anno dal conseguimento della laurea. direi che non ci interessa 
***perchè in l2_64 c'è il primo contratto di lavoro in assoluto.
***DESCRITTIVE
stset time, failure(contratto==2)

stcompet cuminc=ci, compet1(1)  by(gruppo)
gen cuminc11=cuminc if contratto==1 &gruppo==1
gen cuminc21=cuminc if contratto==2 & gruppo==1
gen cuminc12=cuminc if contratto==1 &gruppo==2
gen cuminc22=cuminc if contratto==2 & gruppo==2
gen cuminc13=cuminc if contratto==1 &gruppo==3
gen cuminc23=cuminc if contratto==2 & gruppo==3
gen cuminc14=cuminc if contratto==1 &gruppo==4
gen cuminc24=cuminc if contratto==2 & gruppo==4
gen cuminc15=cuminc if contratto==1 &gruppo==5
gen cuminc25=cuminc if contratto==2 & gruppo==5
gen cuminc16=cuminc if contratto==1 &gruppo==6
gen cuminc26=cuminc if contratto==2 & gruppo==6
gen cuminc17=cuminc if contratto==1 &gruppo==7
gen cuminc27=cuminc if contratto==2 & gruppo==7
gen cuminc18=cuminc if contratto==1 &gruppo==8
gen cuminc28=cuminc if contratto==2 & gruppo==8
gen cuminc19=cuminc if contratto==1 &gruppo==9
gen cuminc29=cuminc if contratto==2 & gruppo==9

twoway (line cuminc11 _t if contratto==1& gruppo==1, sort title("Economic-Statistics"))(line cuminc21 _t if contratto==2 & gruppo==1, sort title("Economic-Statistics")), legend(lab(1 "Fixed-term") lab(2 "Permanent")) ylabel(0(0.05)0.3)
twoway (line cuminc12 _t if contratto==1& gruppo==2, sort title("Scientific"))(line cuminc22 _t if contratto==2 & gruppo==2, sort title("Scientific")), legend(lab(1 "Fixed-term") lab(2 "Permanent"))ylabel(0(0.05)0.3)
twoway (line cuminc13 _t if contratto==1& gruppo==3, sort title("Biological"))(line cuminc23 _t if contratto==2 & gruppo==3, sort title("Biological")), legend(lab(1 "Fixed-term") lab(2 "Permanent"))ylabel(0(0.05)0.3)
twoway (line cuminc14 _t if contratto==1& gruppo==4, sort title("Medical"))(line cuminc24 _t if contratto==2 & gruppo==4, sort title("Medical")), legend(lab(1 "Fixed-term") lab(2 "Permanent"))ylabel(0(0.05)0.3)
twoway (line cuminc15 _t if contratto==1& gruppo==5, sort title("Engineering"))(line cuminc25 _t if contratto==2 & gruppo==5, sort title("Engineering")), legend(lab(1 "Fixed-term") lab(2 "Permanent"))ylabel(0(0.05)0.3)
twoway (line cuminc16 _t if contratto==1& gruppo==6, sort title("SocialScience"))(line cuminc26 _t if contratto==2 & gruppo==6, sort title("Social-Science")), legend(lab(1 "Fixed-term") lab(2 "Permanent"))ylabel(0(0.05)0.3)
twoway (line cuminc17 _t if contratto==1& gruppo==7, sort title("Juridical"))(line cuminc27 _t if contratto==2 & gruppo==7, sort title("Juridical")), legend(lab(1 "Fixed-term") lab(2 "Permanent"))ylabel(0(0.05)0.3)
twoway (line cuminc18 _t if contratto==1& gruppo==8, sort title("Literary"))(line cuminc28 _t if contratto==2 & gruppo==8, sort title("Literary")), legend(lab(1 "Fixed-term") lab(2 "Permanent"))ylabel(0(0.05)0.3)
twoway (line cuminc19 _t if contratto==1& gruppo==9, sort title("Psycho-Pedagogical"))(line cuminc29 _t if contratto==2 & gruppo==9, sort title("Psycho-Pedagigical")), legend(lab(1 "Fixed-term") lab(2 "Permanent"))ylabel(0(0.05)0.3)


/* DA CAMBIARE COME SOPRA
gen surv1= 1-cuminc1 if contratto==1
gen surv2= 1-cuminc2 if contratto==2
twoway (line surv1 _t if contratto==1, sort by(gruppo, compact) )(line surv2 _t if contratto==2, sort by(gruppo)), legend(lab(1 "Fixed-term") lab(2 "Permanent"))
*/
stcrreg ib3.gruppo, compete(contratto==1) nolog

stcurve, cif at1(gruppo=1) at2(gruppo=2) at3(gruppo=3) at4(gruppo=4) at5(gruppo=5) at6(gruppo=6) 


*** MODELLO PIECE-WISE CONTANT
tab time contratto


stset time,   failure(contratto) id(id)
expand 2
bysort id:gen type=_n


gen _dnew=0
replace _dnew=1 if type==contratto
replace _d=_dnew


stsplit time_int, at(0,6,12,18,24,30,36,42,48)
stptime, by(_t0)

streg  i.type i.time_int,d(e) nohr
streg i.type i.time_int i.gruppo, d(e) nohr
streg i.type i.time_int##ib3.tiplau i.gruppo, d(e) nohr

streg  i.type##i.gruppo ib3.tiplau##i.time_int  i.ita i.voto_lau i.privata i.ciclo_unic_2 i.trienn_2 i.magistr_2 i.master_i_2 i.master_ii_2 i.sesso ib2.tipo_dipl i.occ_genitori ib3.istr_genitori, d(e)


estat phtest, detail 
coefplot, xline(0) nolabels
coefplot, xline(0) keep(2.type 2.type#1.gruppo 2.type#2.gruppo 2.type#3.gruppo 2.type#4.gruppo 2.type#5.gruppo 2.type#6.gruppo 2.type#7.gruppo 2.type#8.gruppo 2.type#9.gruppo) title("Estimated coefficients for Field of education")
coefplot, xline(0) keep(6.time_int 12.time_int 18.time_int 24.time_int 30.time_int 36.time_int 42.time_int 48.time_int) title("Estimated coefficients for time intervals")
coefplot, xline(0) keep(1.ciclo_unic_2 1.trienn_2 1.magistr_2 1.master_i_2 1.master_ii_2 ) title("Estimated coefficients for continue the studings")
coefplot, xline(0) keep(1.ita 2.ita 3.ita 4.ita) title("Estimated coefficients for Grographiical area")


stcurve, survival at1(gruppo=1 type=1 )  at2(gruppo=1 type=2 ) legend(lab(1 "indeterminato") lab(2 " determinato") ) title(" Survival Economic Statistic")																						
stcurve, survival at1(gruppo=2 type=1 )  at2(gruppo=2 type=2 )legend(lab(1 "indeterminato") lab(2 " determinato") ) title(" Survival Scientific ")
stcurve, survival at1(gruppo=3 type=1 )  at2(gruppo=3 type=2 )legend(lab(1 "indeterminato") lab(2 " determinato") ) title(" Survival Biological")
stcurve, survival at1(gruppo=4 type=1 )  at2(gruppo=4 type=2 )legend(lab(1 "indeterminato") lab(2 " determinato") ) title(" Survival Medicaò")
stcurve, survival at1(gruppo=5 type=1 )  at2(gruppo=5 type=2 )legend(lab(1 "indeterminato") lab(2 " determinato") ) title(" Survival Engineering")
stcurve, survival at1(gruppo=6 type=1 )  at2(gruppo=6 type=2 )legend(lab(1 "indeterminato") lab(2 " determinato") ) title(" Survival SocialScience")
stcurve, survival at1(gruppo=7 type=1 )  at2(gruppo=7 type=2 )legend(lab(1 "indeterminato") lab(2 " determinato") ) title(" Survival juridical")
stcurve, survival at1(gruppo=8 type=1 )  at2(gruppo=8 type=2 )legend(lab(1 "indeterminato") lab(2 " determinato") ) title(" Survival Literary")
stcurve, survival at1(gruppo=9 type=1 )  at2(gruppo=9 type=2 )legend(lab(1 "indeterminato") lab(2 " determinato") ) title(" Survival Psycho-pedagogical")
**** OSSERVANDO CHE ALCUNE CELLE RISULTANO ESSERE VUOTE E CHE LE STIME NON SONO SIGNIFICATIVE
**** DECIDIAMO DI ANALIZZARE SOLO CONTRATTI DETERMINATI E INDETERMINATI:
**** - DETERMINATO = DETERMINATO, BORSA/ ASSEGNO DI RICERCA, PRESTAZIONE OCCASIONALE
**** - INDETERMINATO= INDETERMINATO, LAVORO AUTONOMO 


