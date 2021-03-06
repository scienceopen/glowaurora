C Subroutine GEOMAG
C
C Excerpted from the IRI package, Stan Solomon, 6/88.  Original name was
C GMAG, which was changed to avoid conflict when used at the same time
C as IRI.  Labeled common /CONST/ which contained only the degree/radian
C conversion factor was changed to a data statement.  Longitude range
C from -180 to 180.
C
C CALCULATES GEOMAGNETIC LONGITUDE (MLONG) AND LATITUDE (MLAT)
C FROM GEOGRAFIC LONGITUDE (LONG) AND LATITUDE (LATI) FOR ART=0
C AND REVERSE FOR ART=1. ALL ANGLES IN DEGREE.
C LATITUDE:-90 TO 90. LONGITUDE:0 TO 360 EAST.
C
      SUBROUTINE GEOMAG(ART,LONG,LATI,MLONG,MLAT)
      INTEGER ART
      REAL MLONG,MLAT,LONG,LATI
      DATA FAKTOR/.0174532952/
      ZPI=FAKTOR*360.
      CBG=11.4*FAKTOR
      CI=COS(CBG)
      SI=SIN(CBG)
      IF(ART.EQ.0) GOTO 10
      CBM=COS(MLAT*FAKTOR)
      SBM=SIN(MLAT*FAKTOR)
      CLM=COS(MLONG*FAKTOR)
      SLM=SIN(MLONG*FAKTOR)
      SBG=SBM*CI-CBM*CLM*SI
      LATI=ASIN(SBG)
      CBG=COS(LATI)
      SLG=(CBM*SLM)/CBG
      CLG=(SBM*SI+CBM*CLM*CI)/CBG
      IF(CLG.GT.1.) CLG=1.
      LONG=ACOS(CLG)
      IF(SLG.LT.0.0) LONG=ZPI-ACOS(CLG)
      LATI=LATI/FAKTOR
      LONG=LONG/FAKTOR
      LONG=LONG-69.8
      IF(LONG.LT.-180.0) LONG=LONG+360.0
      IF(LONG.GT. 180.0) LONG=LONG-360.0
      RETURN
 10   YLG=LONG+69.8
      CBG=COS(LATI*FAKTOR)
      SBG=SIN(LATI*FAKTOR)
      CLG=COS(YLG*FAKTOR)
      SLG=SIN(YLG*FAKTOR)
      SBM=SBG*CI+CBG*CLG*SI
      MLAT=ASIN(SBM)
      CBM=COS(MLAT)
      SLM=(CBG*SLG)/CBM
      CLM=(-SBG*SI+CBG*CLG*CI)/CBM
      IF(CLM.GT.1.) CLM=1.
      MLONG=ACOS(CLM)
      IF(SLM.LT..0) MLONG=ZPI-ACOS(CLM)
      MLAT=MLAT/FAKTOR
      MLONG=MLONG/FAKTOR
      IF(MLONG.LT.-180.0) MLONG=MLONG+360.0
      IF(MLONG.GT. 180.0) MLONG=MLONG-360.0
      RETURN
      END
