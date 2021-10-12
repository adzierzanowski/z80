EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 6 8
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 1200 2800 0    50   Input ~ 0
iorq
Text HLabel 1200 3400 0    50   Input ~ 0
wait
$Comp
L MCU_Microchip_ATmega:ATmega2560-16AU U?
U 1 1 61A13D92
P 5400 4150
F 0 "U?" H 5400 1161 50  0000 C CNN
F 1 "ATmega2560-16AU" H 5400 1070 50  0000 C CNN
F 2 "Package_QFP:TQFP-100_14x14mm_P0.5mm" H 5400 4150 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2549-8-bit-AVR-Microcontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf" H 5400 4150 50  0001 C CNN
	1    5400 4150
	1    0    0    -1  
$EndComp
Text HLabel 1200 3600 0    50   Input ~ 0
addr_bus
Text HLabel 1200 3800 0    50   BiDi ~ 0
data_bus
Entry Wire Line
	6700 1650 6600 1550
Entry Wire Line
	6700 1750 6600 1650
Entry Wire Line
	6700 1850 6600 1750
Entry Wire Line
	6700 1950 6600 1850
Entry Wire Line
	6700 2050 6600 1950
Entry Wire Line
	6700 2150 6600 2050
Entry Wire Line
	6700 2250 6600 2150
Entry Wire Line
	6700 2350 6600 2250
Text Label 6600 1550 2    50   ~ 0
abus0
Text Label 6600 1650 2    50   ~ 0
abus1
Text Label 6600 1750 2    50   ~ 0
abus2
Text Label 6600 1850 2    50   ~ 0
abus3
Text Label 6600 1950 2    50   ~ 0
abus4
Text Label 6600 2050 2    50   ~ 0
abus5
Text Label 6600 2150 2    50   ~ 0
abus6
Text Label 6600 2250 2    50   ~ 0
abus7
Wire Wire Line
	6600 1550 6200 1550
Wire Wire Line
	6600 1650 6200 1650
Wire Wire Line
	6600 1750 6200 1750
Wire Wire Line
	6600 1850 6200 1850
Wire Wire Line
	6600 1950 6200 1950
Wire Wire Line
	6600 2050 6200 2050
Wire Wire Line
	6600 2150 6200 2150
Wire Wire Line
	6600 2250 6200 2250
Wire Bus Line
	1200 3800 1950 3800
Entry Wire Line
	6700 4050 6600 3950
Entry Wire Line
	6700 3950 6600 3850
Entry Wire Line
	6700 3850 6600 3750
Entry Wire Line
	6700 3750 6600 3650
Entry Wire Line
	6700 3650 6600 3550
Entry Wire Line
	6700 3550 6600 3450
Entry Wire Line
	6700 3450 6600 3350
Entry Wire Line
	6700 4150 6600 4050
Wire Wire Line
	6200 4050 6600 4050
Wire Wire Line
	6200 3950 6600 3950
Wire Wire Line
	6200 3850 6600 3850
Wire Wire Line
	6200 3750 6600 3750
Wire Wire Line
	6200 3650 6600 3650
Wire Wire Line
	6200 3550 6600 3550
Wire Wire Line
	6200 3450 6600 3450
Wire Wire Line
	6200 3350 6600 3350
Text Label 6300 4050 0    50   ~ 0
dbus0
Text Label 6300 3950 0    50   ~ 0
dbus1
Text Label 6300 3850 0    50   ~ 0
dbus2
Text Label 6300 3750 0    50   ~ 0
dbus3
Text Label 6300 3650 0    50   ~ 0
dbus4
Text Label 6300 3550 0    50   ~ 0
dbus5
Text Label 6300 3450 0    50   ~ 0
dbus6
Text Label 6300 3350 0    50   ~ 0
dbus7
$Comp
L power:+5V #PWR?
U 1 1 61AAE7F6
P 5400 1050
F 0 "#PWR?" H 5400 900 50  0001 C CNN
F 1 "+5V" H 5415 1223 50  0000 C CNN
F 2 "" H 5400 1050 50  0001 C CNN
F 3 "" H 5400 1050 50  0001 C CNN
	1    5400 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 1050 5400 1100
Wire Wire Line
	5500 1250 5500 1100
Wire Wire Line
	5500 1100 5400 1100
Connection ~ 5400 1100
Wire Wire Line
	5400 1100 5400 1250
$Comp
L power:GND #PWR?
U 1 1 61AB0ECB
P 5400 7400
F 0 "#PWR?" H 5400 7150 50  0001 C CNN
F 1 "GND" H 5405 7227 50  0000 C CNN
F 2 "" H 5400 7400 50  0001 C CNN
F 3 "" H 5400 7400 50  0001 C CNN
	1    5400 7400
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 7400 5400 7050
$Comp
L Device:Crystal Y?
U 1 1 61AB5E62
P 3750 1900
AR Path="/6184A6B8/61AB5E62" Ref="Y?"  Part="1" 
AR Path="/6186885C/61AB5E62" Ref="Y?"  Part="1" 
F 0 "Y?" V 3796 1769 50  0000 R CNN
F 1 "16 MHz" V 3705 1769 50  0000 R CNN
F 2 "" H 3750 1900 50  0001 C CNN
F 3 "~" H 3750 1900 50  0001 C CNN
	1    3750 1900
	0    1    1    0   
$EndComp
$Comp
L Device:C C?
U 1 1 61AB5E68
P 3450 2200
AR Path="/6184A6B8/61AB5E68" Ref="C?"  Part="1" 
AR Path="/6186885C/61AB5E68" Ref="C?"  Part="1" 
F 0 "C?" H 3565 2246 50  0000 L CNN
F 1 "22 pF" H 3565 2155 50  0000 L CNN
F 2 "" H 3488 2050 50  0001 C CNN
F 3 "~" H 3450 2200 50  0001 C CNN
	1    3450 2200
	-1   0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 61AB5E6E
P 3450 1600
AR Path="/6184A6B8/61AB5E6E" Ref="C?"  Part="1" 
AR Path="/6186885C/61AB5E6E" Ref="C?"  Part="1" 
F 0 "C?" H 3565 1646 50  0000 L CNN
F 1 "22 pF" H 3565 1555 50  0000 L CNN
F 2 "" H 3488 1450 50  0001 C CNN
F 3 "~" H 3450 1600 50  0001 C CNN
	1    3450 1600
	-1   0    0    1   
$EndComp
Wire Wire Line
	3750 2050 3450 2050
Connection ~ 3750 2050
Wire Wire Line
	3750 1750 3450 1750
Connection ~ 3750 1750
Wire Wire Line
	3000 2350 3000 1450
Wire Wire Line
	3000 1450 3450 1450
$Comp
L power:GND #PWR?
U 1 1 61AB5E7A
P 3000 2450
AR Path="/6184A6B8/61AB5E7A" Ref="#PWR?"  Part="1" 
AR Path="/6186885C/61AB5E7A" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 3000 2200 50  0001 C CNN
F 1 "GND" H 3005 2277 50  0000 C CNN
F 2 "" H 3000 2450 50  0001 C CNN
F 3 "" H 3000 2450 50  0001 C CNN
	1    3000 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 2450 3000 2350
Wire Wire Line
	4600 1750 3750 1750
Wire Wire Line
	3950 2050 3750 2050
Wire Wire Line
	3450 2350 3000 2350
Wire Wire Line
	4600 1950 3950 1950
Wire Wire Line
	3950 1950 3950 2050
Connection ~ 3000 2350
NoConn ~ 4600 2150
$Comp
L Device:R R?
U 1 1 61AB904F
P 5000 1100
F 0 "R?" V 4793 1100 50  0000 C CNN
F 1 "R" V 4884 1100 50  0000 C CNN
F 2 "" V 4930 1100 50  0001 C CNN
F 3 "~" H 5000 1100 50  0001 C CNN
	1    5000 1100
	0    1    1    0   
$EndComp
Wire Wire Line
	5400 1100 5150 1100
Wire Wire Line
	4600 1550 4600 1100
Wire Wire Line
	4600 1100 4850 1100
Wire Bus Line
	1200 3600 2000 3600
Wire Bus Line
	2000 3600 2000 700 
Wire Bus Line
	2000 700  6700 700 
Wire Bus Line
	1950 3800 1950 650 
Wire Bus Line
	1950 650  6750 650 
Wire Bus Line
	6700 3350 6750 3350
Text Notes 6950 1350 0    50   ~ 0
Pins are not placed as IRL
Wire Wire Line
	1200 2800 4400 2800
Wire Wire Line
	4400 2800 4400 3350
Wire Wire Line
	4400 3350 4600 3350
Wire Wire Line
	1200 3400 4250 3400
Wire Wire Line
	4250 3400 4250 3650
Wire Wire Line
	4250 3650 4600 3650
Text HLabel 1200 4050 0    50   Input ~ 0
kb_clk
Text HLabel 1200 4250 0    50   Input ~ 0
kb_data
Wire Wire Line
	1200 4050 4250 4050
Wire Wire Line
	4250 4050 4250 3750
Wire Wire Line
	4250 3750 4600 3750
Wire Wire Line
	1200 4250 4300 4250
Wire Wire Line
	4300 4250 4300 3850
Wire Wire Line
	4300 3850 4600 3850
Text HLabel 8800 2650 2    50   Output ~ 0
MOSI
Text HLabel 8800 3050 2    50   Output ~ 0
TFT_CS
Text HLabel 8800 2550 2    50   Output ~ 0
SCK
Text HLabel 8800 3150 2    50   Output ~ 0
TFT_A0
Wire Bus Line
	6750 650  6750 3350
Wire Wire Line
	6200 2650 8800 2650
Wire Wire Line
	6200 2550 8800 2550
Wire Wire Line
	6200 3050 8800 3050
Wire Wire Line
	8800 3150 6200 3150
Wire Bus Line
	6700 3350 6700 4200
Wire Bus Line
	6700 700  6700 2350
$EndSCHEMATC
