EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 8
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 1200 3400 0    50   BiDi ~ 0
ctlbus[0..12]
Text HLabel 1200 3600 0    50   BiDi ~ 0
abus[0..15]
Text HLabel 1200 3800 0    50   BiDi ~ 0
dbus[0..7]
$Comp
L power:GND #PWR025
U 1 1 61AB0ECB
P 5250 5800
F 0 "#PWR025" H 5250 5550 50  0001 C CNN
F 1 "GND" H 5255 5627 50  0000 C CNN
F 2 "" H 5250 5800 50  0001 C CNN
F 3 "" H 5250 5800 50  0001 C CNN
	1    5250 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 5800 5250 5450
Text HLabel 1600 4550 0    50   Input ~ 0
kb_clk
Text HLabel 1600 4750 0    50   Input ~ 0
kb_data
Wire Bus Line
	1200 3400 1700 3400
Text HLabel 7700 4450 2    50   Input ~ 0
pc_vcom_rx
Text HLabel 7700 5650 2    50   Output ~ 0
hexdisp_mosi
Text HLabel 7700 5550 2    50   Output ~ 0
hexdisp_cs
Text Label 1350 3600 0    50   ~ 0
abus[0..15]
Text Label 1250 3800 0    50   ~ 0
dbus[0..7]
Text Label 1250 3400 0    50   ~ 0
ctlbus[0..12]
Text HLabel 7700 4550 2    50   Output ~ 0
pc_vcom_tx
Text HLabel 8650 4250 2    50   Output ~ 0
scl
Text HLabel 8650 4350 2    50   BiDi ~ 0
sda
Wire Wire Line
	8450 3950 8450 3800
Wire Wire Line
	8050 3800 8050 3900
Wire Wire Line
	8050 4200 8050 4350
$Comp
L Device:R R7
U 1 1 616EF414
P 8050 4050
F 0 "R7" H 8120 4096 50  0001 L CNN
F 1 "4.7k" H 8120 4050 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" V 7980 4050 50  0001 C CNN
F 3 "~" H 8050 4050 50  0001 C CNN
	1    8050 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 4350 8650 4350
Wire Wire Line
	8050 3800 8250 3800
Wire Wire Line
	8250 3800 8250 3600
Connection ~ 8250 3800
Wire Wire Line
	8250 3800 8450 3800
$Comp
L power:+5V #PWR027
U 1 1 61704157
P 8250 3600
F 0 "#PWR027" H 8250 3450 50  0001 C CNN
F 1 "+5V" H 8265 3773 50  0000 C CNN
F 2 "" H 8250 3600 50  0001 C CNN
F 3 "" H 8250 3600 50  0001 C CNN
	1    8250 3600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 6170479C
P 8450 4100
F 0 "R8" H 8520 4146 50  0001 L CNN
F 1 "4.7k" H 8520 4100 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" V 8380 4100 50  0001 C CNN
F 3 "~" H 8450 4100 50  0001 C CNN
	1    8450 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8450 4250 8650 4250
Wire Bus Line
	1950 650  7300 650 
Wire Bus Line
	6700 7700 4100 7700
Wire Bus Line
	6650 7650 3500 7650
Wire Bus Line
	2000 700  6700 700 
$Comp
L MCU_ST_STM32F0:STM32F072C8Tx U9
U 1 1 616F3711
P 5300 3650
F 0 "U9" H 5250 2061 50  0000 C CNN
F 1 "STM32F072C8Tx" H 5250 1970 50  0000 C CNN
F 2 "Package_QFP:LQFP-48_7x7mm_P0.5mm" H 4700 2250 50  0001 R CNN
F 3 "http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/DM00090510.pdf" H 5300 3650 50  0001 C CNN
	1    5300 3650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5900 3850 7100 3850
Wire Wire Line
	7100 3850 7100 5550
Wire Wire Line
	7100 5550 7700 5550
Wire Wire Line
	7050 4150 7050 5650
Wire Wire Line
	7050 5650 7700 5650
Wire Wire Line
	5900 4150 7050 4150
Wire Wire Line
	5100 5150 5100 5450
Wire Wire Line
	5100 5450 5200 5450
Wire Wire Line
	5200 5150 5200 5450
Connection ~ 5200 5450
Wire Wire Line
	5200 5450 5250 5450
Wire Wire Line
	5400 5150 5400 5450
Wire Wire Line
	5400 5450 5300 5450
Connection ~ 5250 5450
Wire Wire Line
	5300 5150 5300 5450
Connection ~ 5300 5450
Wire Wire Line
	5300 5450 5250 5450
$Comp
L power:+3.3V #PWR026
U 1 1 616F6645
P 5300 1700
F 0 "#PWR026" H 5300 1550 50  0001 C CNN
F 1 "+3.3V" H 5315 1873 50  0000 C CNN
F 2 "" H 5300 1700 50  0001 C CNN
F 3 "" H 5300 1700 50  0001 C CNN
	1    5300 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 1700 5200 1700
Wire Wire Line
	5200 2150 5200 1700
Connection ~ 5200 1700
Wire Wire Line
	5200 1700 5100 1700
Wire Wire Line
	5300 2150 5300 1700
Connection ~ 5300 1700
Wire Wire Line
	5400 2150 5400 1700
Wire Wire Line
	5400 1700 5300 1700
Wire Wire Line
	5500 2150 5500 1700
Wire Wire Line
	5500 1700 5400 1700
Connection ~ 5400 1700
Wire Wire Line
	4600 2550 4100 2550
$Comp
L power:GND #PWR024
U 1 1 616F95FE
P 4100 2550
F 0 "#PWR024" H 4100 2300 50  0001 C CNN
F 1 "GND" H 4105 2377 50  0000 C CNN
F 2 "" H 4100 2550 50  0001 C CNN
F 3 "" H 4100 2550 50  0001 C CNN
	1    4100 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 616FA2A1
P 4400 2200
F 0 "R6" H 4470 2246 50  0000 L CNN
F 1 "R" H 4470 2155 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" V 4330 2200 50  0001 C CNN
F 3 "~" H 4400 2200 50  0001 C CNN
	1    4400 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 2350 4400 2350
Wire Wire Line
	4400 2050 5100 2050
Wire Wire Line
	5100 1700 5100 2050
Connection ~ 5100 2050
Wire Wire Line
	5100 2050 5100 2150
Wire Wire Line
	2200 2750 2200 4550
Wire Wire Line
	1600 4750 2250 4750
Wire Wire Line
	2250 4750 2250 2850
Wire Bus Line
	1200 3600 2900 3600
Wire Wire Line
	2200 4550 1600 4550
Wire Wire Line
	2250 2850 4600 2850
Wire Wire Line
	2200 2750 4600 2750
Wire Bus Line
	2900 3600 2900 3100
Wire Bus Line
	2900 3100 3450 3100
Entry Wire Line
	3450 3350 3550 3450
Wire Wire Line
	3550 3450 4600 3450
Entry Wire Line
	3450 3450 3550 3550
Wire Wire Line
	3550 3550 4600 3550
Entry Wire Line
	3450 3550 3550 3650
Wire Wire Line
	3550 3650 4600 3650
Entry Wire Line
	3450 3650 3550 3750
Wire Wire Line
	3550 3750 4600 3750
Entry Wire Line
	3450 3750 3550 3850
Wire Wire Line
	3550 3850 4600 3850
Entry Wire Line
	3450 3850 3550 3950
Wire Wire Line
	3550 3950 4600 3950
Entry Wire Line
	3450 3950 3550 4050
Wire Wire Line
	3550 4050 4600 4050
Entry Wire Line
	3450 4050 3550 4150
Wire Wire Line
	3550 4150 4600 4150
Entry Wire Line
	3450 4150 3550 4250
Wire Wire Line
	3550 4250 4600 4250
Entry Wire Line
	3450 4250 3550 4350
Wire Wire Line
	3550 4350 4600 4350
Entry Wire Line
	3450 4350 3550 4450
Wire Wire Line
	3550 4450 4600 4450
Entry Wire Line
	3450 4450 3550 4550
Wire Wire Line
	3550 4550 4600 4550
Entry Wire Line
	3450 4550 3550 4650
Wire Wire Line
	3550 4650 4600 4650
Entry Wire Line
	3450 4650 3550 4750
Wire Wire Line
	3550 4750 4600 4750
Entry Wire Line
	3450 4750 3550 4850
Wire Wire Line
	3550 4850 4600 4850
Entry Wire Line
	3450 4850 3550 4950
Wire Wire Line
	3550 4950 4600 4950
Text Label 3900 3450 0    50   ~ 0
abus0
Text Label 3900 3550 0    50   ~ 0
abus1
Text Label 3900 3650 0    50   ~ 0
abus2
Text Label 3900 3750 0    50   ~ 0
abus3
Text Label 3900 3850 0    50   ~ 0
abus4
Text Label 3900 3950 0    50   ~ 0
abus5
Text Label 3900 4050 0    50   ~ 0
abus6
Text Label 3900 4150 0    50   ~ 0
abus7
Text Label 3900 4250 0    50   ~ 0
abus8
Text Label 3900 4350 0    50   ~ 0
abus9
Text Label 3900 4450 0    50   ~ 0
abus10
Text Label 3900 4550 0    50   ~ 0
abus11
Text Label 3900 4650 0    50   ~ 0
abus12
Text Label 3900 4750 0    50   ~ 0
abus13
Text Label 3900 4850 0    50   ~ 0
abus14
Text Label 3900 4950 0    50   ~ 0
abus15
Wire Bus Line
	3400 3800 3400 6150
Wire Bus Line
	3400 6150 6850 6150
Wire Bus Line
	1200 3800 3400 3800
Entry Wire Line
	6750 4250 6850 4350
Wire Wire Line
	6750 4250 5900 4250
Entry Wire Line
	6750 4350 6850 4450
Wire Wire Line
	6750 4350 5900 4350
Entry Wire Line
	6750 4450 6850 4550
Wire Wire Line
	6750 4450 5900 4450
Entry Wire Line
	6750 4550 6850 4650
Wire Wire Line
	6750 4550 5900 4550
Entry Wire Line
	6750 4650 6850 4750
Wire Wire Line
	6750 4650 5900 4650
Entry Wire Line
	6750 4750 6850 4850
Wire Wire Line
	6750 4750 5900 4750
Entry Wire Line
	6750 4850 6850 4950
Wire Wire Line
	6750 4850 5900 4850
Entry Wire Line
	6750 4950 6850 5050
Wire Wire Line
	6750 4950 5900 4950
Text Label 6200 4250 0    50   ~ 0
dbus0
Text Label 6200 4350 0    50   ~ 0
dbus1
Text Label 6200 4450 0    50   ~ 0
dbus2
Text Label 6200 4550 0    50   ~ 0
dbus3
Text Label 6200 4650 0    50   ~ 0
dbus4
Text Label 6200 4750 0    50   ~ 0
dbus5
Text Label 6200 4850 0    50   ~ 0
dbus6
Text Label 6200 4950 0    50   ~ 0
dbus7
Wire Wire Line
	7700 4550 7150 4550
Wire Wire Line
	7150 4550 7150 3450
Wire Wire Line
	7150 3450 5900 3450
Wire Wire Line
	7700 4450 7200 4450
Wire Wire Line
	7200 4450 7200 3550
Wire Wire Line
	7200 3550 5900 3550
Text HLabel 7700 5750 2    50   Output ~ 0
hexdisp_clk
Wire Wire Line
	7700 5750 7000 5750
Wire Wire Line
	7000 5750 7000 3950
Wire Wire Line
	7000 3950 5900 3950
Wire Bus Line
	6850 4200 6850 6150
Wire Bus Line
	3450 3100 3450 5100
$EndSCHEMATC
