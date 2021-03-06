#include "GUD_OPTIONS.h"

c=============================================================
c subroutine GUD_cons
c check conservation in the model
C==============================================================
      SUBROUTINE GUD_CONS(myTime,myIter,myThid)
#include "SIZE.h"
#include "EEPARAMS.h"
#include "PARAMS.h"
#include "GRID.h"
#include "PTRACERS_SIZE.h"
#include "PTRACERS_FIELDS.h"
#include "GUD_SIZE.h"
#include "GUD_INDICES.h"
#include "GUD_GENPARAMS.h"
#include "GUD_TRAITS.h"
#include "GUD_FIELDS.h"

C     === Global variables ===
      _RL myTime
      INTEGER myIter
      INTEGER myThid

#ifdef GUD_ALLOW_CONS

C============== Local variables ============================================
      _RL tmptotC
      _RL tmptotP
      _RL tmptotN
      _RL tmptotSi
      _RL tmptotFe
#ifdef GUD_ALLOW_CARBON
      _RL tmptotA
      _RL tmptotO
#endif
      _RL tmptotNfix
      _RL tmptotNdenit
      _RL vol, voltot

      INTEGER i,j,k,bi,bj
      INTEGER np, iTr
c
      tmptotC = 0. _d 0
      tmptotP = 0. _d 0
      tmptotN = 0. _d 0
      tmptotFe = 0. _d 0
      tmptotSi = 0. _d 0
#ifdef GUD_ALLOW_CARBON
      tmptotA = 0. _d 0
      tmptotO = 0. _d 0
#endif
      tmptotNfix = 0. _d 0
      tmptotNdenit = 0. _d 0
      voltot = 0. _d 0

      DO bj=myByLo(myThid),myByHi(myThid)
      DO bi=myBxLo(myThid),myBxHi(myThid)
 
        DO k=1,Nr
        DO i=1,sNx
        DO j=1,sNy
c-----------------------------------------------------------------
          vol=rA(i,j,bi,bj)*drF(k)*hFacC(i,j,k,bi,bj)
          voltot=voltot+vol

c carbon budget
          tmptotC=tmptotC+Ptracer(i,j,k,bi,bj,iDIC)*vol   !DIC
          tmptotC=tmptotC+Ptracer(i,j,k,bi,bj,iDOC)*vol   !DOC
          tmptotC=tmptotC+Ptracer(i,j,k,bi,bj,iPOC)*vol   !POC
          tmptotC=tmptotC+Ptracer(i,j,k,bi,bj,iPIC)*vol   !PIC
          DO np=1,nplank
            iTr=ic+np-1
            tmptotC=tmptotC+Ptracer(i,j,k,bi,bj,iTr)*vol  !Phy
          ENDDO
#ifdef GUD_ALLOW_CDOM
          tmptotC=tmptotC+Ptracer(i,j,k,bi,bj,iCDOM)*R_CP_CDOM*vol  !CDOM
#endif

c Phosphorus budget
          tmptotP=tmptotP+Ptracer(i,j,k,bi,bj,iPO4)*vol    !PO4
          tmptotP=tmptotP+Ptracer(i,j,k,bi,bj,iDOP)*vol    !DOP
          tmptotP=tmptotP+Ptracer(i,j,k,bi,bj,iPOP)*vol   !POP
          DO np=1,nplank
#ifdef GUD_ALLOW_PQUOTA
            iTr=ip+np-1
            tmptotP=tmptotP+Ptracer(i,j,k,bi,bj,iTr)*vol  !Phy 
#else
            iTr=ic+np-1
            tmptotP=tmptotP+Ptracer(i,j,k,bi,bj,iTr)*R_PC(np)*vol  !Phy 
#endif
          ENDDO
#ifdef GUD_ALLOW_CDOM
          tmptotP=tmptotP+Ptracer(i,j,k,bi,bj,iCDOM)*vol     !CDOM
#endif

c Nitrogen budget
          tmptotN=tmptotN+Ptracer(i,j,k,bi,bj,iNO3)*vol    !NO3
          tmptotN=tmptotN+Ptracer(i,j,k,bi,bj,iNH4)*vol   !NH4
          tmptotN=tmptotN+Ptracer(i,j,k,bi,bj,iNO2)*vol   !NO2
          tmptotN=tmptotN+Ptracer(i,j,k,bi,bj,iDON)*vol    !DON
          tmptotN=tmptotN+Ptracer(i,j,k,bi,bj,iPON)*vol   !PON
          DO np=1,nplank
#ifdef GUD_ALLOW_NQUOTA
            iTr=in+np-1
            tmptotN=tmptotN+Ptracer(i,j,k,bi,bj,iTr)*vol  !Phy
#else
            iTr=ic+np-1
            tmptotN=tmptotN+Ptracer(i,j,k,bi,bj,iTr)*R_NC(np)*vol  !Phy
#endif
          ENDDO
#ifdef GUD_ALLOW_CDOM
          tmptotN=tmptotN+Ptracer(i,j,k,bi,bj,iCDOM)*R_NP_CDOM*vol  !CDOM
#endif

c Iron budget
          tmptotFe=tmptotFe+Ptracer(i,j,k,bi,bj,iFeT)*vol    !Fet
          tmptotFe=tmptotFe+Ptracer(i,j,k,bi,bj,iDOFe)*vol   !DOFe
          tmptotFe=tmptotFe+Ptracer(i,j,k,bi,bj,iPOFe)*vol   !POFe
          DO np=1,nplank
#ifdef GUD_ALLOW_FEQUOTA
            iTr=ife+np-1
            tmptotFe=tmptotFe+Ptracer(i,j,k,bi,bj,iTr)*vol  !Phy
#else
            iTr=ic+np-1
            tmptotFe=tmptotFe+Ptracer(i,j,k,bi,bj,iTr)*R_FeC(np)*vol  !Phy
#endif
          ENDDO
#ifdef GUD_ALLOW_CDOM
          tmptotFe=tmptotFe+Ptracer(i,j,k,bi,bj,iCDOM)*R_FeP_CDOM*vol  !CDOM
#endif

c Silica budget
          tmptotSi=tmptotSi+Ptracer(i,j,k,bi,bj,iSiO2)*vol   !Si
          tmptotSi=tmptotSi+Ptracer(i,j,k,bi,bj,iPOSi)*vol   !POSi
          DO np=1,nplank
#ifdef GUD_ALLOW_SIQUOTA
            iTr=isi+np-1
            tmptotSi=tmptotSi+Ptracer(i,j,k,bi,bj,iTr)*vol  !Phy
#else
            iTr=ic+np-1
            tmptotSi=tmptotSi+Ptracer(i,j,k,bi,bj,iTr)*R_SiC(np)*vol  !Phy
#endif
          ENDDO
c------------------------------------------------------------
#ifdef GUD_ALLOW_CARBON
c alkalinity budget !!!!! NOT FULL BUDGET!!!!!
          tmptotA=tmptotA+Ptracer(i,j,k,bi,bj,iALK)*vol    !ALK
c oxygem budget !!!!!!!! NOT FULL BUDGET !!!!!!!!!!!
          tmptotO=tmptotO+Ptracer(i,j,k,bi,bj,iO2)*vol    !O2
#endif

          tmptotNfix=tmptotNfix+GUD_Nfix(i,j,k,bi,bj)*vol
          tmptotNdenit=tmptotNdenit+GUD_Ndenit(i,j,k,bi,bj)*vol
        ENDDO
        ENDDO
        ENDDO
      ENDDO
      ENDDO

      _GLOBAL_SUM_RL(tmptotC,myThid)
      _GLOBAL_SUM_RL(tmptotP,myThid)
      _GLOBAL_SUM_RL(tmptotN,myThid)
      _GLOBAL_SUM_RL(tmptotFe,myThid)
      _GLOBAL_SUM_RL(tmptotSi,myThid)
      _GLOBAL_SUM_RL(voltot,myThid)
#ifdef GUD_ALLOW_CARBON
      _GLOBAL_SUM_RL(tmptotA,myThid)
      _GLOBAL_SUM_RL(tmptotO,myThid)
#endif
      _GLOBAL_SUM_RL(tmptotNfix,myThid)
      _GLOBAL_SUM_RL(tmptotNdenit,myThid)

      IF ( myProcId.EQ.0 .AND. myThid.EQ.1 ) THEN
        WRITE(GUD_cons_C_unit,*), myIter, tmptotC, tmptotC/voltot
        WRITE(GUD_cons_P_unit,*), myIter, tmptotP, tmptotP/voltot
        WRITE(GUD_cons_N_unit,*), myIter, tmptotN, tmptotN/voltot,
     &                 tmptotNfix/voltot, tmptotNdenit/voltot
        WRITE(GUD_cons_Fe_unit,*), myIter, tmptotFe, tmptotFe/voltot
        WRITE(GUD_cons_Si_unit,*), myIter, tmptotSi, tmptotSi/voltot
#ifdef GUD_ALLOW_CARBON
        WRITE(GUD_cons_A_unit,*), myIter, tmptotA, tmptotA/voltot
        WRITE(GUD_cons_O_unit,*), myIter, tmptotO, tmptotO/voltot
#endif
      ENDIF

C--   Everyone else must wait
      _BARRIER

#endif /* GUD_ALLOW_CONS */

      RETURN
      END

