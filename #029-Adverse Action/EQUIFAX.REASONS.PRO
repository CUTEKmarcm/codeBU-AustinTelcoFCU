[EQUIFAX.REASONS.PRO]

PROCEDURE GETLETTERFILEINFO
 FILEOPEN("HELP","EQUIFAX.CODES","READ",FNUMBER,FERROR)
  IF FERROR<>" " THEN POPUPMESSAGE(0,"Error in Opening EQUIFAX.CODES - "+FERROR)
  ELSE
   DO
    WHILE FERROR=""
     DO
      FILEREADLINE(FNUMBER,FLINE,FERROR)
      IF SEGMENT(FLINE,1,1)="Y" THEN LR=99
      ELSE LR=VALUE(SEGMENT(FLINE,1,2))
      IF LR>0 THEN REASONDESC(LR)=SEGMENT(FLINE,4,LENGTH(FLINE))
     END
   END
 FILECLOSE(FNUMBER,FERROR)
END

PROCEDURE GETREASONS
 L1=0
 L2=0
 L3=0
 L4=0
 L5=0
 BEACON=0
 BEACONDATE='--/--/--'
 TMAX=0
 TMIN=0
 FOR EACH TRACKING WITH TRACKING:TYPE=31                             [CURRENT BEAON INFORMATION]
  DO
   IF FSSN=TRACKING:USERCHAR1 THEN
    DO
     BEACON=TRACKING:USERNUMBER1
     TMAX=TRACKING:USERNUMBER11
     TMIN=TRACKING:USERNUMBER16
     BEACONDATE=TRACKING:USERDATE1
     TEMPREASON=TRACKING:USERCHAR16
     CALL GET4REASONS
    END
   ELSE IF FSSN=TRACKING:USERCHAR2 THEN
    DO
     BEACON=TRACKING:USERNUMBER2
     TMAX=TRACKING:USERNUMBER12
     TMIN=TRACKING:USERNUMBER17
     BEACONDATE=TRACKING:USERDATE2
     TEMPREASON=TRACKING:USERCHAR17
     CALL GET4REASONS
    END
   ELSE IF FSSN=TRACKING:USERCHAR3 THEN
    DO
     BEACON=TRACKING:USERNUMBER3
     TMAX=TRACKING:USERNUMBER13
     TMIN=TRACKING:USERNUMBER18
     BEACONDATE=TRACKING:USERDATE3
     TEMPREASON=TRACKING:USERCHAR18
     CALL GET4REASONS
    END
   ELSE IF FSSN=TRACKING:USERCHAR4 THEN
    DO
     BEACON=TRACKING:USERNUMBER4
     TMAX=TRACKING:USERNUMBER14
     TMIN=TRACKING:USERNUMBER19
     BEACONDATE=TRACKING:USERDATE4
     TEMPREASON=TRACKING:USERCHAR19
     CALL GET4REASONS
    END
   ELSE IF FSSN=TRACKING:USERCHAR5 THEN
    DO
     BEACON=TRACKING:USERNUMBER5
     TMAX=TRACKING:USERNUMBER15
     TMIN=TRACKING:USERNUMBER20
     BEACONDATE=TRACKING:USERDATE5 
     TEMPREASON=TRACKING:USERCHAR20
     CALL GET4REASONS
    END
  END 
END

PROCEDURE GET4REASONS
 FOR I=1 TO 5
  DO
   CM=CHARACTERSEARCH(TEMPREASON,",")
   TREASON=0
   IF CM=0 AND LENGTH(TEMPREASON)>0 THEN
    DO
     IF TEMPREASON="Y" THEN TREASON=99
     ELSE TREASON=VALUE(TEMPREASON)
    END
   ELSE IF CM>0 THEN
    DO
     TREASON=VALUE(SEGMENT(TEMPREASON,1,CM-1))
     TEMPREASON=SEGMENT(TEMPREASON,CM+1,LENGTH(TEMPREASON))
    END
   IF TREASON<>0 THEN
    DO
     IF L1=0 THEN L1=TREASON
     ELSE IF L2=0 THEN L2=TREASON
     ELSE IF L3=0 THEN L3=TREASON
     ELSE IF L4=0 THEN L4=TREASON
     ELSE IF L5=0 THEN L5=TREASON
    END
  END
 LR=1
 IF L1>0 THEN
  DO 
   IF L1=99 OR LENGTH(REASONDESC(L1))<=80 THEN 
    LISTREASON(LR)=REASONDESC(L1)
   ELSE
    DO
     LISTREASON(LR)=SEGMENT(REASONDESC(L1),1,80)
     LR=LR+1
     LISTREASON(LR)=" "+SEGMENT(REASONDESC(L1),81,LENGTH(REASONDESC(L1)))
    END   
   LR=LR+2   
  END  
 IF L2>0 THEN
  DO
   IF L2=99 OR LENGTH(REASONDESC(L2))<=80 THEN LISTREASON(LR)=REASONDESC(L2)
   ELSE
    DO
     LISTREASON(LR)=SEGMENT(REASONDESC(L2),1,80)
     LR=LR+1
     LISTREASON(LR)=" "+SEGMENT(REASONDESC(L2),81,LENGTH(REASONDESC(L2)))
    END   
   LR=LR+2   
  END   
 IF L3>0 THEN
  DO
   IF L3=99 OR LENGTH(REASONDESC(L3))<=80 THEN LISTREASON(LR)=REASONDESC(L3)
   ELSE
    DO
     LISTREASON(LR)=SEGMENT(REASONDESC(L3),1,80)
     LR=LR+1
     LISTREASON(LR)=" "+SEGMENT(REASONDESC(L3),81,LENGTH(REASONDESC(L3)))
    END   
   LR=LR+2
  END   
 IF L4>0 THEN
  DO
   IF L4=99 OR LENGTH(REASONDESC(L4))<=80 THEN LISTREASON(LR)=REASONDESC(L4)
   ELSE
    DO
     LISTREASON(LR)=SEGMENT(REASONDESC(L4),1,80)
     LR=LR+1
     LISTREASON(LR)=" "+SEGMENT(REASONDESC(L4),81,LENGTH(REASONDESC(L4)))
    END    
   LR=LR+2
  END  
 IF L5>0 THEN
  DO
   IF L5=99 OR LENGTH(REASONDESC(L5))<=80 THEN LISTREASON(LR)=REASONDESC(L5)
   ELSE
    DO
     LISTREASON(LR)=SEGMENT(REASONDESC(L5),1,80)
     LR=LR+1
     LISTREASON(LR)=" "+SEGMENT(REASONDESC(L5),81,LENGTH(REASONDESC(L5)))
    END   
   LR=LR+2
  END 
END
