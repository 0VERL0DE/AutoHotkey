#Requires Autohotkey 2.0
#SingleInstance
;MaxHotkeysPerInterval 99000000
;HotkeyInterval 99000000

A_HotkeyInterval := 2000  ; This is the default value (milliseconds).
A_MaxHotkeysPerInterval := 200

KeyHistory 0
ListLines 0
;Process, Priority, , A
ProcessSetPriority "AboveNormal"

;  NoEnv no hace falta en la v2

; Null Movement Script
; This updates the A and D keys so that only one is held down at a time
; This avoids the situation where game engines treat holding both strafe keys as not moving
; Insead holding both strafe keys will cause you to move in the direction of the last one that was pressed

global a_held,d_held,a_scrip,d_scrip

a_held := 0 ; Variable that stores the actual keyboard state of the a key
d_held := 0 ; Variable that stores the actual keyboard state of the d key
a_scrip := 0 ; Variable that stores the state of the a key output from the script
d_scrip := 0 ; Variable that stores the state of the d key output from the script

; Every time the a key is pressed, * to include occurences with modifiers (shift, control, alt, etc)
*a:: {
	global a_held, d_scrip, a_scrip ; Declarar las variables como globales  
    a_held := 1 ; Actualizar el estado de la tecla 'a'
	
	
	if (d_scrip){ 
		d_scrip := 0
		Send "{Blind}{d up}" ; Release the d key if it's held down, {Blind} so it includes any key modifiers (shift primarily)
	}
	
	if (!a_scrip){
		a_scrip := 1
		Send "{Blind}{a down}" ; Send the a down key
	}
	return
}

; Every time the a key is released
*a up:: {

	global a_held, d_scrip, a_scrip ; Declarar las variables como globales  
    a_held := 0  
	
	if (a_scrip){
		a_scrip := 0
		Send "{Blind}{a up}" ; Send the a up key
	}
		
	if (d_held && !d_scrip){
		d_scrip := 1
		Send "{Blind}{d down}" ; Send the d down key if it's held
	}
	return
}

; Every time the d key is pressed
*d:: {

	global d_held, a_scrip, d_scrip ; Declarar las variables como globales  
    d_held := 1
	
	if (a_scrip){
		a_scrip := 0
		Send "{Blind}{a up}"
	}
	
	if (!d_scrip){
		d_scrip := 1
		Send "{Blind}{d down}"
	}
	return
}

; Every time the d key is released
*d up:: {
	 global d_held, a_scrip, d_scrip ; Declarar las variables como globales  
     d_held := 0 
	
	if (d_scrip){
		d_scrip := 0
		Send "{Blind}{d up}"
	}
	
	if (a_held && !a_scrip){
		a_scrip := 1
		Send "{Blind}{a down}"
	}
	return
}	