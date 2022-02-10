EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 7 8
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	3450 1500 3200 1500
Wire Wire Line
	3200 1600 3450 1600
Wire Wire Line
	3200 1700 3450 1700
Wire Wire Line
	3450 1800 3200 1800
Wire Wire Line
	3200 1900 3450 1900
Wire Wire Line
	3450 2000 3200 2000
Wire Wire Line
	3200 2100 3450 2100
Text Label 3250 1500 0    50   ~ 0
a
Text Label 3250 1600 0    50   ~ 0
b
Text Label 3250 1700 0    50   ~ 0
c
Text Label 3250 1800 0    50   ~ 0
d
Text Label 3250 1900 0    50   ~ 0
e
Text Label 3250 2000 0    50   ~ 0
f
Text Label 3250 2100 0    50   ~ 0
g
$Comp
L power:GND #PWR032
U 1 1 6264D609
P 2800 3300
F 0 "#PWR032" H 2800 3050 50  0001 C CNN
F 1 "GND" H 2805 3127 50  0000 C CNN
F 2 "" H 2800 3300 50  0001 C CNN
F 3 "" H 2800 3300 50  0001 C CNN
	1    2800 3300
	1    0    0    -1  
$EndComp
$Comp
L Driver_LED:MAX7219 U10
U 1 1 625AE56E
P 2800 2300
F 0 "U10" H 2800 3481 50  0000 C CNN
F 1 "MAX7219" H 2800 3390 50  0000 C CNN
F 2 "Package_DIP:DIP-24_W7.62mm_Socket_LongPads" H 2750 2350 50  0001 C CNN
F 3 "https://datasheets.maximintegrated.com/en/ds/MAX7219-MAX7221.pdf" H 2850 2150 50  0001 C CNN
	1    2800 2300
	1    0    0    -1  
$EndComp
Entry Wire Line
	3450 1500 3550 1400
Entry Wire Line
	3450 1600 3550 1500
Entry Wire Line
	3450 1700 3550 1600
Entry Wire Line
	3450 1800 3550 1700
Entry Wire Line
	3450 1900 3550 1800
Entry Wire Line
	3450 2000 3550 1900
Entry Wire Line
	3450 2100 3550 2000
Text HLabel 2050 3000 0    50   Input ~ 0
hexclk
Text HLabel 2050 2900 0    50   Input ~ 0
hexcs
Wire Wire Line
	2050 2900 2400 2900
Wire Wire Line
	2050 3100 2400 3100
$Comp
L Device:R R44
U 1 1 61980748
P 2250 1500
F 0 "R44" V 2043 1500 50  0001 C CNN
F 1 "47k" V 2135 1500 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" V 2180 1500 50  0001 C CNN
F 3 "~" H 2250 1500 50  0001 C CNN
	1    2250 1500
	0    1    1    0   
$EndComp
Wire Wire Line
	2100 1300 2100 1100
$Comp
L power:+5V #PWR031
U 1 1 626541D3
P 2100 1100
F 0 "#PWR031" H 2100 950 50  0001 C CNN
F 1 "+5V" H 2115 1273 50  0000 C CNN
F 2 "" H 2100 1100 50  0001 C CNN
F 3 "" H 2100 1100 50  0001 C CNN
	1    2100 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 1300 2100 1300
Wire Wire Line
	2100 1300 2100 1500
Connection ~ 2100 1300
Wire Wire Line
	2400 3000 2050 3000
Wire Wire Line
	3200 2200 3450 2200
Text Label 3250 2200 0    50   ~ 0
dp
Entry Wire Line
	3450 2200 3550 2100
Text Label 4750 4600 0    50   ~ 0
dp
Wire Wire Line
	4750 4650 4750 4500
Entry Wire Line
	4750 4650 4850 4750
Wire Wire Line
	4850 3800 4850 3900
Wire Wire Line
	4750 3800 4850 3800
Wire Wire Line
	4850 3900 4750 3900
Entry Wire Line
	3550 4500 3650 4400
Entry Wire Line
	3550 4400 3650 4300
Entry Wire Line
	3550 4300 3650 4200
Entry Wire Line
	3550 4200 3650 4100
Entry Wire Line
	3550 4100 3650 4000
Entry Wire Line
	3550 4000 3650 3900
Entry Wire Line
	3550 3900 3650 3800
$Comp
L Display_Character:LTS-6980HR AFF1
U 1 1 625AE562
P 4250 4200
F 0 "AFF1" H 4250 4867 50  0000 C CNN
F 1 "LTS-6980HR" H 4250 4776 50  0000 C CNN
F 2 "Display_7Segment:7SegmentLED_LTS6760_LTS6780" H 4250 3600 50  0001 C CNN
F 3 "http://datasheet.octopart.com/LTS-6960HR-Lite-On-datasheet-11803242.pdf" H 4250 4200 50  0001 C CNN
	1    4250 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 4400 3750 4400
Wire Wire Line
	3650 4300 3750 4300
Wire Wire Line
	3650 4200 3750 4200
Wire Wire Line
	3650 4100 3750 4100
Wire Wire Line
	3650 4000 3750 4000
Wire Wire Line
	3650 3900 3750 3900
Wire Wire Line
	3650 3800 3750 3800
Text Label 3650 4400 0    50   ~ 0
g
Text Label 3650 4300 0    50   ~ 0
f
Text Label 3650 4200 0    50   ~ 0
e
Text Label 3650 4100 0    50   ~ 0
d
Text Label 3650 4000 0    50   ~ 0
c
Text Label 3650 3900 0    50   ~ 0
b
Text Label 3650 3800 0    50   ~ 0
a
Text Label 6250 4600 0    50   ~ 0
dp
Wire Wire Line
	6250 4650 6250 4500
Entry Wire Line
	6250 4650 6350 4750
Wire Wire Line
	6350 3800 6350 3900
Wire Wire Line
	6250 3800 6350 3800
Wire Wire Line
	6350 3900 6250 3900
Entry Wire Line
	5050 4500 5150 4400
Entry Wire Line
	5050 4400 5150 4300
Entry Wire Line
	5050 4300 5150 4200
Entry Wire Line
	5050 4200 5150 4100
Entry Wire Line
	5050 4100 5150 4000
Entry Wire Line
	5050 4000 5150 3900
Entry Wire Line
	5050 3900 5150 3800
$Comp
L Display_Character:LTS-6980HR AFF3
U 1 1 61998635
P 5750 4200
F 0 "AFF3" H 5750 4867 50  0000 C CNN
F 1 "LTS-6980HR" H 5750 4776 50  0000 C CNN
F 2 "Display_7Segment:7SegmentLED_LTS6760_LTS6780" H 5750 3600 50  0001 C CNN
F 3 "http://datasheet.octopart.com/LTS-6960HR-Lite-On-datasheet-11803242.pdf" H 5750 4200 50  0001 C CNN
	1    5750 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 4400 5250 4400
Wire Wire Line
	5150 4300 5250 4300
Wire Wire Line
	5150 4200 5250 4200
Wire Wire Line
	5150 4100 5250 4100
Wire Wire Line
	5150 4000 5250 4000
Wire Wire Line
	5150 3900 5250 3900
Wire Wire Line
	5150 3800 5250 3800
Text Label 5150 4400 0    50   ~ 0
g
Text Label 5150 4300 0    50   ~ 0
f
Text Label 5150 4200 0    50   ~ 0
e
Text Label 5150 4100 0    50   ~ 0
d
Text Label 5150 4000 0    50   ~ 0
c
Text Label 5150 3900 0    50   ~ 0
b
Text Label 5150 3800 0    50   ~ 0
a
Text Label 7750 4600 0    50   ~ 0
dp
Wire Wire Line
	7750 4650 7750 4500
Entry Wire Line
	7750 4650 7850 4750
Wire Wire Line
	7850 3800 7850 3900
Wire Wire Line
	7750 3800 7850 3800
Wire Wire Line
	7850 3900 7750 3900
Entry Wire Line
	6550 4500 6650 4400
Entry Wire Line
	6550 4400 6650 4300
Entry Wire Line
	6550 4300 6650 4200
Entry Wire Line
	6550 4200 6650 4100
Entry Wire Line
	6550 4100 6650 4000
Entry Wire Line
	6550 4000 6650 3900
Entry Wire Line
	6550 3900 6650 3800
$Comp
L Display_Character:LTS-6980HR AFF5
U 1 1 61999E47
P 7250 4200
F 0 "AFF5" H 7250 4867 50  0000 C CNN
F 1 "LTS-6980HR" H 7250 4776 50  0000 C CNN
F 2 "Display_7Segment:7SegmentLED_LTS6760_LTS6780" H 7250 3600 50  0001 C CNN
F 3 "http://datasheet.octopart.com/LTS-6960HR-Lite-On-datasheet-11803242.pdf" H 7250 4200 50  0001 C CNN
	1    7250 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 4400 6750 4400
Wire Wire Line
	6650 4300 6750 4300
Wire Wire Line
	6650 4200 6750 4200
Wire Wire Line
	6650 4100 6750 4100
Wire Wire Line
	6650 4000 6750 4000
Wire Wire Line
	6650 3900 6750 3900
Wire Wire Line
	6650 3800 6750 3800
Text Label 6650 4400 0    50   ~ 0
g
Text Label 6650 4300 0    50   ~ 0
f
Text Label 6650 4200 0    50   ~ 0
e
Text Label 6650 4100 0    50   ~ 0
d
Text Label 6650 4000 0    50   ~ 0
c
Text Label 6650 3900 0    50   ~ 0
b
Text Label 6650 3800 0    50   ~ 0
a
Text Label 9250 4600 0    50   ~ 0
dp
Wire Wire Line
	9250 4650 9250 4500
Entry Wire Line
	9250 4650 9350 4750
Wire Wire Line
	9350 3800 9350 3900
Wire Wire Line
	9250 3800 9350 3800
Wire Wire Line
	9350 3900 9250 3900
Entry Wire Line
	8050 4500 8150 4400
Entry Wire Line
	8050 4400 8150 4300
Entry Wire Line
	8050 4300 8150 4200
Entry Wire Line
	8050 4200 8150 4100
Entry Wire Line
	8050 4100 8150 4000
Entry Wire Line
	8050 4000 8150 3900
Entry Wire Line
	8050 3900 8150 3800
$Comp
L Display_Character:LTS-6980HR AFF6
U 1 1 6199C03A
P 8750 4200
F 0 "AFF6" H 8750 4867 50  0000 C CNN
F 1 "LTS-6980HR" H 8750 4776 50  0000 C CNN
F 2 "Display_7Segment:7SegmentLED_LTS6760_LTS6780" H 8750 3600 50  0001 C CNN
F 3 "http://datasheet.octopart.com/LTS-6960HR-Lite-On-datasheet-11803242.pdf" H 8750 4200 50  0001 C CNN
	1    8750 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 4400 8250 4400
Wire Wire Line
	8150 4300 8250 4300
Wire Wire Line
	8150 4200 8250 4200
Wire Wire Line
	8150 4100 8250 4100
Wire Wire Line
	8150 4000 8250 4000
Wire Wire Line
	8150 3900 8250 3900
Wire Wire Line
	8150 3800 8250 3800
Text Label 8150 4400 0    50   ~ 0
g
Text Label 8150 4300 0    50   ~ 0
f
Text Label 8150 4200 0    50   ~ 0
e
Text Label 8150 4100 0    50   ~ 0
d
Text Label 8150 4000 0    50   ~ 0
c
Text Label 8150 3900 0    50   ~ 0
b
Text Label 8150 3800 0    50   ~ 0
a
Text Label 4750 6600 0    50   ~ 0
dp
Wire Wire Line
	4750 6650 4750 6500
Entry Wire Line
	4750 6650 4850 6750
Wire Wire Line
	4850 5800 4850 5900
Wire Wire Line
	4750 5800 4850 5800
Wire Wire Line
	4850 5900 4750 5900
Entry Wire Line
	3550 6500 3650 6400
Entry Wire Line
	3550 6400 3650 6300
Entry Wire Line
	3550 6300 3650 6200
Entry Wire Line
	3550 6200 3650 6100
Entry Wire Line
	3550 6100 3650 6000
Entry Wire Line
	3550 6000 3650 5900
Entry Wire Line
	3550 5900 3650 5800
$Comp
L Display_Character:LTS-6980HR AFF2
U 1 1 6199E640
P 4250 6200
F 0 "AFF2" H 4250 6867 50  0000 C CNN
F 1 "LTS-6980HR" H 4250 6776 50  0000 C CNN
F 2 "Display_7Segment:7SegmentLED_LTS6760_LTS6780" H 4250 5600 50  0001 C CNN
F 3 "http://datasheet.octopart.com/LTS-6960HR-Lite-On-datasheet-11803242.pdf" H 4250 6200 50  0001 C CNN
	1    4250 6200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 6400 3750 6400
Wire Wire Line
	3650 6300 3750 6300
Wire Wire Line
	3650 6200 3750 6200
Wire Wire Line
	3650 6100 3750 6100
Wire Wire Line
	3650 6000 3750 6000
Wire Wire Line
	3650 5900 3750 5900
Wire Wire Line
	3650 5800 3750 5800
Text Label 3650 6400 0    50   ~ 0
g
Text Label 3650 6300 0    50   ~ 0
f
Text Label 3650 6200 0    50   ~ 0
e
Text Label 3650 6100 0    50   ~ 0
d
Text Label 3650 6000 0    50   ~ 0
c
Text Label 3650 5900 0    50   ~ 0
b
Text Label 3650 5800 0    50   ~ 0
a
Text Label 6250 6600 0    50   ~ 0
dp
Wire Wire Line
	6250 6650 6250 6500
Entry Wire Line
	6250 6650 6350 6750
Wire Wire Line
	6350 5800 6350 5900
Wire Wire Line
	6250 5800 6350 5800
Wire Wire Line
	6350 5900 6250 5900
Entry Wire Line
	5050 6500 5150 6400
Entry Wire Line
	5050 6400 5150 6300
Entry Wire Line
	5050 6300 5150 6200
Entry Wire Line
	5050 6200 5150 6100
Entry Wire Line
	5050 6100 5150 6000
Entry Wire Line
	5050 6000 5150 5900
Entry Wire Line
	5050 5900 5150 5800
$Comp
L Display_Character:LTS-6980HR AFF4
U 1 1 619A155D
P 5750 6200
F 0 "AFF4" H 5750 6867 50  0000 C CNN
F 1 "LTS-6980HR" H 5750 6776 50  0000 C CNN
F 2 "Display_7Segment:7SegmentLED_LTS6760_LTS6780" H 5750 5600 50  0001 C CNN
F 3 "http://datasheet.octopart.com/LTS-6960HR-Lite-On-datasheet-11803242.pdf" H 5750 6200 50  0001 C CNN
	1    5750 6200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 6400 5250 6400
Wire Wire Line
	5150 6300 5250 6300
Wire Wire Line
	5150 6200 5250 6200
Wire Wire Line
	5150 6100 5250 6100
Wire Wire Line
	5150 6000 5250 6000
Wire Wire Line
	5150 5900 5250 5900
Wire Wire Line
	5150 5800 5250 5800
Text Label 5150 6400 0    50   ~ 0
g
Text Label 5150 6300 0    50   ~ 0
f
Text Label 5150 6200 0    50   ~ 0
e
Text Label 5150 6100 0    50   ~ 0
d
Text Label 5150 6000 0    50   ~ 0
c
Text Label 5150 5900 0    50   ~ 0
b
Text Label 5150 5800 0    50   ~ 0
a
Connection ~ 5050 4750
Connection ~ 6550 4750
Connection ~ 8050 4750
Connection ~ 3550 4750
Connection ~ 5050 6750
Wire Wire Line
	3200 2300 4850 2300
Wire Wire Line
	4850 2300 4850 3800
Connection ~ 4850 3800
Wire Wire Line
	3200 2400 6350 2400
Wire Wire Line
	6350 2400 6350 3800
Connection ~ 6350 3800
Wire Wire Line
	3200 2500 7850 2500
Wire Wire Line
	7850 2500 7850 3800
Connection ~ 7850 3800
Wire Wire Line
	3200 2600 9350 2600
Wire Wire Line
	9350 2600 9350 3800
Connection ~ 9350 3800
Wire Wire Line
	3200 2700 3500 2700
Wire Wire Line
	3500 2700 3500 5350
Wire Wire Line
	3500 5350 4850 5350
Wire Wire Line
	4850 5350 4850 5800
Connection ~ 4850 5800
Wire Wire Line
	3200 2800 3450 2800
Wire Wire Line
	3450 2800 3450 5400
Wire Wire Line
	3450 5400 6350 5400
Wire Wire Line
	6350 5400 6350 5800
Connection ~ 6350 5800
NoConn ~ 3200 3100
NoConn ~ 3200 3000
NoConn ~ 3200 2900
Wire Bus Line
	5050 6750 6350 6750
Wire Bus Line
	8050 4750 9350 4750
Wire Notes Line width 8 rgb(194, 0, 0)
	9450 3450 9450 5000
Wire Notes Line width 8 rgb(194, 0, 0)
	9450 5000 3300 5000
Wire Notes Line width 8 rgb(194, 0, 0)
	3300 5000 3300 3450
Wire Notes Line width 8 rgb(194, 0, 0)
	3300 3450 9450 3450
Text Notes 8950 4950 0    50   ~ 0
Address Bus
Wire Notes Line width 8
	6450 5450 6450 7000
Wire Notes Line width 8
	6450 7000 3300 7000
Wire Notes Line width 8
	3300 7000 3300 5450
Wire Notes Line width 8
	3300 5450 6450 5450
Text Notes 6050 6950 0    50   ~ 0
Data Bus
Text HLabel 2050 3100 0    50   Input ~ 0
hexmosi
Wire Bus Line
	3550 4750 5050 4750
Wire Bus Line
	5050 4750 6550 4750
Wire Bus Line
	6550 4750 8050 4750
Wire Bus Line
	3550 6750 5050 6750
Wire Bus Line
	5050 3900 5050 4750
Wire Bus Line
	6550 3900 6550 4750
Wire Bus Line
	8050 3900 8050 4750
Wire Bus Line
	5050 5900 5050 6750
Wire Bus Line
	3550 4750 3550 6750
Wire Bus Line
	3550 1400 3550 4750
$EndSCHEMATC
