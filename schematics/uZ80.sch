EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 8
Title ""
Date ""
Rev "1"
Comp "Sensik Co."
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Entry Wire Line
	6850 1700 6950 1800
Entry Wire Line
	6850 1800 6950 1900
Entry Wire Line
	6850 1900 6950 2000
Entry Wire Line
	6850 2000 6950 2100
Entry Wire Line
	6850 2100 6950 2200
Entry Wire Line
	6850 2200 6950 2300
Entry Wire Line
	6850 2300 6950 2400
Entry Wire Line
	6850 2400 6950 2500
Entry Wire Line
	6850 2500 6950 2600
Entry Wire Line
	6850 2600 6950 2700
Entry Wire Line
	6850 2700 6950 2800
Entry Wire Line
	6850 2800 6950 2900
Entry Wire Line
	6850 2900 6950 3000
Entry Wire Line
	6850 3000 6950 3100
Text Label 6450 1700 0    50   ~ 0
abus0
Text Label 6450 1800 0    50   ~ 0
abus1
Text Label 6450 1900 0    50   ~ 0
abus2
Text Label 6450 2000 0    50   ~ 0
abus3
Text Label 6450 2100 0    50   ~ 0
abus4
Text Label 6450 2200 0    50   ~ 0
abus5
Text Label 6450 2300 0    50   ~ 0
abus6
Text Label 6450 2400 0    50   ~ 0
abus7
Text Label 6450 2500 0    50   ~ 0
abus8
Text Label 6450 2600 0    50   ~ 0
abus9
Text Label 6450 2700 0    50   ~ 0
abus10
Text Label 6450 2800 0    50   ~ 0
abus11
Text Label 6450 2900 0    50   ~ 0
abus12
Wire Wire Line
	6450 1700 6850 1700
Wire Wire Line
	6450 1800 6850 1800
Wire Wire Line
	6450 1900 6850 1900
Wire Wire Line
	6450 2000 6850 2000
Wire Wire Line
	6450 2100 6850 2100
Wire Wire Line
	6450 2200 6850 2200
Wire Wire Line
	6450 2300 6850 2300
Wire Wire Line
	6450 2400 6850 2400
Wire Wire Line
	6450 2500 6850 2500
Wire Wire Line
	6450 2600 6850 2600
Wire Wire Line
	6450 2700 6850 2700
Wire Wire Line
	6450 2800 6850 2800
Wire Wire Line
	6450 2900 6850 2900
Wire Wire Line
	6450 3000 6850 3000
Wire Wire Line
	6450 3100 6850 3100
Text Label 6450 3100 0    50   ~ 0
abus14
Text Label 6450 3000 0    50   ~ 0
abus13
Entry Wire Line
	6850 3400 6950 3500
Entry Wire Line
	6850 3500 6950 3600
Entry Wire Line
	6850 3600 6950 3700
Entry Wire Line
	6850 3700 6950 3800
Entry Wire Line
	6850 3800 6950 3900
Entry Wire Line
	6850 3900 6950 4000
Entry Wire Line
	6850 4000 6950 4100
Entry Wire Line
	6850 4100 6950 4200
Wire Wire Line
	6450 3400 6850 3400
Wire Wire Line
	6450 3500 6850 3500
Wire Wire Line
	6450 3600 6850 3600
Wire Wire Line
	6450 3700 6850 3700
Wire Wire Line
	6450 3800 6850 3800
Wire Wire Line
	6450 3900 6850 3900
Wire Wire Line
	6450 4000 6850 4000
Wire Wire Line
	6450 4100 6850 4100
Text Label 6450 3400 0    50   ~ 0
dbus0
Text Label 6450 3500 0    50   ~ 0
dbus1
Text Label 6450 3600 0    50   ~ 0
dbus2
Text Label 6450 3700 0    50   ~ 0
dbus3
Text Label 6450 3800 0    50   ~ 0
dbus4
Text Label 6450 3900 0    50   ~ 0
dbus5
Text Label 6450 4000 0    50   ~ 0
dbus6
Text Label 6450 4100 0    50   ~ 0
dbus7
$Comp
L power:+5V #PWR0101
U 1 1 6166CA58
P 5750 700
F 0 "#PWR0101" H 5750 550 50  0001 C CNN
F 1 "+5V" H 5765 873 50  0000 C CNN
F 2 "" H 5750 700 50  0001 C CNN
F 3 "" H 5750 700 50  0001 C CNN
	1    5750 700 
	1    0    0    -1  
$EndComp
NoConn ~ 5050 2800
$Sheet
S 3250 1000 800  200 
U 6184A6B8
F0 "Clock Module" 50
F1 "clkmod.sch" 50
F2 "ctl_bus" I L 3250 1100 50 
$EndSheet
$Sheet
S 7550 2800 600  1000
U 618A271F
F0 "RAM" 50
F1 "ram.sch" 50
F2 "addr_bus" I L 7550 2950 50 
F3 "data_bus" B L 7550 3100 50 
F4 "OE" I L 7550 3400 50 
F5 "WE" I L 7550 3550 50 
F6 "MREQ" I L 7550 3700 50 
$EndSheet
Wire Wire Line
	5050 1700 5050 1100
$Comp
L Device:R R2
U 1 1 619006D1
P 5400 1100
F 0 "R2" V 5193 1100 50  0000 C CNN
F 1 "1k" V 5284 1100 50  0000 C CNN
F 2 "" V 5330 1100 50  0001 C CNN
F 3 "~" H 5400 1100 50  0001 C CNN
	1    5400 1100
	0    1    1    0   
$EndComp
Wire Wire Line
	5250 1100 5050 1100
Wire Wire Line
	5550 1100 5750 1100
Connection ~ 5750 1100
Wire Wire Line
	5750 1100 5750 1400
Wire Bus Line
	7500 3350 7500 3100
Wire Bus Line
	7500 3100 7550 3100
Connection ~ 6950 2950
Wire Wire Line
	5000 4450 7500 4450
Wire Wire Line
	7500 3400 7550 3400
Wire Wire Line
	4950 4500 7450 4500
Wire Wire Line
	7450 3550 7550 3550
Wire Wire Line
	4900 4550 7400 4550
Wire Wire Line
	7400 3700 7550 3700
Entry Wire Line
	6850 3100 6950 3200
$Sheet
S 650  700  550  550 
U 61AC3B1E
F0 "Control Display" 50
F1 "ctldisp.sch" 50
F2 "addr_bus" I R 1200 950 50 
F3 "data_bus" I R 1200 800 50 
F4 "ctl_bus" I R 1200 1100 50 
$EndSheet
Entry Wire Line
	3050 2100 3150 2000
Entry Wire Line
	3050 2800 3150 2700
Text Label 3150 2000 0    50   ~ 0
clk
Text Label 3150 2700 0    50   ~ 0
m1
Text Label 3150 3000 0    50   ~ 0
hlt
Text Label 3150 3600 0    50   ~ 0
mreq
Text Label 3150 3700 0    50   ~ 0
iorq
Text Label 3150 2900 0    50   ~ 0
wait
Text Label 3150 3400 0    50   ~ 0
rd
Text Label 3150 3500 0    50   ~ 0
wr
Entry Wire Line
	6950 3300 6850 3200
Text Label 6450 3200 0    50   ~ 0
abus15
$Comp
L power:GND #PWR0106
U 1 1 6168C7A1
P 5750 4850
F 0 "#PWR0106" H 5750 4600 50  0001 C CNN
F 1 "GND" H 5755 4677 50  0000 C CNN
F 2 "" H 5750 4850 50  0001 C CNN
F 3 "" H 5750 4850 50  0001 C CNN
	1    5750 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	7400 4550 7400 3700
Wire Wire Line
	7450 4500 7450 3550
Wire Wire Line
	7500 4450 7500 3400
Wire Wire Line
	5750 4400 5750 4850
$Comp
L Connector:Mini-DIN-6 J?
U 1 1 61EB14C0
P 1650 6450
AR Path="/61EA7498/61EB14C0" Ref="J?"  Part="1" 
AR Path="/61EB14C0" Ref="J?"  Part="1" 
F 0 "J?" H 1650 6817 50  0000 C CNN
F 1 "Mini-DIN-6" H 1650 6726 50  0000 C CNN
F 2 "" H 1650 6450 50  0001 C CNN
F 3 "http://service.powerdynamics.com/ec/Catalog17/Section%2011.pdf" H 1650 6450 50  0001 C CNN
	1    1650 6450
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 6350 1050 6350
Wire Wire Line
	1350 6550 1050 6550
NoConn ~ 1050 6550
NoConn ~ 1050 6350
Text Label 2000 6350 0    50   ~ 0
clk
Text Label 2000 6550 0    50   ~ 0
data
$Comp
L power:+5V #PWR?
U 1 1 61EB14CE
P 900 6250
AR Path="/61EA7498/61EB14CE" Ref="#PWR?"  Part="1" 
AR Path="/61EB14CE" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 900 6100 50  0001 C CNN
F 1 "+5V" H 915 6423 50  0000 C CNN
F 2 "" H 900 6250 50  0001 C CNN
F 3 "" H 900 6250 50  0001 C CNN
	1    900  6250
	1    0    0    -1  
$EndComp
Wire Wire Line
	900  6250 900  6450
Wire Wire Line
	900  6450 1350 6450
$Comp
L power:GND #PWR?
U 1 1 61EB14D6
P 2500 6700
AR Path="/61EA7498/61EB14D6" Ref="#PWR?"  Part="1" 
AR Path="/61EB14D6" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 2500 6450 50  0001 C CNN
F 1 "GND" H 2505 6527 50  0000 C CNN
F 2 "" H 2500 6700 50  0001 C CNN
F 3 "" H 2500 6700 50  0001 C CNN
	1    2500 6700
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 6450 2500 6700
Wire Wire Line
	1950 6450 2500 6450
Wire Notes Line
	800  5950 2700 5950
Wire Notes Line
	2700 5950 2700 7000
Wire Notes Line
	2700 7000 800  7000
Wire Notes Line
	800  7000 800  5950
Text Notes 850  6950 0    50   ~ 0
Keyboard Connector
$Sheet
S 3650 5400 1050 1250
U 6186885C
F0 "IO Controller" 50
F1 "ioctl.sch" 50
F2 "iorq" I L 3650 5500 50 
F3 "wait" I L 3650 5800 50 
F4 "addr_bus" I L 3650 5950 50 
F5 "data_bus" I L 3650 6100 50 
F6 "kb_clk" I L 3650 6350 50 
F7 "kb_data" I L 3650 6550 50 
F8 "MOSI" O R 4700 6400 50 
F9 "TFT_CS" O R 4700 6100 50 
F10 "SCK" O R 4700 6550 50 
F11 "TFT_A0" O R 4700 6250 50 
$EndSheet
$Comp
L CPU:Z80CPU U1
U 1 1 6159BC18
P 5750 2900
F 0 "U1" H 5750 4581 50  0000 C CNN
F 1 "Z80CPU" H 5750 4490 50  0001 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm_LongPads" H 5750 3300 50  0001 C CNN
F 3 "www.zilog.com/manage_directlink.php?filepath=docs/z80/um0080" H 5750 3300 50  0001 C CNN
	1    5750 2900
	1    0    0    -1  
$EndComp
$Sheet
S 6050 5500 850  800 
U 620107E7
F0 "RAM Uploader" 50
F1 "pgm.sch" 50
F2 "busrq" O R 6900 5600 50 
F3 "busack" I L 6050 5600 50 
F4 "dbus" O R 6900 5750 50 
F5 "abus" O R 6900 5900 50 
F6 "wr" O R 6900 6050 50 
F7 "rd" O R 6900 6200 50 
$EndSheet
Wire Wire Line
	4850 5250 4850 4000
Wire Wire Line
	4850 4000 5050 4000
Wire Wire Line
	7500 6050 7500 4450
Connection ~ 7500 4450
Wire Wire Line
	7450 6200 7450 4500
Connection ~ 7450 4500
Wire Wire Line
	3150 2000 5050 2000
Wire Wire Line
	3150 2700 5050 2700
Wire Wire Line
	3150 3000 5050 3000
Entry Wire Line
	3050 3100 3150 3000
Wire Wire Line
	3150 3600 4900 3600
Wire Wire Line
	3150 3700 3600 3700
Wire Wire Line
	3150 2900 3550 2900
Entry Wire Line
	3050 3000 3150 2900
Entry Wire Line
	3050 3700 3150 3600
Entry Wire Line
	3050 3800 3150 3700
Entry Wire Line
	3050 3500 3150 3400
Entry Wire Line
	3050 3600 3150 3500
Wire Wire Line
	3150 3500 4950 3500
Wire Wire Line
	3150 3400 5000 3400
Wire Wire Line
	5000 4450 5000 3400
Connection ~ 5000 3400
Wire Wire Line
	5000 3400 5050 3400
Wire Wire Line
	4950 4500 4950 3500
Connection ~ 4950 3500
Wire Wire Line
	4950 3500 5050 3500
Wire Wire Line
	4900 4550 4900 3600
Connection ~ 4900 3600
Wire Wire Line
	4900 3600 5050 3600
Entry Wire Line
	3050 2400 3150 2300
Entry Wire Line
	3050 2500 3150 2400
Wire Wire Line
	3150 2400 5050 2400
Wire Wire Line
	3150 2300 5050 2300
Text Label 3150 2300 0    50   ~ 0
nmi
Text Label 3150 2400 0    50   ~ 0
irq
Connection ~ 4850 4000
Wire Wire Line
	4850 4000 3150 4000
Entry Wire Line
	3050 4100 3150 4000
Wire Wire Line
	5050 4100 4800 4100
Entry Wire Line
	3050 4200 3150 4100
Text Label 3150 4000 0    50   ~ 0
busrq
Text Label 3150 4100 0    50   ~ 0
busack
Wire Wire Line
	6900 5600 7000 5600
Wire Bus Line
	6950 5750 6900 5750
Wire Wire Line
	3650 5500 3600 5500
Wire Wire Line
	3600 5500 3600 3700
Connection ~ 3600 3700
Wire Wire Line
	3600 3700 5050 3700
Wire Wire Line
	3650 5800 3550 5800
Wire Wire Line
	3550 5800 3550 2900
Connection ~ 3550 2900
Wire Wire Line
	3550 2900 5050 2900
Wire Bus Line
	7000 3350 7000 800 
Wire Wire Line
	5750 700  5750 1100
Wire Bus Line
	6950 3350 7000 3350
Connection ~ 7000 3350
Wire Bus Line
	7000 3350 7500 3350
Wire Bus Line
	6900 5900 7050 5900
Wire Wire Line
	7000 5600 7000 5250
Wire Wire Line
	7000 5250 4850 5250
Wire Bus Line
	6950 2950 7050 2950
Wire Bus Line
	7050 5900 7050 2950
Connection ~ 7050 2950
Wire Bus Line
	7050 2950 7550 2950
Wire Wire Line
	6900 6050 7500 6050
Wire Wire Line
	7450 6200 6900 6200
Wire Bus Line
	1200 800  3000 800 
Wire Bus Line
	1200 950  1250 950 
Wire Bus Line
	1250 950  1250 850 
Wire Bus Line
	1200 1100 3050 1100
Wire Bus Line
	3050 1100 3250 1100
Connection ~ 3050 1100
Connection ~ 3000 800 
Wire Bus Line
	3000 800  7000 800 
Wire Bus Line
	3000 800  3000 6100
Wire Bus Line
	1250 850  2950 850 
Connection ~ 2950 850 
Wire Bus Line
	2950 850  6950 850 
Wire Wire Line
	6450 3200 6850 3200
Wire Wire Line
	4800 4100 4800 5300
Wire Wire Line
	4800 5300 6000 5300
Wire Wire Line
	6000 5300 6000 5600
Wire Wire Line
	6000 5600 6050 5600
Connection ~ 4800 4100
Wire Wire Line
	4800 4100 3150 4100
Wire Wire Line
	1950 6350 3650 6350
Wire Wire Line
	1950 6550 3650 6550
Wire Bus Line
	3000 6100 3650 6100
Wire Bus Line
	2950 5950 3650 5950
Wire Bus Line
	2950 850  2950 5950
Text Notes 700  1450 0    50   ~ 0
TODO: update
$Sheet
S 4900 6000 1050 700 
U 616D86A4
F0 "TFT Display 128x160" 50
F1 "tft.sch" 50
F2 "CS" I L 4900 6100 50 
F3 "A0" I L 4900 6250 50 
F4 "MOSI" I L 4900 6400 50 
F5 "SCK" I L 4900 6550 50 
$EndSheet
Wire Wire Line
	4700 6100 4900 6100
Wire Wire Line
	4700 6250 4900 6250
Wire Wire Line
	4900 6400 4700 6400
Wire Wire Line
	4700 6550 4900 6550
Wire Bus Line
	6950 2950 6950 3300
Wire Bus Line
	6950 3350 6950 5750
Wire Bus Line
	6950 850  6950 2950
Wire Bus Line
	3050 1100 3050 4250
$EndSCHEMATC
