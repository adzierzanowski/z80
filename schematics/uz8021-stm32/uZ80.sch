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
	7100 1800 7200 1900
Entry Wire Line
	7100 1900 7200 2000
Entry Wire Line
	7100 2000 7200 2100
Entry Wire Line
	7100 2100 7200 2200
Entry Wire Line
	7100 2200 7200 2300
Entry Wire Line
	7100 2300 7200 2400
Entry Wire Line
	7100 2400 7200 2500
Entry Wire Line
	7100 2500 7200 2600
Text Label 6750 1800 0    50   ~ 0
abus0
Text Label 6750 1900 0    50   ~ 0
abus1
Text Label 6750 2000 0    50   ~ 0
abus2
Text Label 6750 2100 0    50   ~ 0
abus3
Text Label 6750 2200 0    50   ~ 0
abus4
Text Label 6750 2300 0    50   ~ 0
abus5
Text Label 6750 2400 0    50   ~ 0
abus6
Text Label 6750 2500 0    50   ~ 0
abus7
Text Label 6750 2600 0    50   ~ 0
abus8
Text Label 6750 2700 0    50   ~ 0
abus9
Text Label 6750 2800 0    50   ~ 0
abus10
Text Label 6750 2900 0    50   ~ 0
abus11
Text Label 6750 3000 0    50   ~ 0
abus12
Wire Wire Line
	6700 1800 7100 1800
Wire Wire Line
	6700 1900 7100 1900
Wire Wire Line
	6700 2000 7100 2000
Wire Wire Line
	6700 2100 7100 2100
Wire Wire Line
	6700 2200 7100 2200
Wire Wire Line
	6700 2300 7100 2300
Wire Wire Line
	6700 2400 7100 2400
Wire Wire Line
	6700 2500 7100 2500
Wire Wire Line
	6700 2600 7100 2600
Wire Wire Line
	6700 2700 7100 2700
Wire Wire Line
	6700 2800 7100 2800
Wire Wire Line
	6700 2900 7100 2900
Wire Wire Line
	6700 3000 7100 3000
Wire Wire Line
	6700 3100 7100 3100
Wire Wire Line
	6700 3200 7100 3200
Text Label 6750 3200 0    50   ~ 0
abus14
Text Label 6750 3100 0    50   ~ 0
abus13
Entry Wire Line
	7300 3500 7400 3600
Entry Wire Line
	7300 3600 7400 3700
Entry Wire Line
	7300 3700 7400 3800
Entry Wire Line
	7300 3800 7400 3900
Entry Wire Line
	7300 3900 7400 4000
Entry Wire Line
	7300 4000 7400 4100
Entry Wire Line
	7300 4100 7400 4200
Entry Wire Line
	7300 4200 7400 4300
Text Label 6750 3500 0    50   ~ 0
dbus0
Text Label 6750 3600 0    50   ~ 0
dbus1
Text Label 6750 3700 0    50   ~ 0
dbus2
Text Label 6750 3800 0    50   ~ 0
dbus3
Text Label 6750 3900 0    50   ~ 0
dbus4
Text Label 6750 4000 0    50   ~ 0
dbus5
Text Label 6750 4100 0    50   ~ 0
dbus6
Text Label 6750 4200 0    50   ~ 0
dbus7
$Comp
L power:+5V #PWR03
U 1 1 6166CA58
P 6000 800
F 0 "#PWR03" H 6000 650 50  0001 C CNN
F 1 "+5V" H 6015 973 50  0000 C CNN
F 2 "" H 6000 800 50  0001 C CNN
F 3 "" H 6000 800 50  0001 C CNN
	1    6000 800 
	1    0    0    -1  
$EndComp
NoConn ~ 5300 2900
$Sheet
S 3500 1100 800  500 
U 6184A6B8
F0 "Clock Module" 50
F1 "clkmod.sch" 50
F2 "pc_vcom_rx" I L 3500 1350 50 
F3 "pc_vcom_tx" O L 3500 1500 50 
F4 "ctlbus[0..12]" B L 3500 1200 50 
$EndSheet
$Sheet
S 7600 4250 650  550 
U 618A271F
F0 "RAM" 50
F1 "ram.sch" 50
F2 "dbus[0..7]" B L 7600 4350 50 
F3 "abus[0..15]" I L 7600 4500 50 
F4 "ctlbus[0..12]" I L 7600 4650 50 
$EndSheet
Wire Wire Line
	5300 1800 5300 1200
$Comp
L Device:R R1
U 1 1 619006D1
P 5650 1200
F 0 "R1" V 5443 1200 50  0000 C CNN
F 1 "1k" V 5534 1200 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" V 5580 1200 50  0001 C CNN
F 3 "~" H 5650 1200 50  0001 C CNN
	1    5650 1200
	0    1    1    0   
$EndComp
Wire Wire Line
	5500 1200 5300 1200
Wire Wire Line
	5800 1200 6000 1200
Connection ~ 6000 1200
Wire Wire Line
	6000 1200 6000 1500
Entry Wire Line
	3300 2200 3400 2100
Entry Wire Line
	3300 2900 3400 2800
Text Label 3400 2100 0    50   ~ 0
clk
Text Label 3400 2800 0    50   ~ 0
m1
Text Label 3400 3100 0    50   ~ 0
hlt
Text Label 3400 3700 0    50   ~ 0
mreq
Text Label 3400 3800 0    50   ~ 0
iorq
Text Label 3400 3000 0    50   ~ 0
wait
Text Label 3400 3500 0    50   ~ 0
rd
Text Label 3400 3600 0    50   ~ 0
wr
Text Label 6750 3300 0    50   ~ 0
abus15
$Comp
L power:GND #PWR04
U 1 1 6168C7A1
P 6500 4950
F 0 "#PWR04" H 6500 4700 50  0001 C CNN
F 1 "GND" H 6505 4777 50  0000 C CNN
F 2 "" H 6500 4950 50  0001 C CNN
F 3 "" H 6500 4950 50  0001 C CNN
	1    6500 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 4500 6500 4950
$Comp
L Connector:Mini-DIN-6 J?
U 1 1 61EB14C0
P 1900 7100
AR Path="/61EA7498/61EB14C0" Ref="J?"  Part="1" 
AR Path="/61EB14C0" Ref="J1"  Part="1" 
F 0 "J1" H 1900 7467 50  0000 C CNN
F 1 "Mini-DIN-6" H 1900 7376 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 1900 7100 50  0001 C CNN
F 3 "http://service.powerdynamics.com/ec/Catalog17/Section%2011.pdf" H 1900 7100 50  0001 C CNN
	1    1900 7100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 7000 1300 7000
Wire Wire Line
	1600 7200 1300 7200
NoConn ~ 1300 7200
NoConn ~ 1300 7000
Text Label 2250 7000 0    50   ~ 0
kb_clk
Text Label 2250 7200 0    50   ~ 0
kb_data
$Comp
L power:+5V #PWR?
U 1 1 61EB14CE
P 1150 6900
AR Path="/61EA7498/61EB14CE" Ref="#PWR?"  Part="1" 
AR Path="/61EB14CE" Ref="#PWR01"  Part="1" 
F 0 "#PWR01" H 1150 6750 50  0001 C CNN
F 1 "+5V" H 1165 7073 50  0000 C CNN
F 2 "" H 1150 6900 50  0001 C CNN
F 3 "" H 1150 6900 50  0001 C CNN
	1    1150 6900
	1    0    0    -1  
$EndComp
Wire Wire Line
	1150 6900 1150 7100
Wire Wire Line
	1150 7100 1600 7100
$Comp
L power:GND #PWR?
U 1 1 61EB14D6
P 2750 7350
AR Path="/61EA7498/61EB14D6" Ref="#PWR?"  Part="1" 
AR Path="/61EB14D6" Ref="#PWR02"  Part="1" 
F 0 "#PWR02" H 2750 7100 50  0001 C CNN
F 1 "GND" H 2755 7177 50  0000 C CNN
F 2 "" H 2750 7350 50  0001 C CNN
F 3 "" H 2750 7350 50  0001 C CNN
	1    2750 7350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2750 7100 2750 7350
Wire Wire Line
	2200 7100 2750 7100
Wire Notes Line
	1050 6600 2950 6600
Wire Notes Line
	2950 6600 2950 7650
Wire Notes Line
	2950 7650 1050 7650
Wire Notes Line
	1050 7650 1050 6600
Text Notes 1100 7600 0    50   ~ 0
Keyboard Connector
Wire Wire Line
	3400 2100 5300 2100
Wire Wire Line
	3400 2800 5300 2800
Wire Wire Line
	3400 3100 5300 3100
Entry Wire Line
	3300 3200 3400 3100
Entry Wire Line
	3300 3100 3400 3000
Entry Wire Line
	3300 3800 3400 3700
Entry Wire Line
	3300 3900 3400 3800
Entry Wire Line
	3300 3600 3400 3500
Entry Wire Line
	3300 3700 3400 3600
Entry Wire Line
	3300 2500 3400 2400
Entry Wire Line
	3300 2600 3400 2500
Wire Wire Line
	3400 2500 5300 2500
Wire Wire Line
	3400 2400 5300 2400
Text Label 3400 2400 0    50   ~ 0
nmi
Text Label 3400 2500 0    50   ~ 0
irq
Entry Wire Line
	3300 4200 3400 4100
Entry Wire Line
	3300 4300 3400 4200
Text Label 3400 4100 0    50   ~ 0
busrq
Text Label 3400 4200 0    50   ~ 0
busack
Wire Wire Line
	6000 800  6000 1200
Wire Bus Line
	1450 1050 1500 1050
Wire Bus Line
	1500 1050 1500 950 
Wire Bus Line
	1450 1200 3300 1200
Wire Bus Line
	3300 1200 3500 1200
Connection ~ 3300 1200
Wire Wire Line
	6700 3300 7100 3300
Wire Wire Line
	2200 7000 3900 7000
Wire Wire Line
	2200 7200 3900 7200
$Sheet
S 5200 5500 1050 350 
U 616D86A4
F0 "TFT Display Module" 50
F1 "tft.sch" 50
F2 "scl" I L 5200 5600 50 
F3 "sda" B L 5200 5750 50 
$EndSheet
$Sheet
S 3900 5500 1000 1800
U 6186885C
F0 "IO & Bus Controller" 50
F1 "ioctl.sch" 50
F2 "kb_clk" I L 3900 7000 50 
F3 "kb_data" I L 3900 7200 50 
F4 "hexdisp_mosi" O R 4900 6400 50 
F5 "hexdisp_clk" O R 4900 6550 50 
F6 "hexdisp_cs" O R 4900 6700 50 
F7 "dbus[0..7]" B L 3900 5900 50 
F8 "pc_vcom_rx" I L 3900 6050 50 
F9 "pc_vcom_tx" O L 3900 6200 50 
F10 "ctlbus[0..12]" B L 3900 5600 50 
F11 "scl" O R 4900 5600 50 
F12 "sda" B R 4900 5750 50 
F13 "abus[0..15]" B L 3900 5750 50 
$EndSheet
Wire Wire Line
	3400 4100 5300 4100
Wire Wire Line
	3400 3000 5300 3000
Wire Wire Line
	3400 3800 5300 3800
Wire Wire Line
	3400 4200 5300 4200
Wire Bus Line
	3300 5600 3900 5600
Wire Bus Line
	3250 5750 3900 5750
Wire Bus Line
	3200 5900 3900 5900
$Comp
L CPU:Z80CPU U1
U 1 1 6159BC18
P 6000 3000
F 0 "U1" H 6000 4681 50  0000 C CNN
F 1 "Z80CPU" H 6000 4590 50  0001 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm_LongPads" H 6000 3400 50  0001 C CNN
F 3 "www.zilog.com/manage_directlink.php?filepath=docs/z80/um0080" H 6000 3400 50  0001 C CNN
	1    6000 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 3700 5300 3700
Wire Wire Line
	3400 3600 5300 3600
Wire Wire Line
	3400 3500 5300 3500
Wire Wire Line
	6700 3500 7300 3500
Wire Wire Line
	6700 3600 7300 3600
Wire Wire Line
	6700 3700 7300 3700
Wire Wire Line
	6700 3800 7300 3800
Wire Wire Line
	6700 3900 7300 3900
Wire Wire Line
	6700 4000 7300 4000
Wire Wire Line
	6700 4100 7300 4100
Wire Wire Line
	6700 4200 7300 4200
Wire Bus Line
	7400 4350 7600 4350
Wire Bus Line
	7200 4500 7600 4500
Wire Bus Line
	7600 4650 3300 4650
Connection ~ 3300 4650
Wire Bus Line
	3300 4650 3300 5600
$Sheet
S 800  800  650  550 
U 61AC3B1E
F0 "Binary LED Display" 50
F1 "bindisp.sch" 50
F2 "abus[0..15]" I R 1450 1050 50 
F3 "dbus[0..7]" I R 1450 900 50 
F4 "ctlbus[0..12]" I R 1450 1200 50 
$EndSheet
$Sheet
S 5200 6300 1050 500 
U 618C35CA
F0 "Hexadecimal Display" 50
F1 "hexdisp.sch" 50
F2 "hexclk" I L 5200 6550 50 
F3 "hexcs" I L 5200 6700 50 
F4 "hexmosi" I L 5200 6400 50 
$EndSheet
Wire Wire Line
	4900 6400 5200 6400
Wire Wire Line
	4900 6550 5200 6550
Wire Wire Line
	4900 6700 5200 6700
Text Label 1500 900  0    50   ~ 0
dbus[0..7]
Text Label 2150 950  3    50   ~ 0
abus[0..15]
Text Label 3700 2100 0    50   ~ 0
ctlbus0
Text Label 3700 2400 0    50   ~ 0
ctlbus1
Text Label 3700 2500 0    50   ~ 0
ctlbus2
Text Label 3700 2800 0    50   ~ 0
ctlbus3
Text Label 3700 3000 0    50   ~ 0
ctlbus4
Text Label 3700 3100 0    50   ~ 0
ctlbus5
Text Label 3700 3500 0    50   ~ 0
ctlbus6
Text Label 3700 3600 0    50   ~ 0
ctlbus7
Text Label 3700 3700 0    50   ~ 0
ctlbus8
Text Label 3700 3800 0    50   ~ 0
ctlbus9
Text Label 3700 4100 0    50   ~ 0
ctlbus10
Text Label 3700 4200 0    50   ~ 0
ctlbus11
Text Label 1500 1200 0    50   ~ 0
ctlbus[0..12]
Wire Wire Line
	3500 1500 3150 1500
Wire Wire Line
	3500 1350 3100 1350
Wire Wire Line
	3100 1350 3100 6200
Wire Wire Line
	3100 6200 3900 6200
Wire Wire Line
	3150 6050 3900 6050
Wire Wire Line
	3150 1500 3150 6050
Entry Wire Line
	3300 1900 3400 1800
Wire Wire Line
	5300 1800 3400 1800
Connection ~ 5300 1800
Text Label 3700 1800 0    50   ~ 0
ctlbus12
Text Label 3400 1800 0    50   ~ 0
rst
Wire Wire Line
	4900 5600 4950 5600
Wire Wire Line
	4900 5750 5000 5750
Entry Wire Line
	7100 2600 7200 2700
Entry Wire Line
	7100 2700 7200 2800
Entry Wire Line
	7100 2800 7200 2900
Entry Wire Line
	7100 2900 7200 3000
Entry Wire Line
	7100 3000 7200 3100
Entry Wire Line
	7100 3100 7200 3200
Entry Wire Line
	7100 3200 7200 3300
Entry Wire Line
	7100 3300 7200 3400
$Sheet
S 5200 4900 1050 350 
U 6170A126
F0 "EEPROM module" 50
F1 "eeprom.sch" 50
F2 "scl" I L 5200 5000 50 
F3 "sda" B L 5200 5150 50 
$EndSheet
Wire Wire Line
	6000 4500 6500 4500
Wire Wire Line
	5200 5000 4950 5000
Wire Wire Line
	4950 5000 4950 5600
Connection ~ 4950 5600
Wire Wire Line
	4950 5600 5200 5600
Wire Wire Line
	5200 5150 5000 5150
Wire Wire Line
	5000 5150 5000 5750
Connection ~ 5000 5750
Wire Wire Line
	5000 5750 5200 5750
Wire Bus Line
	1450 900  3200 900 
Wire Bus Line
	3250 950  3250 5750
Connection ~ 3250 950 
Wire Bus Line
	3250 950  7200 950 
Wire Bus Line
	1500 950  3250 950 
Wire Bus Line
	3200 900  3200 5900
Connection ~ 3200 900 
Wire Bus Line
	3200 900  7400 900 
Wire Bus Line
	7400 900  7400 4350
Wire Bus Line
	3300 1200 3300 4650
Wire Bus Line
	7200 950  7200 4500
$EndSCHEMATC