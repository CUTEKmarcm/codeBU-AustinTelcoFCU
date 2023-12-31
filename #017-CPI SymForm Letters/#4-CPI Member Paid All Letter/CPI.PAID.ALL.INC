[Created by RD.SYMFORM.DESIGNER on 03/30/2023 at 10:41
 Driver           - CPI.PAID.ALL
 Field Assignment - CPI.PAID.ALL.INC
 Symform Commands - CPI.PAID.ALL.SYMFORM
 Form file name   - CPI.PAID.ALL.SFF
]

[Populate FORMDATA array]
PROCEDURE ASSIGNFIELDVARIABLES
  TOTALINDEX    = 0
  FIELDMAX      = 016
  DATACOUNT(01) = 016
  
  SPELLDATE=SYSTEMDATE
  CALL DATESPELL   
  FORMDATA(001)=SPELLCHAR
  
  FORMDATA(002)=CAPITALIZE(MEMBERNAME)
  IF JOINTMEMBERNAME<>"" THEN
   DO
    FORMDATA(003)=CAPITALIZE(JOINTMEMBERNAME)
    FORMDATA(004)=CAPITALIZE(MEMBERSTREET)
    IF MEMBEREXADDRESS<>"" THEN
     DO
      FORMDATA(004)=CAPITALIZE(MEMBERSTREET)+" "+CAPITALIZE(MEMBEREXADDRESS)
     END
    FORMDATA(005)=CAPITALIZE(MEMBERCITY)+", "+MEMBERSTATE+"  "+MEMBERZIP
   END
  ELSE
   DO
    FORMDATA(003)=CAPITALIZE(MEMBERSTREET)
    IF MEMBEREXADDRESS<>"" THEN
     DO
      FORMDATA(003)=CAPITALIZE(MEMBERSTREET)+" "+CAPITALIZE(MEMBEREXADDRESS)
     END
    FORMDATA(004)=CAPITALIZE(MEMBERCITY)+", "+MEMBERSTATE+"  "+MEMBERZIP    
    FORMDATA(005)=""
   END
  FORMDATA(006)=CAPITALIZE(MEMBERFIRSTNAME)+","  
  FORMDATA(007)=ACCTNO+"-"+LOANID
  
  FORMDATA(008)=FORMAT("###,##9.99",LADVAMNT)
  FORMDATA(009)=FORMAT("#,##9.99",NEWLOANPAYMENT)  
  FORMDATA(010)=FORMAT("##,##9.99",LOANPAYMENT)   
  
  SPELLDATE=LOANDUEDATE
  CALL DATESPELL  
  FORMDATA(011)=SPELLCHAR
  
  FORMDATA(012)=""
  FORMDATA(013)=""
  FORMDATA(014)=""
  FORMDATA(015)=""
  FORMDATA(016)=""

  FOR FORMLOOP=1 TO FIELDMAX
   DO
    TEMPCHAR=FORMDATA(FORMLOOP)
    CALL SLASHOUTPUT
    FORMDATA(FORMLOOP)=TEMPCHAR
   END
END

[Assign FORMDATA back for FM]
PROCEDURE UPDATEFIELDVARIABLES
END
