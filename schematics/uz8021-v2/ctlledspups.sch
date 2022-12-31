EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 4
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 2150 3050 0    50   Input ~ 0
ctlbus[0..13]
Text Label 2500 3250 0    50   ~ 0
ctlbus0
Text Label 2500 3550 0    50   ~ 0
ctlbus1
Text Label 2500 3850 0    50   ~ 0
ctlbus2
Text Label 2850 3250 0    50   ~ 0
rst
Text Label 2850 3550 0    50   ~ 0
clk
Text Label 2850 3850 0    50   ~ 0
nmi
Wire Bus Line
	2150 3050 2350 3050
Entry Wire Line
	2350 3150 2450 3250
$Comp
L Device:R R1
U 1 1 61741E7F
P 4200 850
F 0 "R1" V 3993 850 50  0001 C CNN
F 1 "10k" V 4085 850 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 4130 850 50  0001 C CNN
F 3 "~" H 4200 850 50  0001 C CNN
	1    4200 850 
	0    1    1    0   
$EndComp
Entry Wire Line
	2350 3450 2450 3550
$Comp
L Device:R R2
U 1 1 61742881
P 4200 1100
F 0 "R2" V 3993 1100 50  0001 C CNN
F 1 "10k" V 4085 1100 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 4130 1100 50  0001 C CNN
F 3 "~" H 4200 1100 50  0001 C CNN
	1    4200 1100
	0    1    1    0   
$EndComp
Entry Wire Line
	2350 3750 2450 3850
Entry Wire Line
	2350 4050 2450 4150
Entry Wire Line
	2350 4350 2450 4450
Entry Wire Line
	2350 4650 2450 4750
Entry Wire Line
	2350 4950 2450 5050
Entry Wire Line
	2350 5250 2450 5350
Entry Wire Line
	2350 5550 2450 5650
Entry Wire Line
	2350 5850 2450 5950
Entry Wire Line
	2350 6150 2450 6250
$Comp
L Device:LED D1
U 1 1 617545E2
P 6300 3250
F 0 "D1" H 6293 2995 50  0001 C CNN
F 1 "LED" H 6293 3086 50  0001 C CNN
F 2 "Diode_SMD:D_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6300 3250 50  0001 C CNN
F 3 "~" H 6300 3250 50  0001 C CNN
	1    6300 3250
	-1   0    0    1   
$EndComp
$Comp
L Device:R R10
U 1 1 617545E8
P 6000 3250
F 0 "R10" V 5793 3250 50  0001 C CNN
F 1 "330" V 5885 3250 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5930 3250 50  0001 C CNN
F 3 "~" H 6000 3250 50  0001 C CNN
	1    6000 3250
	0    1    1    0   
$EndComp
$Comp
L Device:LED D2
U 1 1 61755FF3
P 6300 3550
F 0 "D2" H 6293 3295 50  0001 C CNN
F 1 "LED" H 6293 3386 50  0001 C CNN
F 2 "Diode_SMD:D_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6300 3550 50  0001 C CNN
F 3 "~" H 6300 3550 50  0001 C CNN
	1    6300 3550
	-1   0    0    1   
$EndComp
$Comp
L Device:R R11
U 1 1 61755FF9
P 6000 3550
F 0 "R11" V 5793 3550 50  0001 C CNN
F 1 "330" V 5885 3550 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5930 3550 50  0001 C CNN
F 3 "~" H 6000 3550 50  0001 C CNN
	1    6000 3550
	0    1    1    0   
$EndComp
$Comp
L Device:LED D3
U 1 1 61756000
P 6300 3850
F 0 "D3" H 6293 3595 50  0001 C CNN
F 1 "LED" H 6293 3686 50  0001 C CNN
F 2 "Diode_SMD:D_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6300 3850 50  0001 C CNN
F 3 "~" H 6300 3850 50  0001 C CNN
	1    6300 3850
	-1   0    0    1   
$EndComp
$Comp
L Device:R R12
U 1 1 61756006
P 6000 3850
F 0 "R12" V 5793 3850 50  0001 C CNN
F 1 "330" V 5885 3850 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5930 3850 50  0001 C CNN
F 3 "~" H 6000 3850 50  0001 C CNN
	1    6000 3850
	0    1    1    0   
$EndComp
Text Label 2900 6250 0    50   ~ 0
mreq
Text Label 2850 5950 0    50   ~ 0
wr
Text Label 2850 5650 0    50   ~ 0
rd
Text Label 2850 5350 0    50   ~ 0
halt
Text Label 2850 5050 0    50   ~ 0
wait
Text Label 2850 4750 0    50   ~ 0
rfsh
Text Label 2850 4450 0    50   ~ 0
m1
Text Label 2850 4150 0    50   ~ 0
int
Text Label 2500 6250 0    50   ~ 0
ctlbus10
Text Label 2500 5950 0    50   ~ 0
ctlbus9
Text Label 2500 5650 0    50   ~ 0
ctlbus8
Text Label 2500 5350 0    50   ~ 0
ctlbus7
Text Label 2500 5050 0    50   ~ 0
ctlbus6
Text Label 2500 4750 0    50   ~ 0
ctlbus5
Text Label 2500 4450 0    50   ~ 0
ctlbus4
Text Label 2500 4150 0    50   ~ 0
ctlbus3
Text Label 2500 6550 0    50   ~ 0
ctlbus11
Text Label 2500 6850 0    50   ~ 0
ctlbus12
Text Label 2500 7150 0    50   ~ 0
ctlbus13
Text Label 2900 6550 0    50   ~ 0
iorq
Text Label 2900 6850 0    50   ~ 0
busrq
Text Label 2900 7150 0    50   ~ 0
busack
Entry Wire Line
	2350 7050 2450 7150
Entry Wire Line
	2350 6750 2450 6850
Entry Wire Line
	2350 6450 2450 6550
Wire Wire Line
	5250 3250 5850 3250
Wire Wire Line
	5850 3850 5250 3850
$Comp
L Device:LED D4
U 1 1 6178D20C
P 6300 4150
F 0 "D4" H 6293 3895 50  0001 C CNN
F 1 "LED" H 6293 3986 50  0001 C CNN
F 2 "Diode_SMD:D_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6300 4150 50  0001 C CNN
F 3 "~" H 6300 4150 50  0001 C CNN
	1    6300 4150
	-1   0    0    1   
$EndComp
$Comp
L Device:R R13
U 1 1 6178D212
P 6000 4150
F 0 "R13" V 5793 4150 50  0001 C CNN
F 1 "330" V 5885 4150 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5930 4150 50  0001 C CNN
F 3 "~" H 6000 4150 50  0001 C CNN
	1    6000 4150
	0    1    1    0   
$EndComp
$Comp
L Device:LED D5
U 1 1 6178D218
P 6300 4450
F 0 "D5" H 6293 4195 50  0001 C CNN
F 1 "LED" H 6293 4286 50  0001 C CNN
F 2 "Diode_SMD:D_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6300 4450 50  0001 C CNN
F 3 "~" H 6300 4450 50  0001 C CNN
	1    6300 4450
	-1   0    0    1   
$EndComp
$Comp
L Device:R R14
U 1 1 6178D21E
P 6000 4450
F 0 "R14" V 5793 4450 50  0001 C CNN
F 1 "330" V 5885 4450 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5930 4450 50  0001 C CNN
F 3 "~" H 6000 4450 50  0001 C CNN
	1    6000 4450
	0    1    1    0   
$EndComp
$Comp
L Device:LED D6
U 1 1 6178D224
P 6300 4750
F 0 "D6" H 6293 4495 50  0001 C CNN
F 1 "LED" H 6293 4586 50  0001 C CNN
F 2 "Diode_SMD:D_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6300 4750 50  0001 C CNN
F 3 "~" H 6300 4750 50  0001 C CNN
	1    6300 4750
	-1   0    0    1   
$EndComp
$Comp
L Device:R R15
U 1 1 6178D22A
P 6000 4750
F 0 "R15" V 5793 4750 50  0001 C CNN
F 1 "330" V 5885 4750 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5930 4750 50  0001 C CNN
F 3 "~" H 6000 4750 50  0001 C CNN
	1    6000 4750
	0    1    1    0   
$EndComp
Wire Wire Line
	5250 4450 5850 4450
$Comp
L Device:LED D7
U 1 1 6178FF71
P 6300 5050
F 0 "D7" H 6293 4795 50  0001 C CNN
F 1 "LED" H 6293 4886 50  0001 C CNN
F 2 "Diode_SMD:D_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6300 5050 50  0001 C CNN
F 3 "~" H 6300 5050 50  0001 C CNN
	1    6300 5050
	-1   0    0    1   
$EndComp
$Comp
L Device:R R16
U 1 1 6178FF77
P 6000 5050
F 0 "R16" V 5793 5050 50  0001 C CNN
F 1 "330" V 5885 5050 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5930 5050 50  0001 C CNN
F 3 "~" H 6000 5050 50  0001 C CNN
	1    6000 5050
	0    1    1    0   
$EndComp
$Comp
L Device:LED D8
U 1 1 6178FF7D
P 6300 5350
F 0 "D8" H 6293 5095 50  0001 C CNN
F 1 "LED" H 6293 5186 50  0001 C CNN
F 2 "Diode_SMD:D_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6300 5350 50  0001 C CNN
F 3 "~" H 6300 5350 50  0001 C CNN
	1    6300 5350
	-1   0    0    1   
$EndComp
$Comp
L Device:R R17
U 1 1 6178FF83
P 6000 5350
F 0 "R17" V 5793 5350 50  0001 C CNN
F 1 "330" V 5885 5350 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5930 5350 50  0001 C CNN
F 3 "~" H 6000 5350 50  0001 C CNN
	1    6000 5350
	0    1    1    0   
$EndComp
$Comp
L Device:LED D9
U 1 1 6178FF89
P 6300 5650
F 0 "D9" H 6293 5395 50  0001 C CNN
F 1 "LED" H 6293 5486 50  0001 C CNN
F 2 "Diode_SMD:D_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6300 5650 50  0001 C CNN
F 3 "~" H 6300 5650 50  0001 C CNN
	1    6300 5650
	-1   0    0    1   
$EndComp
$Comp
L Device:R R18
U 1 1 6178FF8F
P 6000 5650
F 0 "R18" V 5793 5650 50  0001 C CNN
F 1 "330" V 5885 5650 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5930 5650 50  0001 C CNN
F 3 "~" H 6000 5650 50  0001 C CNN
	1    6000 5650
	0    1    1    0   
$EndComp
Wire Wire Line
	5850 5050 5250 5050
Wire Wire Line
	5250 5650 5850 5650
$Comp
L Device:LED D10
U 1 1 6179423E
P 6300 5950
F 0 "D10" H 6293 5695 50  0001 C CNN
F 1 "LED" H 6293 5786 50  0001 C CNN
F 2 "Diode_SMD:D_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6300 5950 50  0001 C CNN
F 3 "~" H 6300 5950 50  0001 C CNN
	1    6300 5950
	-1   0    0    1   
$EndComp
$Comp
L Device:R R19
U 1 1 61794244
P 6000 5950
F 0 "R19" V 5793 5950 50  0001 C CNN
F 1 "330" V 5885 5950 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5930 5950 50  0001 C CNN
F 3 "~" H 6000 5950 50  0001 C CNN
	1    6000 5950
	0    1    1    0   
$EndComp
$Comp
L Device:LED D11
U 1 1 6179424A
P 6300 6250
F 0 "D11" H 6293 5995 50  0001 C CNN
F 1 "LED" H 6293 6086 50  0001 C CNN
F 2 "Diode_SMD:D_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6300 6250 50  0001 C CNN
F 3 "~" H 6300 6250 50  0001 C CNN
	1    6300 6250
	-1   0    0    1   
$EndComp
$Comp
L Device:R R20
U 1 1 61794250
P 6000 6250
F 0 "R20" V 5793 6250 50  0001 C CNN
F 1 "330" V 5885 6250 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5930 6250 50  0001 C CNN
F 3 "~" H 6000 6250 50  0001 C CNN
	1    6000 6250
	0    1    1    0   
$EndComp
$Comp
L Device:LED D12
U 1 1 61794256
P 6300 6550
F 0 "D12" H 6293 6295 50  0001 C CNN
F 1 "LED" H 6293 6386 50  0001 C CNN
F 2 "Diode_SMD:D_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6300 6550 50  0001 C CNN
F 3 "~" H 6300 6550 50  0001 C CNN
	1    6300 6550
	-1   0    0    1   
$EndComp
$Comp
L Device:R R21
U 1 1 6179425C
P 6000 6550
F 0 "R21" V 5793 6550 50  0001 C CNN
F 1 "330" V 5885 6550 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5930 6550 50  0001 C CNN
F 3 "~" H 6000 6550 50  0001 C CNN
	1    6000 6550
	0    1    1    0   
$EndComp
Wire Wire Line
	5850 6250 5250 6250
$Comp
L Device:LED D13
U 1 1 617962B5
P 6300 6850
F 0 "D13" H 6293 6595 50  0001 C CNN
F 1 "LED" H 6293 6686 50  0001 C CNN
F 2 "Diode_SMD:D_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6300 6850 50  0001 C CNN
F 3 "~" H 6300 6850 50  0001 C CNN
	1    6300 6850
	-1   0    0    1   
$EndComp
$Comp
L Device:R R22
U 1 1 617962BB
P 6000 6850
F 0 "R22" V 5793 6850 50  0001 C CNN
F 1 "330" V 5885 6850 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5930 6850 50  0001 C CNN
F 3 "~" H 6000 6850 50  0001 C CNN
	1    6000 6850
	0    1    1    0   
$EndComp
$Comp
L Device:LED D14
U 1 1 617962C1
P 6300 7150
F 0 "D14" H 6293 6895 50  0001 C CNN
F 1 "LED" H 6293 6986 50  0001 C CNN
F 2 "Diode_SMD:D_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6300 7150 50  0001 C CNN
F 3 "~" H 6300 7150 50  0001 C CNN
	1    6300 7150
	-1   0    0    1   
$EndComp
$Comp
L Device:R R23
U 1 1 617962C7
P 6000 7150
F 0 "R23" V 5793 7150 50  0001 C CNN
F 1 "330" V 5885 7150 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5930 7150 50  0001 C CNN
F 3 "~" H 6000 7150 50  0001 C CNN
	1    6000 7150
	0    1    1    0   
$EndComp
Wire Wire Line
	5850 6850 5250 6850
Wire Wire Line
	6450 3250 6600 3250
Wire Wire Line
	6600 3250 6600 3550
Wire Wire Line
	6600 3550 6450 3550
Wire Wire Line
	6600 3550 6600 3850
Wire Wire Line
	6600 7150 6450 7150
Connection ~ 6600 3550
Connection ~ 6600 6850
Wire Wire Line
	6600 6850 6600 7150
Wire Wire Line
	6450 6850 6600 6850
Wire Wire Line
	6450 6550 6600 6550
Connection ~ 6600 6550
Wire Wire Line
	6600 6550 6600 6850
Wire Wire Line
	6450 6250 6600 6250
Connection ~ 6600 6250
Wire Wire Line
	6600 6250 6600 6550
Wire Wire Line
	6450 5950 6600 5950
Connection ~ 6600 5950
Wire Wire Line
	6600 5950 6600 6250
Wire Wire Line
	6450 5650 6600 5650
Connection ~ 6600 5650
Wire Wire Line
	6600 5650 6600 5950
Wire Wire Line
	6450 5350 6600 5350
Connection ~ 6600 5350
Wire Wire Line
	6600 5350 6600 5650
Wire Wire Line
	6450 5050 6600 5050
Connection ~ 6600 5050
Wire Wire Line
	6600 5050 6600 5350
Wire Wire Line
	6450 4750 6600 4750
Connection ~ 6600 4750
Wire Wire Line
	6600 4750 6600 5050
Wire Wire Line
	6450 4450 6600 4450
Connection ~ 6600 4450
Wire Wire Line
	6600 4450 6600 4750
Wire Wire Line
	6450 4150 6600 4150
Connection ~ 6600 4150
Wire Wire Line
	6600 4150 6600 4450
Wire Wire Line
	6450 3850 6600 3850
Connection ~ 6600 3850
Wire Wire Line
	6600 3850 6600 4150
Wire Wire Line
	6600 7150 6600 7350
Connection ~ 6600 7150
$Comp
L power:GND #PWR0103
U 1 1 617A5AA0
P 6600 7350
F 0 "#PWR0103" H 6600 7100 50  0001 C CNN
F 1 "GND" H 6605 7177 50  0000 C CNN
F 2 "" H 6600 7350 50  0001 C CNN
F 3 "" H 6600 7350 50  0001 C CNN
	1    6600 7350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 3250 3050 3250
Wire Wire Line
	2450 3550 5250 3550
Wire Wire Line
	2450 3850 3100 3850
Wire Wire Line
	2450 4150 3150 4150
Wire Wire Line
	2450 4450 4650 4450
Wire Wire Line
	2450 4750 5250 4750
Wire Wire Line
	2450 5050 3200 5050
Wire Wire Line
	2450 5350 5250 5350
Wire Wire Line
	2450 5650 3250 5650
Wire Wire Line
	2450 5950 3300 5950
Wire Wire Line
	2450 6250 3350 6250
Wire Wire Line
	2450 6550 3400 6550
Wire Wire Line
	2450 6850 3450 6850
Wire Wire Line
	2450 7150 5250 7150
Wire Wire Line
	3050 850  4050 850 
Connection ~ 3050 3250
Wire Wire Line
	3050 3250 4650 3250
Connection ~ 3100 3850
Wire Wire Line
	3100 3850 4650 3850
Wire Wire Line
	3100 1100 4050 1100
Connection ~ 3150 4150
Wire Wire Line
	3150 4150 5250 4150
$Comp
L Device:R R3
U 1 1 61810262
P 4200 1400
F 0 "R3" V 3993 1400 50  0001 C CNN
F 1 "10k" V 4085 1400 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 4130 1400 50  0001 C CNN
F 3 "~" H 4200 1400 50  0001 C CNN
	1    4200 1400
	0    1    1    0   
$EndComp
$Comp
L Device:R R4
U 1 1 61810268
P 4200 1650
F 0 "R4" V 3993 1650 50  0001 C CNN
F 1 "10k" V 4085 1650 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 4130 1650 50  0001 C CNN
F 3 "~" H 4200 1650 50  0001 C CNN
	1    4200 1650
	0    1    1    0   
$EndComp
Wire Wire Line
	3150 1400 4050 1400
Wire Wire Line
	3200 1650 4050 1650
Connection ~ 3200 5050
Wire Wire Line
	3200 5050 4650 5050
$Comp
L Device:R R5
U 1 1 61815A96
P 4200 1900
F 0 "R5" V 3993 1900 50  0001 C CNN
F 1 "10k" V 4085 1900 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 4130 1900 50  0001 C CNN
F 3 "~" H 4200 1900 50  0001 C CNN
	1    4200 1900
	0    1    1    0   
$EndComp
$Comp
L Device:R R6
U 1 1 61815A9C
P 4200 2150
F 0 "R6" V 3993 2150 50  0001 C CNN
F 1 "10k" V 4085 2150 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 4130 2150 50  0001 C CNN
F 3 "~" H 4200 2150 50  0001 C CNN
	1    4200 2150
	0    1    1    0   
$EndComp
$Comp
L Device:R R7
U 1 1 61815AA2
P 4200 2450
F 0 "R7" V 3993 2450 50  0001 C CNN
F 1 "10k" V 4085 2450 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 4130 2450 50  0001 C CNN
F 3 "~" H 4200 2450 50  0001 C CNN
	1    4200 2450
	0    1    1    0   
$EndComp
$Comp
L Device:R R8
U 1 1 61815AA8
P 4200 2700
F 0 "R8" V 3993 2700 50  0001 C CNN
F 1 "10k" V 4085 2700 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 4130 2700 50  0001 C CNN
F 3 "~" H 4200 2700 50  0001 C CNN
	1    4200 2700
	0    1    1    0   
$EndComp
Wire Wire Line
	3250 1900 4050 1900
Connection ~ 3250 5650
Wire Wire Line
	3250 5650 4650 5650
Wire Wire Line
	3300 2150 4050 2150
Connection ~ 3300 5950
Wire Wire Line
	3300 5950 5250 5950
Wire Wire Line
	3350 2450 4050 2450
Connection ~ 3350 6250
Wire Wire Line
	3350 6250 4650 6250
Wire Wire Line
	3400 2700 4050 2700
Connection ~ 3400 6550
Wire Wire Line
	3400 6550 5250 6550
Wire Wire Line
	3050 850  3050 3250
Wire Wire Line
	3100 1100 3100 3850
Wire Wire Line
	3150 1400 3150 4150
Wire Wire Line
	3200 1650 3200 5050
Wire Wire Line
	3250 1900 3250 5650
Wire Wire Line
	3300 2150 3300 5950
Wire Wire Line
	3350 2450 3350 6250
Wire Wire Line
	3400 2700 3400 6550
$Comp
L Device:R R9
U 1 1 61838975
P 4200 2950
F 0 "R9" V 3993 2950 50  0001 C CNN
F 1 "10k" V 4085 2950 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 4130 2950 50  0001 C CNN
F 3 "~" H 4200 2950 50  0001 C CNN
	1    4200 2950
	0    1    1    0   
$EndComp
Wire Wire Line
	4050 2950 3450 2950
Wire Wire Line
	3450 2950 3450 6850
Connection ~ 3450 6850
Wire Wire Line
	3450 6850 4650 6850
Wire Wire Line
	4350 2950 4600 2950
Wire Wire Line
	4600 2950 4600 2700
Wire Wire Line
	4600 850  4350 850 
Wire Wire Line
	4350 1100 4600 1100
Connection ~ 4600 1100
Wire Wire Line
	4600 1100 4600 850 
Wire Wire Line
	4350 1400 4600 1400
Connection ~ 4600 1400
Wire Wire Line
	4600 1400 4600 1100
Wire Wire Line
	4350 1650 4600 1650
Connection ~ 4600 1650
Wire Wire Line
	4600 1650 4600 1400
Wire Wire Line
	4350 1900 4600 1900
Connection ~ 4600 1900
Wire Wire Line
	4600 1900 4600 1650
Wire Wire Line
	4350 2150 4600 2150
Connection ~ 4600 2150
Wire Wire Line
	4600 2150 4600 1900
Wire Wire Line
	4350 2450 4600 2450
Connection ~ 4600 2450
Wire Wire Line
	4600 2450 4600 2150
Wire Wire Line
	4350 2700 4600 2700
Connection ~ 4600 2700
Wire Wire Line
	4600 2700 4600 2450
Wire Wire Line
	4600 1900 5350 1900
Wire Wire Line
	5350 1900 5350 1500
$Comp
L power:+5V #PWR0104
U 1 1 61855F21
P 5350 1500
F 0 "#PWR0104" H 5350 1350 50  0001 C CNN
F 1 "+5V" H 5365 1673 50  0000 C CNN
F 2 "" H 5350 1500 50  0001 C CNN
F 3 "" H 5350 1500 50  0001 C CNN
	1    5350 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5800 2900 6600 2900
Connection ~ 6600 2900
Wire Wire Line
	6600 2900 7450 2900
Connection ~ 5350 1900
Wire Wire Line
	6600 2900 6600 3250
Connection ~ 6600 3250
Text Label 2350 3850 1    50   ~ 0
ctlbus[0..13]
Wire Bus Line
	2350 3050 2350 7150
$Comp
L 74xx:74HC14 U10
U 1 1 6173A69D
P 4950 3250
F 0 "U10" H 4950 3567 50  0000 C CNN
F 1 "74HC14" H 4950 3476 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 4950 3250 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 4950 3250 50  0001 C CNN
	1    4950 3250
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U10
U 2 1 6173E79C
P 5550 3550
F 0 "U10" H 5550 3867 50  0000 C CNN
F 1 "74HC14" H 5550 3776 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 5550 3550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 5550 3550 50  0001 C CNN
	2    5550 3550
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U10
U 3 1 61741651
P 4950 3850
F 0 "U10" H 4950 4167 50  0000 C CNN
F 1 "74HC14" H 4950 4076 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 4950 3850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 4950 3850 50  0001 C CNN
	3    4950 3850
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U10
U 4 1 61742A68
P 5550 4150
F 0 "U10" H 5550 4467 50  0000 C CNN
F 1 "74HC14" H 5550 4376 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 5550 4150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 5550 4150 50  0001 C CNN
	4    5550 4150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U10
U 5 1 61743AD8
P 4950 4450
F 0 "U10" H 4950 4767 50  0000 C CNN
F 1 "74HC14" H 4950 4676 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 4950 4450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 4950 4450 50  0001 C CNN
	5    4950 4450
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U10
U 6 1 61744B39
P 5550 4750
F 0 "U10" H 5550 5067 50  0000 C CNN
F 1 "74HC14" H 5550 4976 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 5550 4750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 5550 4750 50  0001 C CNN
	6    5550 4750
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U10
U 7 1 6174547B
P 5800 2400
F 0 "U10" H 6030 2446 50  0000 L CNN
F 1 "74HC14" H 6030 2355 50  0000 L CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 5800 2400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 5800 2400 50  0001 C CNN
	7    5800 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 1900 5800 1900
Connection ~ 5800 1900
Wire Wire Line
	5800 1900 6600 1900
$Comp
L 74xx:74HC14 U11
U 7 1 617466A6
P 6600 2400
F 0 "U11" H 6830 2446 50  0000 L CNN
F 1 "74HC14" H 6830 2355 50  0000 L CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 6600 2400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 6600 2400 50  0001 C CNN
	7    6600 2400
	1    0    0    -1  
$EndComp
Connection ~ 6600 1900
Wire Wire Line
	6600 1900 7450 1900
$Comp
L 74xx:74HC14 U12
U 7 1 61747087
P 7450 2400
F 0 "U12" H 7680 2446 50  0000 L CNN
F 1 "74HC14" H 7680 2355 50  0000 L CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 7450 2400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 7450 2400 50  0001 C CNN
	7    7450 2400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U11
U 1 1 6174CAE2
P 4950 5050
F 0 "U11" H 4950 5367 50  0000 C CNN
F 1 "74HC14" H 4950 5276 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 4950 5050 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 4950 5050 50  0001 C CNN
	1    4950 5050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U11
U 2 1 6174DB21
P 5550 5350
F 0 "U11" H 5550 5667 50  0000 C CNN
F 1 "74HC14" H 5550 5576 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 5550 5350 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 5550 5350 50  0001 C CNN
	2    5550 5350
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U11
U 3 1 6174EE2A
P 4950 5650
F 0 "U11" H 4950 5967 50  0000 C CNN
F 1 "74HC14" H 4950 5876 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 4950 5650 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 4950 5650 50  0001 C CNN
	3    4950 5650
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U11
U 4 1 6174F8E1
P 5550 5950
F 0 "U11" H 5550 6267 50  0000 C CNN
F 1 "74HC14" H 5550 6176 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 5550 5950 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 5550 5950 50  0001 C CNN
	4    5550 5950
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U11
U 5 1 617508F0
P 4950 6250
F 0 "U11" H 4950 6567 50  0000 C CNN
F 1 "74HC14" H 4950 6476 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 4950 6250 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 4950 6250 50  0001 C CNN
	5    4950 6250
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U11
U 6 1 6175179F
P 5550 6550
F 0 "U11" H 5550 6867 50  0000 C CNN
F 1 "74HC14" H 5550 6776 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 5550 6550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 5550 6550 50  0001 C CNN
	6    5550 6550
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U12
U 1 1 61752774
P 4950 6850
F 0 "U12" H 4950 7167 50  0000 C CNN
F 1 "74HC14" H 4950 7076 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 4950 6850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 4950 6850 50  0001 C CNN
	1    4950 6850
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U12
U 2 1 6175387C
P 5550 7150
F 0 "U12" H 5550 7467 50  0000 C CNN
F 1 "74HC14" H 5550 7376 50  0000 C CNN
F 2 "Package_SO:SO-14_3.9x8.65mm_P1.27mm" H 5550 7150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 5550 7150 50  0001 C CNN
	2    5550 7150
	1    0    0    -1  
$EndComp
$EndSCHEMATC