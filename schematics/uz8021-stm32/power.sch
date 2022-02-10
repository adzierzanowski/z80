EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 5
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 7600 3250 0    50   Input ~ 0
z80_rst
$Comp
L Device:R R?
U 1 1 6182FBA6
P 7600 2900
F 0 "R?" H 7670 2946 50  0000 L CNN
F 1 "R" H 7670 2855 50  0000 L CNN
F 2 "" V 7530 2900 50  0001 C CNN
F 3 "~" H 7600 2900 50  0001 C CNN
	1    7600 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 3050 7600 3250
$Comp
L power:+5V #PWR?
U 1 1 618306F6
P 7600 1550
F 0 "#PWR?" H 7600 1400 50  0001 C CNN
F 1 "+5V" H 7615 1723 50  0000 C CNN
F 2 "" H 7600 1550 50  0001 C CNN
F 3 "" H 7600 1550 50  0001 C CNN
	1    7600 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 1550 7600 2750
$EndSCHEMATC
