#!/usr/bin/env python3
"""
default parameter values like those of Stan's fortran examples--yield rather similar output
Note that the number of bins for altitude and energy are "compiled in" the Fortran.
It would require substantial changes to the Fortran code to make these dynamic due to Common Block
usage in the Fortran77 code. Stan Solomon is upgrading the GLOW code to Fortran 90 with modules,
so I will perhaps try again with dynamic bin size for altitude and energy when
that code is available.

Michael Hirsch
Sept 2015
"""
from __future__ import division,absolute_import
from dateutil.parser import parse
from matplotlib.pyplot import show
#
from glowaurora.runglow import runglowaurora,plotaurora

def E0aurora(dt,glatlon,flux,E0,f107a,f107,f107p,ap):

    (glat,glon) = glatlon

    vers = []

    for e0 in E0:
        print('char. energy {}'.format(e0))

        ver,photIon,isr,phitop,zceta = runglowaurora(flux,e0,
                                              dt,glat,glon,
                                              f107a,f107,f107p,ap)

        vers.append(ver)

        plotaurora(phitop,ver,zceta,photIon,isr,dtime,glat,glon,e0)

    return vers,photIon,isr,phitop,zceta

if __name__ == '__main__':
    from argparse import ArgumentParser
    p = ArgumentParser(description="Stan Solomon's GLOW auroral model")
    p.add_argument('simtime',help='yyyy-mm-ddTHH:MM:SSZ time of sim',nargs='?',default='1999-12-21T00:00:00Z')
    p.add_argument('-c','--latlon',help='geodetic latitude/longitude (deg)',type=float,nargs=2,default=(70,0))
    p.add_argument('--flux',help='overall incident flux [erg ...]',type=float,default=1.)
    p.add_argument('--e0',help='characteristic energy [eV]',type=float,nargs='+',default=(1e3,))
    p.add_argument('--f107a',help='AVERAGE OF F10.7 FLUX',type=float,default=100)
    p.add_argument('--f107p',help='DAILY F10.7 FLUX FOR PREVIOUS DAY',type=float,default=100)
    p.add_argument('--f107',help='F10.7 for sim. day',type=float,default=100)
    p.add_argument('--ap',help='daily ap',type=float,default=4)
    p = p.parse_args()

    dtime = parse(p.simtime)

    ver,photIon,isr,phitop,zceta = E0aurora(dtime,p.latlon,p.flux,p.e0,p.f107a,p.f107,p.f107p,p.ap)

    show()
