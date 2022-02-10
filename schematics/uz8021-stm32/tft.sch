EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 8
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text GLabel 8750 2300 2    50   Output ~ 0
TFT_MOSI
Text GLabel 8750 2500 2    50   Output ~ 0
TFT_CS
Text GLabel 8750 2700 2    50   Output ~ 0
TFT_A0
$Comp
L MCU_Microchip_ATmega:ATmega328-PU U?
U 1 1 61A16EAB
P 4950 3700
AR Path="/6184A6B8/61A16EAB" Ref="U?"  Part="1" 
AR Path="/616D86A4/61A16EAB" Ref="U8"  Part="1" 
F 0 "U8" H 4306 3746 50  0000 R CNN
F 1 "ATmega328-PU" H 4306 3655 50  0000 R CNN
F 2 "Package_DIP:DIP-28_W7.62mm" H 4950 3700 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega328_P%20AVR%20MCU%20with%20picoPower%20Technology%20Data%20Sheet%2040001984A.pdf" H 4950 3700 50  0001 C CNN
	1    4950 3700
	1    0    0    -1  
$EndComp
$Comp
L Device:Crystal Y?
U 1 1 61A16EB1
P 6200 2400
AR Path="/6184A6B8/61A16EB1" Ref="Y?"  Part="1" 
AR Path="/616D86A4/61A16EB1" Ref="Y2"  Part="1" 
F 0 "Y2" V 6246 2269 50  0000 R CNN
F 1 "16 MHz" V 6155 2269 50  0000 R CNN
F 2 "Crystal:Resonator-2Pin_W7.0mm_H2.5mm" H 6200 2400 50  0001 C CNN
F 3 "~" H 6200 2400 50  0001 C CNN
	1    6200 2400
	-1   0    0    1   
$EndComp
$Comp
L Device:C C?
U 1 1 61A16EB7
P 5900 2100
AR Path="/6184A6B8/61A16EB7" Ref="C?"  Part="1" 
AR Path="/616D86A4/61A16EB7" Ref="C3"  Part="1" 
F 0 "C3" H 6015 2146 50  0000 L CNN
F 1 "22 pF" H 6015 2055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 5938 1950 50  0001 C CNN
F 3 "~" H 5900 2100 50  0001 C CNN
	1    5900 2100
	0    -1   -1   0   
$EndComp
$Comp
L Device:C C?
U 1 1 61A16EBD
P 6500 2100
AR Path="/6184A6B8/61A16EBD" Ref="C?"  Part="1" 
AR Path="/616D86A4/61A16EBD" Ref="C4"  Part="1" 
F 0 "C4" H 6615 2146 50  0000 L CNN
F 1 "22 pF" H 6615 2055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 6538 1950 50  0001 C CNN
F 3 "~" H 6500 2100 50  0001 C CNN
	1    6500 2100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6050 2400 6050 2100
Connection ~ 6050 2400
Wire Wire Line
	6350 2400 6350 2100
Connection ~ 6350 2400
Wire Wire Line
	5750 1650 6650 1650
Wire Wire Line
	6650 1650 6650 2100
$Comp
L power:GND #PWR?
U 1 1 61A16EC9
P 6850 2100
AR Path="/6184A6B8/61A16EC9" Ref="#PWR?"  Part="1" 
AR Path="/616D86A4/61A16EC9" Ref="#PWR023"  Part="1" 
F 0 "#PWR023" H 6850 1850 50  0001 C CNN
F 1 "GND" H 6855 1927 50  0000 C CNN
F 2 "" H 6850 2100 50  0001 C CNN
F 3 "" H 6850 2100 50  0001 C CNN
	1    6850 2100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 61A16ECF
P 4950 5200
AR Path="/6184A6B8/61A16ECF" Ref="#PWR?"  Part="1" 
AR Path="/616D86A4/61A16ECF" Ref="#PWR021"  Part="1" 
F 0 "#PWR021" H 4950 4950 50  0001 C CNN
F 1 "GND" H 4955 5027 50  0000 C CNN
F 2 "" H 4950 5200 50  0001 C CNN
F 3 "" H 4950 5200 50  0001 C CNN
	1    4950 5200
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 61A16ED5
P 4950 1900
AR Path="/6184A6B8/61A16ED5" Ref="#PWR?"  Part="1" 
AR Path="/616D86A4/61A16ED5" Ref="#PWR020"  Part="1" 
F 0 "#PWR020" H 4950 1750 50  0001 C CNN
F 1 "+5V" H 4965 2073 50  0000 C CNN
F 2 "" H 4950 1900 50  0001 C CNN
F 3 "" H 4950 1900 50  0001 C CNN
	1    4950 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	4950 1900 4950 2000
Wire Wire Line
	5050 2200 5050 2000
Wire Wire Line
	5050 2000 4950 2000
Connection ~ 4950 2000
Wire Wire Line
	4950 2000 4950 2200
NoConn ~ 4350 2500
Wire Wire Line
	5750 2100 5750 1650
$Comp
L Device:R R?
U 1 1 61A16EE2
P 6500 4000
AR Path="/6184A6B8/61A16EE2" Ref="R?"  Part="1" 
AR Path="/616D86A4/61A16EE2" Ref="R5"  Part="1" 
F 0 "R5" V 6293 4000 50  0000 C CNN
F 1 "R" V 6384 4000 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" V 6430 4000 50  0001 C CNN
F 3 "~" H 6500 4000 50  0001 C CNN
	1    6500 4000
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 61A16EE8
P 6800 3800
AR Path="/6184A6B8/61A16EE8" Ref="#PWR?"  Part="1" 
AR Path="/616D86A4/61A16EE8" Ref="#PWR022"  Part="1" 
F 0 "#PWR022" H 6800 3650 50  0001 C CNN
F 1 "+5V" H 6815 3973 50  0000 C CNN
F 2 "" H 6800 3800 50  0001 C CNN
F 3 "" H 6800 3800 50  0001 C CNN
	1    6800 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6800 3800 6800 4000
Wire Wire Line
	6800 4000 6650 4000
NoConn ~ 5550 4600
NoConn ~ 5550 4700
NoConn ~ 5550 4800
NoConn ~ 5550 4900
NoConn ~ 5550 3400
NoConn ~ 5550 3000
NoConn ~ 5550 2900
NoConn ~ 5550 2800
NoConn ~ 5550 2700
NoConn ~ 5550 2600
NoConn ~ 5550 2500
Wire Wire Line
	5550 3100 6050 3100
Wire Wire Line
	6050 2400 6050 3100
Wire Wire Line
	5550 3200 6350 3200
Wire Wire Line
	6350 2400 6350 3200
Wire Wire Line
	5550 4000 6350 4000
Connection ~ 6650 2100
Wire Wire Line
	6650 2100 6850 2100
Wire Wire Line
	5550 3900 5950 3900
Wire Wire Line
	5550 3800 5950 3800
Text HLabel 5950 3900 2    50   Input ~ 0
scl
Text HLabel 5950 3800 2    50   BiDi ~ 0
sda
Text Label 5650 3800 0    50   ~ 0
sda
Text Label 5650 3900 0    50   ~ 0
scl
$EndSCHEMATC
