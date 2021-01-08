#ifdef ALLOW_GUD

CBOP
C    !ROUTINE: GUD_DIAGS.h
C    !INTERFACE:
C #include GUD_DIAGS.h

C    !DESCRIPTION:
C Contains indices into diagnostics array

      integer iPP
      integer iEX
      integer iGW
      integer iDN
      integer iDP
      integer iDFe
      integer iDSi
      integer iDmin
      integer iDOCp
      integer iDOCg
      integer iNfix
      integer iDenit
      integer iDenitN
      integer iPPplank
      integer iEXplank
      integer iGWplank
      integer iDNplank
      integer iDPplank
      integer iDFplank
      integer iDMplank
      integer iGRplank
      integer iConsDIN
      integer iConsPO4
      integer iConsSi
      integer iConsFe
      integer gud_nDiag
      PARAMETER(iPP=      1)
      PARAMETER(iNfix=    2)
      PARAMETER(iDenit=   3)
      PARAMETER(iDenitN=  4)
      PARAMETER(iConsPO4= 5)
      PARAMETER(iConsSi=  6)
      PARAMETER(iConsFe=  7)
      PARAMETER(iConsDIN= 8)
      PARAMETER(iEX=      9)
      PARAMETER(iGW=     10)
      PARAMETER(iDN=     11)
      PARAMETER(iDP=     12)
      PARAMETER(iDFe=    13)
      PARAMETER(iDSi=    14)
      PARAMETER(iDmin=   15)
      PARAMETER(iDOCp=   16)
      PARAMETER(iDOCg=   17)
      PARAMETER(iPPplank=18)
      PARAMETER(iEXplank=iPPplank+nPPplank)
      PARAMETER(iGWplank=iEXplank+nEXplank)
      PARAMETER(iDNplank=iGWplank+nGWplank)
      PARAMETER(iDPplank=iDNplank+nDNplank)
      PARAMETER(iDFplank=iDPplank+nDPplank)
      PARAMETER(iDMplank=iDFplank+nDFplank)
      PARAMETER(iGRplank=iDMplank+nDMplank)
      PARAMETER(gud_nDiag=iGRplank+nGRplank-1)

CEOP
#endif /* ALLOW_GUD */
