EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 4
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Entry Wire Line
	3750 1600 3650 1700
Entry Wire Line
	3750 1700 3650 1800
Entry Wire Line
	3750 1800 3650 1900
Entry Wire Line
	3750 1900 3650 2000
Entry Wire Line
	3750 2000 3650 2100
Entry Wire Line
	3750 2100 3650 2200
Entry Wire Line
	3750 2200 3650 2300
Entry Wire Line
	3750 2300 3650 2400
Entry Wire Line
	3750 2400 3650 2500
Entry Wire Line
	3750 2500 3650 2600
Entry Wire Line
	3750 2600 3650 2700
Entry Wire Line
	3750 2700 3650 2800
Entry Wire Line
	3750 2800 3650 2900
Entry Wire Line
	3750 2900 3650 3000
Wire Wire Line
	4350 1600 3750 1600
Wire Wire Line
	4350 1700 3750 1700
Wire Wire Line
	4350 1800 3750 1800
Wire Wire Line
	4350 1900 3750 1900
Wire Wire Line
	4350 2000 3750 2000
Wire Wire Line
	4350 2100 3750 2100
Wire Wire Line
	4350 2200 3750 2200
Wire Wire Line
	4350 2300 3750 2300
Wire Wire Line
	4350 2400 3750 2400
Wire Wire Line
	4350 2500 3750 2500
Wire Wire Line
	4350 2600 3750 2600
Wire Wire Line
	4350 2700 3750 2700
Wire Wire Line
	4350 2800 3750 2800
Wire Wire Line
	4350 2900 3750 2900
Wire Wire Line
	4350 3000 3750 3000
Text Label 4200 1600 2    50   ~ 0
abus0
Text Label 4200 1700 2    50   ~ 0
abus1
Text Label 4200 1800 2    50   ~ 0
abus2
Text Label 4200 1900 2    50   ~ 0
abus3
Text Label 4200 2000 2    50   ~ 0
abus4
Text Label 4200 2100 2    50   ~ 0
abus5
Text Label 4200 2200 2    50   ~ 0
abus6
Text Label 4200 2300 2    50   ~ 0
abus7
Text Label 4200 2400 2    50   ~ 0
abus8
Text Label 4200 2500 2    50   ~ 0
abus9
Text Label 4200 2600 2    50   ~ 0
abus10
Text Label 4200 2700 2    50   ~ 0
abus11
Text Label 4200 2800 2    50   ~ 0
abus12
Text Label 4200 2900 2    50   ~ 0
abus13
Text Label 4200 3000 2    50   ~ 0
abus14
Entry Wire Line
	5850 1600 5950 1700
Entry Wire Line
	5850 1700 5950 1800
Entry Wire Line
	5850 1800 5950 1900
Entry Wire Line
	5850 1900 5950 2000
Entry Wire Line
	5850 2000 5950 2100
Entry Wire Line
	5850 2100 5950 2200
Entry Wire Line
	5850 2200 5950 2300
Entry Wire Line
	5850 2300 5950 2400
Text Label 5400 1600 0    50   ~ 0
dbus0
Text Label 5400 1700 0    50   ~ 0
dbus1
Text Label 5400 1800 0    50   ~ 0
dbus2
Text Label 5400 2000 0    50   ~ 0
dbus4
Text Label 5400 2100 0    50   ~ 0
dbus5
Text Label 5400 2200 0    50   ~ 0
dbus6
Text Label 5400 2300 0    50   ~ 0
dbus7
Wire Wire Line
	5350 1600 5850 1600
Wire Wire Line
	5350 1700 5850 1700
Wire Wire Line
	5350 1800 5850 1800
Wire Wire Line
	5350 1900 5850 1900
Wire Wire Line
	5350 2000 5850 2000
Wire Wire Line
	5350 2100 5850 2100
Wire Wire Line
	5350 2200 5850 2200
Wire Wire Line
	5350 2300 5850 2300
Text Label 5400 1900 0    50   ~ 0
dbus3
Text HLabel 3000 1400 0    50   BiDi ~ 0
abus[0..15]
Text HLabel 6500 1450 2    50   BiDi ~ 0
dbus[0..7]
$Comp
L Memory_RAM:CY62256-70PC U2
U 1 1 618AAC97
P 4850 2300
F 0 "U2" H 4850 3381 50  0000 C CNN
F 1 "CY62256-70PC" H 4850 3290 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W15.24mm" H 4850 2200 50  0001 C CNN
F 3 "https://ecee.colorado.edu/~mcclurel/Cypress_SRAM_CY62256.pdf" H 4850 2200 50  0001 C CNN
	1    4850 2300
	1    0    0    -1  
$EndComp
$Comp
L Memory_RAM:CY62256-70PC U3
U 1 1 618AB55C
P 4850 4500
F 0 "U3" H 4850 5581 50  0000 C CNN
F 1 "CY62256-70PC" H 4850 5490 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W15.24mm" H 4850 4400 50  0001 C CNN
F 3 "https://ecee.colorado.edu/~mcclurel/Cypress_SRAM_CY62256.pdf" H 4850 4400 50  0001 C CNN
	1    4850 4500
	1    0    0    -1  
$EndComp
Entry Wire Line
	5850 3800 5950 3900
Entry Wire Line
	5850 3900 5950 4000
Entry Wire Line
	5850 4000 5950 4100
Entry Wire Line
	5850 4100 5950 4200
Entry Wire Line
	5850 4200 5950 4300
Entry Wire Line
	5850 4300 5950 4400
Entry Wire Line
	5850 4400 5950 4500
Entry Wire Line
	5850 4500 5950 4600
Text Label 5400 3800 0    50   ~ 0
dbus0
Text Label 5400 3900 0    50   ~ 0
dbus1
Text Label 5400 4000 0    50   ~ 0
dbus2
Text Label 5400 4200 0    50   ~ 0
dbus4
Text Label 5400 4300 0    50   ~ 0
dbus5
Text Label 5400 4400 0    50   ~ 0
dbus6
Text Label 5400 4500 0    50   ~ 0
dbus7
Wire Wire Line
	5350 3800 5850 3800
Wire Wire Line
	5350 3900 5850 3900
Wire Wire Line
	5350 4000 5850 4000
Wire Wire Line
	5350 4100 5850 4100
Wire Wire Line
	5350 4200 5850 4200
Wire Wire Line
	5350 4300 5850 4300
Wire Wire Line
	5350 4400 5850 4400
Wire Wire Line
	5350 4500 5850 4500
Text Label 5400 4100 0    50   ~ 0
dbus3
Entry Wire Line
	3750 3000 3650 3100
Entry Wire Line
	3750 3800 3650 3900
Entry Wire Line
	3750 3900 3650 4000
Entry Wire Line
	3750 4000 3650 4100
Entry Wire Line
	3750 4100 3650 4200
Entry Wire Line
	3750 4200 3650 4300
Entry Wire Line
	3750 4300 3650 4400
Entry Wire Line
	3750 4400 3650 4500
Entry Wire Line
	3750 4500 3650 4600
Entry Wire Line
	3750 4600 3650 4700
Entry Wire Line
	3750 4700 3650 4800
Entry Wire Line
	3750 4800 3650 4900
Entry Wire Line
	3750 4900 3650 5000
Entry Wire Line
	3750 5000 3650 5100
Entry Wire Line
	3750 5100 3650 5200
Wire Wire Line
	4350 3800 3750 3800
Wire Wire Line
	4350 3900 3750 3900
Wire Wire Line
	4350 4000 3750 4000
Wire Wire Line
	4350 4100 3750 4100
Wire Wire Line
	4350 4200 3750 4200
Wire Wire Line
	4350 4300 3750 4300
Wire Wire Line
	4350 4400 3750 4400
Wire Wire Line
	4350 4500 3750 4500
Wire Wire Line
	4350 4600 3750 4600
Wire Wire Line
	4350 4700 3750 4700
Wire Wire Line
	4350 4800 3750 4800
Wire Wire Line
	4350 4900 3750 4900
Wire Wire Line
	4350 5000 3750 5000
Wire Wire Line
	4350 5100 3750 5100
Wire Wire Line
	4350 5200 3750 5200
Text Label 4200 3800 2    50   ~ 0
abus0
Text Label 4200 3900 2    50   ~ 0
abus1
Text Label 4200 4000 2    50   ~ 0
abus2
Text Label 4200 4100 2    50   ~ 0
abus3
Text Label 4200 4200 2    50   ~ 0
abus4
Text Label 4200 4300 2    50   ~ 0
abus5
Text Label 4200 4400 2    50   ~ 0
abus6
Text Label 4200 4500 2    50   ~ 0
abus7
Text Label 4200 4600 2    50   ~ 0
abus8
Text Label 4200 4700 2    50   ~ 0
abus9
Text Label 4200 4800 2    50   ~ 0
abus10
Text Label 4200 4900 2    50   ~ 0
abus11
Text Label 4200 5000 2    50   ~ 0
abus12
Text Label 4200 5100 2    50   ~ 0
abus13
Text Label 4200 5200 2    50   ~ 0
abus14
Entry Wire Line
	3750 5200 3650 5300
Wire Wire Line
	4850 1400 5350 1400
Wire Wire Line
	5350 1400 5350 1100
$Comp
L power:+5V #PWR0105
U 1 1 618BE574
P 5350 1100
F 0 "#PWR0105" H 5350 950 50  0001 C CNN
F 1 "+5V" H 5365 1273 50  0000 C CNN
F 2 "" H 5350 1100 50  0001 C CNN
F 3 "" H 5350 1100 50  0001 C CNN
	1    5350 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 3600 5300 3600
Wire Wire Line
	5300 3600 5300 3350
$Comp
L power:+5V #PWR0106
U 1 1 618BFDE1
P 5300 3350
F 0 "#PWR0106" H 5300 3200 50  0001 C CNN
F 1 "+5V" H 5315 3523 50  0000 C CNN
F 2 "" H 5300 3350 50  0001 C CNN
F 3 "" H 5300 3350 50  0001 C CNN
	1    5300 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 3200 4350 3200
Wire Wire Line
	4350 3200 4350 3350
$Comp
L power:GND #PWR0107
U 1 1 618C1552
P 4350 3350
F 0 "#PWR0107" H 4350 3100 50  0001 C CNN
F 1 "GND" H 4355 3177 50  0000 C CNN
F 2 "" H 4350 3350 50  0001 C CNN
F 3 "" H 4350 3350 50  0001 C CNN
	1    4350 3350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0108
U 1 1 618C1766
P 4850 5400
F 0 "#PWR0108" H 4850 5150 50  0001 C CNN
F 1 "GND" H 4855 5227 50  0000 C CNN
F 2 "" H 4850 5400 50  0001 C CNN
F 3 "" H 4850 5400 50  0001 C CNN
	1    4850 5400
	1    0    0    -1  
$EndComp
Text HLabel 2500 6200 0    50   Input ~ 0
mreq
Entry Wire Line
	3650 5350 3550 5450
Text Label 3550 5750 2    50   ~ 0
abus15
Wire Wire Line
	2500 6200 3150 6200
Wire Wire Line
	4500 6200 4500 6350
Connection ~ 4500 6200
Wire Wire Line
	3750 6200 4500 6200
Wire Wire Line
	3550 5800 4000 5800
Wire Wire Line
	3550 5450 3550 5800
Wire Wire Line
	4000 5800 4000 6500
Connection ~ 4000 5800
Wire Wire Line
	4000 5800 4100 5800
Wire Wire Line
	7900 7300 7950 7300
Text HLabel 6900 3400 2    50   Input ~ 0
rd
Text HLabel 6900 3550 2    50   Input ~ 0
wr
Wire Wire Line
	5350 2700 6750 2700
Wire Wire Line
	6750 2700 6750 3400
Wire Wire Line
	6750 3400 6900 3400
Wire Wire Line
	6900 3550 6700 3550
Wire Wire Line
	6700 3550 6700 2800
Wire Wire Line
	6700 2800 5350 2800
Wire Wire Line
	6700 3550 6700 5000
Wire Wire Line
	6700 5000 5350 5000
Connection ~ 6700 3550
Wire Wire Line
	6750 3400 6750 4900
Wire Wire Line
	6750 4900 5350 4900
Connection ~ 6750 3400
NoConn ~ 10550 5100
NoConn ~ 10550 5750
Text Label 6000 1450 0    50   ~ 0
dbus[0..7]
Wire Bus Line
	5950 1450 6500 1450
Text Label 3100 1400 0    50   ~ 0
abus[0..15]
Wire Bus Line
	3000 1400 3650 1400
$Comp
L 74xx:74HC14 U?
U 3 1 6175CB35
P 3450 6200
AR Path="/6173DF2A/6175CB35" Ref="U?"  Part="3" 
AR Path="/618A85E4/6175CB35" Ref="U12"  Part="3" 
F 0 "U12" H 3450 6517 50  0000 C CNN
F 1 "74HC14" H 3450 6426 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 3450 6200 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 3450 6200 50  0001 C CNN
	3    3450 6200
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U?
U 4 1 6175CB3B
P 4400 5800
AR Path="/6173DF2A/6175CB3B" Ref="U?"  Part="4" 
AR Path="/618A85E4/6175CB3B" Ref="U12"  Part="4" 
F 0 "U12" H 4400 6117 50  0000 C CNN
F 1 "74HC14" H 4400 6026 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 4400 5800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 4400 5800 50  0001 C CNN
	4    4400 5800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U?
U 5 1 6175CB41
P 6600 5800
AR Path="/6173DF2A/6175CB41" Ref="U?"  Part="5" 
AR Path="/618A85E4/6175CB41" Ref="U12"  Part="5" 
F 0 "U12" H 6600 6117 50  0000 C CNN
F 1 "74HC14" H 6600 6026 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 6600 5800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 6600 5800 50  0001 C CNN
	5    6600 5800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U?
U 6 1 6175CB47
P 6600 6350
AR Path="/6173DF2A/6175CB47" Ref="U?"  Part="6" 
AR Path="/618A85E4/6175CB47" Ref="U12"  Part="6" 
F 0 "U12" H 6600 6667 50  0000 C CNN
F 1 "74HC14" H 6600 6576 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 6600 6350 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 6600 6350 50  0001 C CNN
	6    6600 6350
	1    0    0    -1  
$EndComp
$Comp
L Analog_Switch:M52065 U4
U 1 1 6177F52A
P 5800 5350
F 0 "U4" H 5800 5631 50  0000 C CNN
F 1 "M52065" H 5800 5540 50  0000 C CNN
F 2 "Package_SO:SOP-16_3.9x9.9mm_P1.27mm" H 5800 5650 50  0001 C CNN
F 3 "" H 5800 5650 50  0001 C CNN
	1    5800 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 5650 5150 5650
Wire Wire Line
	5150 5650 5150 6200
Wire Wire Line
	5150 7550 5650 7550
Connection ~ 5650 7550
Wire Wire Line
	5650 7550 5800 7550
Connection ~ 5800 7550
Wire Wire Line
	5800 7550 5950 7550
$Comp
L power:GND #PWR0109
U 1 1 617A4FD0
P 5800 7550
F 0 "#PWR0109" H 5800 7300 50  0001 C CNN
F 1 "GND" H 5805 7377 50  0000 C CNN
F 2 "" H 5800 7550 50  0001 C CNN
F 3 "" H 5800 7550 50  0001 C CNN
	1    5800 7550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 6200 5150 6200
Connection ~ 5150 6200
Wire Wire Line
	5150 6200 5150 6750
Wire Wire Line
	5300 6750 5150 6750
Connection ~ 5150 6750
Wire Wire Line
	5150 6750 5150 6900
Wire Wire Line
	5800 5250 7050 5250
Wire Wire Line
	7050 5250 7050 5050
$Comp
L power:+5V #PWR0110
U 1 1 617B208B
P 7050 5050
F 0 "#PWR0110" H 7050 4900 50  0001 C CNN
F 1 "+5V" H 7065 5223 50  0000 C CNN
F 2 "" H 7050 5050 50  0001 C CNN
F 3 "" H 7050 5050 50  0001 C CNN
	1    7050 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4500 5950 4500 6200
Wire Wire Line
	4700 5800 5300 5800
Wire Wire Line
	4500 5950 5300 5950
Wire Wire Line
	4500 6350 5300 6350
Wire Wire Line
	4000 6500 5300 6500
Wire Wire Line
	5300 6900 5150 6900
Connection ~ 5150 6900
Wire Wire Line
	5150 6900 5150 7050
Wire Wire Line
	5150 7050 5300 7050
Connection ~ 5150 7050
Wire Wire Line
	5150 7050 5150 7550
Wire Wire Line
	6900 5800 7400 5800
Wire Wire Line
	7400 5800 7400 4700
Wire Wire Line
	5350 4700 7400 4700
Wire Wire Line
	6900 6350 7450 6350
Wire Wire Line
	7450 6350 7450 2500
Wire Wire Line
	5350 2500 7450 2500
Wire Bus Line
	5950 1450 5950 4600
Wire Bus Line
	3650 1400 3650 5400
$EndSCHEMATC
