#ifdef ALLOW_GUD

CBOP
C    !ROUTINE: GUD_SIZE.h
C    !INTERFACE:
C #include GUD_SIZE.h

C    !DESCRIPTION:
C Contains dimensions and index ranges for cell model.

      integer nplank, nGroup, nlam, nopt
      integer nPhoto
      integer iMinBact, iMaxBact
      integer iMinPrey, iMaxPrey
      integer iMinPred, iMaxPred
      integer nChl
      integer nPPplank
      integer nGRplank
      integer nEXplank
      integer nGWplank
      integer nDNplank
      integer nDPplank
      integer nDFplank
      integer nDSplank
      integer nDMplank
      parameter(nlam=1)
      parameter(nopt=1)
      parameter(nplank=3)
      parameter(nGroup=3)
      parameter(nPhoto=2)
      parameter(iMinBact=nPhoto+1, iMaxBact=nPhoto)
      parameter(iMinPrey=1, iMaxPrey=3)
      parameter(iMinPred=3, iMaxPred=nplank)
      parameter(nChl=nPhoto)
      parameter(nPPplank=2)
      parameter(nEXplank=2)
      parameter(nGWplank=2)
      parameter(nDNplank=2)
      parameter(nDPplank=2)
      parameter(nDFplank=2)
      parameter(nDSplank=0)
      parameter(nDMplank=2)
      parameter(nGRplank=0)

CEOP
#endif /* ALLOW_GUD */
