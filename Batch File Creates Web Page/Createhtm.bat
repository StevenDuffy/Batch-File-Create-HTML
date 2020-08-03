@ECHO OFF
REM Created by David Duffy
REM Last modified on - 10/03/2018.
REM Program will create a htm file using the users input values for text, text color and font-size.


:Parametermode
	REM Checks if first three command line parameters exist/are valid.
	REM If parameters do not exist interactive mode starts.
	REM If more than three parameters are provided, user is ejected with error message.
	IF "%~1"=="" (
        GOTO Interactivemode
    )
        IF "%2"=="" (
            GOTO Parameterfail
        )
            IF "%3"=="" (                                                    
                GOTO Parameterfail
            )
                IF NOT "%4"=="" (
                    GOTO Parameterfail
                )
     
    REM If valid number of parameters exist, set variables for Hello.htm file
	REM User input for font-size is stored in an arithmetic variable 'numericFontSize'. 
    REM If the user has entered a string value for font size, it will now become '0'.	
	SET name=%~1
        SET color=%2
		    SET /a numericFontSize=%3
	    
	REM Ensures users input is valid by checking the arithmetic variable holds a number greater than zero. 
	REM If input is invalid, go to Parameterfail.
	IF NOT %numericFontSize% GTR 0 (
        GOTO Parameterfail
    )	
	      
        REM For loop is used to determine if input matches a valid color (red, blue or green).
        REM If user input matches any of these, the existence of Hello.htm is checked. 
        REM If it exists, go to Overwrite. Otherwise go to Generatehtm. 
        FOR %%B IN (Red Blue Green) DO IF /I "%color%"=="%%B" ( 
            IF EXIST .\Hello.Htm (
         	    GOTO Overwrite
            ) ELSE (
                GOTO Generatehtm
         	)
        )
	
    REM If parameters are invalid go to Parameterfail message.	
    GOTO Parameterfail


:Parameterfail
    REM If parameters are invalid, this will eject user and advise on valid parameter options.
	REM GOTO :EOF is a special line label used to tell the batch file to stop. 
    ECHO Invalid parameters entered. Please provide: [TEXT] [RED/BLUE/GREEN] [FONT-SIZE]
    GOTO :EOF
	

:Interactivemode
    REM Introduction to the program.
    ECHO The following program will create a html page called Hello.htm
	REM Line break for clarity.
    ECHO.
    REM Get users input for text to display.
    SET /p name=Please type the name you wish to display and press enter:
	
	
:Selectcolor
    REM Line breaks for clarity.
	ECHO.
	REM Provide user with a list of valid colors.
	ECHO (Select from Red, Blue or Green).
	REM Get users input for text colour and store in variable 'Color'.
    SET /p Color=Please enter the color you would like your text to be:
             
		REM For loop checks user input against possible valid parameters to ensure it is valid (Red, Blue and Green).
        FOR %%B IN (Red Blue Green) DO IF /I "%color%"=="%%B" (
            GOTO Selectfont 
        )
			
    REM If input is invalid, advise user that their input is invalid and go to Selectcolor to request input again.
    ECHO Invalid input. Please type either Red, Blue or Green.
        GOTO Selectcolor


:Selectfont
    REM Gets users input for font size and stores it in the variable 'fontSize'.
	SET /p fontSize=Please enter a font size for your text:
        
		REM Stores users input into an arithmetic variable 'numericFontSize'.
	    REM If input is a string the variable will  now become '0' and invalid.
        SET /a numericFontSize=%fontSize%
      
	        REM Ensures users input is valid by checking the arithmetic variable holds a numnber greater than zero. 
		    REM If input is invalid, advise on valid input options and request input again.
	        IF NOT %numericFontSize% GTR 0 (
                ECHO Invalid input. Please type and enter a whole number greater than 0.
                GOTO Selectfont
            )
		
                REM Check if Hello.htm exists and if so go to overwrite. 
                REM If Hello.htm does not exist, continue to create Hello.htm.
                IF EXIST .\Hello.htm (
                    GOTO Overwrite
                ) ELSE (
                    GOTO Generatehtm
                )


:Overwrite
    REM Advise user 'Hello.htm' already exists.
    ECHO The file "Hello.htm" already exists. 
	REM Line break for clarity.
    ECHO.
	    REM Ask user if they wish to overwrite and store users answer in variable 'overwrite'.
        SET /P overwrite=Are you sure you wish to overwrite this file? (Y=Yes N=No):
		
		    REM If yes (Y/y), continue to overwrite.
            IF /I "%overwrite%"=="Y" (
                GOTO Generatehtm
            )
			    REM If no (N/n), exit batch file without saving - CMD will remain open.
				REM If an invalid input is given, advise user and request valid input.
                IF /I "%overwrite%"=="N" (
                    ECHO Save aborted.
					GOTO :EOF
                ) ELSE (
                    ECHO Invalid input. Please enter either Y or N. 
                    GOTO Overwrite
                )


:Generatehtm
    REM generate the Hello.htm file with users input.
    ECHO ^<!DOCTYPE html^>                                                            >Hello.htm
    ECHO ^<html^>                                                                    >>Hello.htm
    ECHO ^<body^>                                                                    >>Hello.htm
    ECHO ^<p^>                                                                       >>Hello.htm
    ECHO ^<span style='font-size:%numericFontSize%pt'^>Hello ^</span^>               >>Hello.htm
    ECHO ^<span style='font-size:%numericFontSize%pt;color:%color%'^>%name%^</span^> >>Hello.htm
    ECHO ^</p^>                                                                      >>Hello.htm
    ECHO ^</body^>                                                                   >>Hello.htm
    ECHO ^</html^>                                                                   >>Hello.htm
      
	REM Clean up by reseting all variables.
    SET fontSize=
        SET numericFontSize=
            SET color=
                SET name=
	
	REM Advise user 'Hello.htm' has been saved. 
	REM Keeps CMD open for the user. 
	ECHO Save successful.
	GOTO :EOF
