.equ INPUT, 0
.equ OUTPUT, 1
.equ LOW, 0
.equ HIGH, 1
.equ SECONDS, 2

.equ BUTTON, 29
.equ RED, 0
.equ BLUE, 2
.equ YELLOW, 3
.equ BLUE_TWO, 22
.equ RGB_RED, 23
.equ RGB_GREEN, 24
.equ RGB_BLUE, 25


.align 4
.text
.global main
main:
	push {lr}
	bl wiringPiSetup

	mov r0, #RGB_RED
	bl pinOutput
	mov r0, #RGB_GREEN
	bl pinOutput
	mov r0, #RGB_BLUE
	bl pinOutput
	mov r0, #BLUE_TWO
	bl pinOutput
	mov r0, #YELLOW
	bl pinOutput
	mov r0, #BLUE
	bl pinOutput
	mov r0, #RED
	bl pinOutput
	mov r0, #BUTTON
	bl pinInput
gameStart:
	bl lightsShow

	ldr r0, =#2000
	bl delay
	mov r0, #RED
	bl checkButton
	cmp r0, #1
	bne gameStart

	ldr r0, =#2000
	bl delay
	mov r0, #BLUE
	bl checkButton
	cmp r0, #1
	bne gameStart

	ldr r0, =#2000
	bl delay
	mov r0, #YELLOW
	bl checkButton
	cmp r0, #1
	bne gameStart

	ldr r0, =#2000
	bl delay
	mov r0, #BLUE_TWO
	bl checkButton
	cmp r0, #1
	bne gameStart

	ldr r0, =#2000
	bl delay
	mov r0, #RGB_GREEN
	bl checkButton
	cmp r0, #1
	bne gameStart

	ldr r0, =#100
	bl delay
	mov r0, #RGB_GREEN
	bl pinOff
	ldr r0, =#120
	bl delay
	mov r0, #RGB_RED
	bl pinOn
	ldr r0, =#120
	bl delay
	mov r0, #RGB_RED
	bl pinOff
	ldr r0, =#120
	bl delay
	mov r0, #RGB_BLUE
	bl pinOn
	ldr r0, =#120
	bl delay
	mov r0, #RGB_BLUE
	bl pinOff
	ldr r0, =#120
	bl delay
	mov r0, #RGB_GREEN
	bl pinOn
	ldr r0, =#120
	bl delay
	mov r0, #RGB_GREEN
	bl pinOff
	ldr r0, =#120
	bl delay
	mov r0, #RGB_RED
	bl pinOn
	ldr r0, =#120
	bl delay
	mov r0, #RGB_RED
	bl pinOff
	ldr r0, =#120
	bl delay
	mov r0, #RGB_BLUE
	bl pinOn
	ldr r0, =#120
	bl delay
	mov r0, #RGB_BLUE
	bl pinOff
	ldr r0, =#120
	bl delay
	mov r0, #RGB_GREEN
	bl pinOn
	ldr r0, =#120
	bl delay

	bl lightsShow
	mov r0, #0
	pop {pc}


lightsShow:
	push {r4, lr}

	mov r4, #0
flashLoop:
	mov r0, #RGB_GREEN
	mov r1, #LOW
	bl digitalWrite

	mov r0, #BLUE_TWO
	mov r1, #LOW
	bl digitalWrite

	mov r0, #YELLOW
	mov r1, #LOW
	bl digitalWrite

	mov r0, #BLUE
	mov r1, #LOW
	bl digitalWrite

	mov r0, #RED
	mov r1, #LOW
	bl digitalWrite

	ldr r0, =#235
	bl delay

	mov r0, #RGB_GREEN
	mov r1, #HIGH
	bl digitalWrite

	mov r0, #BLUE_TWO
	mov r1, #HIGH
	bl digitalWrite

	mov r0, #YELLOW
	mov r1, #HIGH
	bl digitalWrite

	mov r0, #BLUE
	mov r1, #HIGH
	bl digitalWrite

	mov r0, #RED
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#235
	bl delay
	add r4, r4, #1
	cmp r4, #3
	bne flashLoop

	ldr r0, =#475
	bl delay
	mov r4, #0
scrollingLoop:
	mov r0, #RGB_GREEN
	mov r1, #LOW
	bl digitalWrite

	ldr r0, =#115
	bl delay

	mov r0, #BLUE_TWO
	mov r1, #LOW
	bl digitalWrite

	ldr r0, =#115
	bl delay

	mov r0, #YELLOW
	mov r1, #LOW
	bl digitalWrite

	ldr r0, =#115
	bl delay

	mov r0, #BLUE
	mov r1, #LOW
	bl digitalWrite

	ldr r0, =#115
	bl delay

	mov r0, #RED
	mov r1, #LOW
	bl digitalWrite
	cmp r4, #2
	beq doneLightsShow

	ldr r0, =#115
	bl delay

	mov r0, #RGB_GREEN
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#115
	bl delay

	mov r0, #BLUE_TWO
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#115
	bl delay

	mov r0, #YELLOW
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#115
	bl delay

	mov r0, #BLUE
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#115
	bl delay

	mov r0, #RED
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#115
	bl delay
	add r4, r4, #1
	cmp r4, #2
	bne scrollingLoop
	b scrollingLoop
doneLightsShow:
	pop {r4, pc}


checkButton:
	push {r4, r5, lr}

	mov r5, r0

	bl buttonRead
	cmp r0, #0
	beq notCheating

	mov r0, #0
	b done
notCheating:
	mov r0, r5
	bl pinOn

	mov r0, #0
	bl time
	mov r4, r0
loopBack:
	bl buttonRead
	cmp r0, #1
	beq done

	mov r0, #0
	bl time
	sub r0, r0, r4
	cmp r0, #SECONDS
	blt loopBack
done:
	pop {r4, r5, pc}


buttonRead:
	push {lr}

	mov r0, #BUTTON
	bl digitalRead

	pop {pc}
pinOn:
	push {lr}

	mov r1, #HIGH
	bl digitalWrite

	pop {pc}
pinOff:
	push {lr}

	mov r1, #LOW
	bl digitalWrite

	pop {pc}
pinOutput:
	push {lr}

	mov r1, #OUTPUT
	bl pinMode

	pop {pc}
pinInput:
	push {lr}

	mov r1, #INPUT
	bl pinMode

	pop {pc}
