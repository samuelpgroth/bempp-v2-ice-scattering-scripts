#---------------------- Scattering by an ice crystal --------------------------# 
# S.P.Groth 15/04/15

# An unpolarized wave travelling in the x-direction strikes a dielectric 
# obstacle in fixed orientation. 
# Calculate the scattering matrix elements in the x-y plane, and the scattering,
# extinction and absorption cross sections. 
# See "The boundary element method for light scattering by ice crystals and its
# implementation in BEM++" for more details of setup.

# INPUTS required: 
# - exterior wavenumber:                       kExt
# - refractive index (a list is provided):     ref_ind
# - rotation angle of scatterer about z-axis:  thetaInc (=0 for examples in paper)
# - mesh file:                                 shape, h_mesh    


# Help Python find the bempp module
import sys
sys.path.append("..")
from bempp.lib import *
import numpy as np
import time
startTime = time.time()
print startTime,'s'

#--------------------------------- INPUTS -------------------------------------#
# Exterior wavenumber
kExt = 10

rInd = 2  # This is for naming the output files later, each corresponds to a particular refractive index, see next if statement
if rInd == 1:
    ref_ind = 1.0893+0.18216j
elif rInd == 2:
    ref_ind = 1.3110+2.289e-9j  # lamda =  0.55 microns
elif rInd == 3:
    ref_ind = 1.289+2.659e-4j   # lamda = 1.613 microns
elif rInd == 4:
    ref_ind = 1.3924+6.672e-3j  # lamda = 3.732 microns
elif rInd == 5:
    ref_ind = 1.0833+2.04e-1j   # lamda = 10.87 microns
elif rInd == 6:
    ref_ind = 1.2546+4.09e-1j   # lamda = 11.9 microns

# Rotation of crystal about z-axis (=0 for examples in paper)
thetaInc = 0  

# Mesh
shape = 'hex'     # choose scatterer shape (e.g., sphere, hex, 6branches)
h_mesh = '0.126'  # choose mesh resolution, smaller h_mesh leads to better accuracy
# h_mesh approx= 2*pi/(kExt*N) where N is the number of elements per wavelength, see 
# mesh file names for h_mesh values available 
grid = createGridFactory().importGmshGrid(
    "triangular","{0}{1}{2}{3}{4}".format("../../examples/meshes/",shape,"-a-1-e-",h_mesh,".msh"))
#------------------------------------------------------------------------------#

muInt = 1
muExt = 1
kInt = kExt * ref_ind
rho = (kInt * muExt) / (kExt * muInt)

# Create quadrature strategy
accuracyOptions = createAccuracyOptions()
# Increase by 2 the order of quadrature rule used to approximate
# integrals of regular functions on pairs on elements
accuracyOptions.doubleRegular.setRelativeQuadratureOrder(2)
# Increase by 2 the order of quadrature rule used to approximate
# integrals of regular functions on single elements
accuracyOptions.singleRegular.setRelativeQuadratureOrder(2)
#accuracyOptions.doubleSingular.setRelativeQuadratureOrder(2)
quadStrategy = createNumericalQuadratureStrategy(
    "float64", "complex128", accuracyOptions)

# Create assembly context
assemblyOptions = createAssemblyOptions()
acaOptions = createAcaOptions()
acaOptions.eps = 1e-5
assemblyOptions.switchToAcaMode(createAcaOptions())
context = createContext(quadStrategy, assemblyOptions)

# Initialize spaces
space = createRaviartThomas0VectorSpace(context, grid)

# Construct elementary operators
slpOpExt = createMaxwell3dSingleLayerBoundaryOperator(
    context, space, space, space, kExt, "SLP_ext")
dlpOpExt = createMaxwell3dDoubleLayerBoundaryOperator(
    context, space, space, space, kExt, "DLP_ext")
slpOpInt = createMaxwell3dSingleLayerBoundaryOperator(
    context, space, space, space, kInt, "SLP_int")
dlpOpInt = createMaxwell3dDoubleLayerBoundaryOperator(
    context, space, space, space, kInt, "DLP_int")
idOp = createMaxwell3dIdentityOperator(
    context, space, space, space, "Id")

# Form the left- and right-hand-side operators
lhsOp00 = -(slpOpExt + rho * slpOpInt)
lhsOp01 = lhsOp10 = dlpOpExt + dlpOpInt
lhsOp11 = slpOpExt + (1. / rho) * slpOpInt

lhsOp = createBlockedBoundaryOperator(
context, [[lhsOp00, lhsOp01], [lhsOp10, lhsOp11]])
    
# Create the potential operators entering the Green's representation formula
slPotInt = createMaxwell3dSingleLayerPotentialOperator(context, kInt)
dlPotInt = createMaxwell3dDoubleLayerPotentialOperator(context, kInt)
slPotExt = createMaxwell3dSingleLayerPotentialOperator(context, kExt)
dlPotExt = createMaxwell3dDoubleLayerPotentialOperator(context, kExt)

evalOptions = createEvaluationOptions()

# Evaluate the far-field pattern of the scattered field 

# Create the necessary potential operators
slFfPot = createMaxwell3dFarFieldSingleLayerPotentialOperator(context, kExt)
dlFfPot = createMaxwell3dFarFieldDoubleLayerPotentialOperator(context, kExt)
    
# Create incident field definition and its Dirichlet and Neumann traces
def evalIncDirichletTrace(point, normal):
	field = evalIncField(point,thetaInc)
	result = np.cross(field, normal, axis=0)
	return result

def evalIncDirichletTrace1(point, normal):
	field = evalIncField1(point,thetaInc)
	result = np.cross(field, normal, axis=0)
	return result

def evalIncNeumannTrace(point, normal):
	x, y, z = point
	dInc = np.array([np.cos(thetaInc),np.sin(thetaInc),0])
	curl = np.array([1j*kExt*np.sin(thetaInc)*np.exp(1j*kExt*np.dot(point,dInc)),-1j*kExt*np.cos(thetaInc)*np.exp(1j*kExt*np.dot(point,dInc)),x*0.])
	result = np.cross(curl / (1j * kExt), normal, axis=0)
	return result

def evalIncNeumannTrace1(point, normal):
	x, y, z = point
	dInc = np.array([np.cos(thetaInc),np.sin(thetaInc),0])
	curl = np.array([x*0.,x*0.,1j*kExt*np.exp(1j*kExt*np.dot(point,dInc))])
	result = np.cross(curl / (1j * kExt), normal, axis=0)
	return result

# Incident field polarized in z-direction
def evalIncField(point,thetaInc):
	x, y, z = point
	dInc = np.array([np.cos(thetaInc) , np.sin(thetaInc) ,  0])
	field = np.array([x * 0., y * 0., np.exp(1j * kExt * np.dot(point,dInc))]) 
	return field

# Incident field polarized in y-direction
def evalIncField1(point,thetaInc):
	x, y, z = point 
	dInc = np.array([np.cos(thetaInc) , np.sin(thetaInc) , 0])
	field = np.array([-np.sin(thetaInc)*np.exp(1j*kExt*np.dot(dInc,point)),np.cos(thetaInc)* np.exp(1j * kExt * np.dot(point,dInc)), z * 0.])
	return field

# Construct the grid functions representing the traces of the incident field
incDirichletTrace = createGridFunction(
context, space, space, evalIncDirichletTrace,
surfaceNormalDependent=True)
incNeumannTrace = createGridFunction(
context, space, space, evalIncNeumannTrace,
surfaceNormalDependent=True)
incDirichletTrace1 = createGridFunction(
context, space, space, evalIncDirichletTrace1,
surfaceNormalDependent=True)
incNeumannTrace1 = createGridFunction(
context, space, space, evalIncNeumannTrace1,
surfaceNormalDependent=True)


# Construct the right-hand-side grid function
rhs = [idOp * incNeumannTrace, idOp * incDirichletTrace]
rhs1 = [idOp * incNeumannTrace1, idOp * incDirichletTrace1]

# Initialize the solver
precTol = 1e-2
invLhsOp00 = acaOperatorApproximateLuInverse(
lhsOp00.weakForm().asDiscreteAcaBoundaryOperator(), precTol)
invLhsOp11 = acaOperatorApproximateLuInverse(
lhsOp11.weakForm().asDiscreteAcaBoundaryOperator(), precTol)
prec = discreteBlockDiagonalPreconditioner([invLhsOp00, invLhsOp11])

solver = createDefaultIterativeSolver(lhsOp)
solver.initializeSolver(defaultGmresParameterList(1e-8), prec)

# Solve the equation
solution = solver.solve(rhs)
print solution.solverMessage()

solution1 = solver.solve(rhs1)
print solution1.solverMessage()

endTime = time.time()

# Extract the solution components in the form of grid functions
extDirichletTrace = solution.gridFunction(0)
extNeumannTrace = solution.gridFunction(1)

scattDirichletTrace = extDirichletTrace - incDirichletTrace
scattNeumannTrace = extNeumannTrace - incNeumannTrace

intDirichletTrace = extDirichletTrace
intNeumannTrace = extNeumannTrace / rho

# Second polarization
extDirichletTrace1 = solution1.gridFunction(0)
extNeumannTrace1 = solution1.gridFunction(1)

scattDirichletTrace1 = extDirichletTrace1 - incDirichletTrace1
scattNeumannTrace1 = extNeumannTrace1 - incNeumannTrace1

intDirichletTrace1 = extDirichletTrace1
intNeumannTrace1 = extNeumannTrace1 / rho

# Amplitude scattering matrix
# z-polarisation
theta = np.linspace(0+thetaInc, 2 * np.pi+thetaInc, 3601)

points = np.vstack([np.cos(theta), np.sin(theta), 0. * theta])

ffp = (- slFfPot.evaluateAtPoints(scattNeumannTrace, points, evalOptions)
	    - dlFfPot.evaluateAtPoints(scattDirichletTrace, points, evalOptions))
Cext0 = 4*np.pi/(kExt**2)*np.real(-1j * kExt * ffp[2,0])

A22 = -1j * kExt * ffp[2,:]   # -1j * kExt is to make agree with eqn 3.21 p70 Bohren and Huffman

A12 = -1j * kExt * (- np.sin(theta) * (np.cos(thetaInc) * ffp[0,:] - np.sin(thetaInc) * ffp[1,:])
		+ np.cos(theta) * (np.sin(thetaInc) * ffp[0,:] + np.cos(thetaInc) * ffp[1,:]))

# y-polarisation
ffp = (- slFfPot.evaluateAtPoints(scattNeumannTrace1, points, evalOptions)
	   - dlFfPot.evaluateAtPoints(scattDirichletTrace1, points, evalOptions))
Cext1 = 4*np.pi/(kExt**2)*np.real(-1j * kExt * (-np.sin(thetaInc)*ffp[0,0]+np.cos(thetaInc)*ffp[1,0]))

Cext = 0.5*(Cext0 + Cext1)  

A11 = -1j * kExt * (- np.sin(theta) * (np.cos(thetaInc) * ffp[0,:] - np.sin(thetaInc) * ffp[1,:])
		+ np.cos(theta) * (np.sin(thetaInc) * ffp[0,:] + np.cos(thetaInc) * ffp[1,:]))

A21 = -1j * kExt * ffp[2,:]

import scipy.linalg
# Calculate scattering cross section with Gaussian quadrature
def gauss_legendre(n):
    k=np.arange(1.0,n)       
    a_band = np.zeros((2,n)) 
    a_band[1,0:n-1] = k/np.sqrt(4*k*k-1) 
    x,V=scipy.linalg.eig_banded(a_band,lower=True) 
    w=2*np.real(np.power(V[0,:],2)) 
    return x, w

# Evaluate scattering cross section and asymmetry parameter using Gaussian quadrature   
N = int( np.ceil(kExt*20) ) # Number of Gauss points (scale with kExt to ensure good accuracy)
[thetaG,w] = gauss_legendre(N)
thetaPos = 0.5*(thetaG+np.ones(N))*np.pi + thetaInc*np.ones(N)
thetaQuad = 0.5*(thetaG+np.ones(N))*np.pi
sinMult = np.sin(thetaQuad)
cosMult = np.cos(thetaQuad)

# Perform the integration over the two hemispheres separately and then sum together at the end

[PHI,w2] = gauss_legendre(N)
phi = 0.5*(PHI+np.ones(N))*np.pi
Int = np.zeros(N)
Int1 = np.zeros(N)
Intg = np.zeros(N)
Intg1 = np.zeros(N)

# First hemisphere integral
for i in range(0,N-1):
	pointsQuad = np.vstack([np.cos(thetaPos)*np.cos(thetaInc)-np.cos(phi[i])*np.sin(thetaPos)*np.sin(thetaInc),np.sin(thetaInc)*np.cos(thetaPos)+np.cos(phi[i])*np.sin(thetaPos)*np.cos(thetaInc),np.sin(phi[i])*np.sin(thetaPos)])
	ffpQuad = (- slFfPot.evaluateAtPoints(scattNeumannTrace, pointsQuad, evalOptions)
		    - dlFfPot.evaluateAtPoints(scattDirichletTrace, pointsQuad, evalOptions))
	ffpQuad1 = (- slFfPot.evaluateAtPoints(scattNeumannTrace1, pointsQuad, evalOptions)
		    - dlFfPot.evaluateAtPoints(scattDirichletTrace1, pointsQuad, evalOptions)) 
	ffpMagQuadSq = abs(ffpQuad[0,:])**2+abs(ffpQuad[1,:])**2+abs(ffpQuad[2,:])**2
	ffpMagQuadSq1 = abs(ffpQuad1[0,:])**2+abs(ffpQuad1[1,:])**2+abs(ffpQuad1[2,:])**2
	integrand = ffpMagQuadSq*sinMult
	integrand1 = ffpMagQuadSq1*sinMult
	integrand_g = ffpMagQuadSq*cosMult*sinMult
	integrand1_g = ffpMagQuadSq1*cosMult*sinMult
	Int[i] = np.pi/2*np.dot(integrand,w)
	Int1[i] = np.pi/2*np.dot(integrand1,w)
	Intg[i] = np.pi/2*np.dot(integrand_g,w)
	Intg1[i] = np.pi/2*np.dot(integrand1_g,w)

I1 = np.pi/2*np.dot(Int,w2)
I1_1 = np.pi/2*np.dot(Int1,w2)
I1_g = np.pi/2*np.dot(Intg,w2)
I1_g1 = np.pi/2*np.dot(Intg1,w2)

# Second hemisphere integral
phi = 0.5*(PHI+np.ones(N))*np.pi+np.pi*np.ones(N)
for i in range(0,N-1):
	pointsQuad = np.vstack([np.cos(thetaPos)*np.cos(thetaInc)-np.cos(phi[i])*np.sin(thetaPos)*np.sin(thetaInc),np.sin(thetaInc)*np.cos(thetaPos)+np.cos(phi[i])*np.sin(thetaPos)*np.cos(thetaInc),np.sin(phi[i])*np.sin(thetaPos)])
	ffpQuad = (- slFfPot.evaluateAtPoints(scattNeumannTrace, pointsQuad, evalOptions)
		    - dlFfPot.evaluateAtPoints(scattDirichletTrace, pointsQuad, evalOptions))
	ffpQuad1 = (- slFfPot.evaluateAtPoints(scattNeumannTrace1, pointsQuad, evalOptions)
		    - dlFfPot.evaluateAtPoints(scattDirichletTrace1, pointsQuad, evalOptions)) 
	ffpMagQuadSq = abs(ffpQuad[0,:])**2+abs(ffpQuad[1,:])**2+abs(ffpQuad[2,:])**2
	ffpMagQuadSq1 = abs(ffpQuad1[0,:])**2+abs(ffpQuad1[1,:])**2+abs(ffpQuad1[2,:])**2
	integrand = ffpMagQuadSq*sinMult
	integrand1 = ffpMagQuadSq1*sinMult
	integrand_g = integrand*cosMult
	integrand1_g = integrand1*cosMult
	Int[i] = np.pi/2*np.dot(integrand,w)
	Int1[i] = np.pi/2*np.dot(integrand1,w)
	Intg[i] = np.pi/2*np.dot(integrand_g,w)
	Intg1[i] = np.pi/2*np.dot(integrand1_g,w)

I2 = np.pi/2*np.dot(Int,w2)
I2_1 = np.pi/2*np.dot(Int1,w2)
I2_g = np.pi/2*np.dot(Intg,w2)
I2_g1 = np.pi/2*np.dot(Intg1,w2)

Csca0 = I1+I2
Csca1 = I1_1+I2_1
Csca = 0.5*(Csca0+Csca1)
Qsca = Csca/np.pi
asym0 = I1_g+I2_g
asym1 = I1_g1+I2_g1
asym = 0.5*(asym0+asym1)/Csca

print 'Cext =',Cext
print 'Csca =',Csca
print 'g =',asym

# Scattering matrix entries
S11 = 0.5*(abs(A11)**2+abs(A22)**2+abs(A21)**2+abs(A12)**2)
S12 = 0.5*(abs(A11)**2-abs(A22)**2+abs(A21)**2-abs(A12)**2)
S13 = np.real(A11*np.conjugate(A12)+A22*np.conjugate(A21))
S14 = np.imag(A11*np.conjugate(A12)-A22*np.conjugate(A21))
S21 = 0.5*(abs(A11)**2-abs(A22)**2-abs(A21)**2+abs(A12)**2)
S22 = 0.5*(abs(A11)**2+abs(A22)**2-abs(A21)**2-abs(A12)**2)
S23 = np.real(A11*np.conjugate(A12)-A22*np.conjugate(A21))
S24 = np.imag(A11*np.conjugate(A12)+A22*np.conjugate(A21))
S31 = np.real(A11*np.conjugate(A21)+A22*np.conjugate(A12))
S32 = np.real(A11*np.conjugate(A21)-A22*np.conjugate(A12))
S33 = np.real(np.conjugate(A11)*A22+A12*np.conjugate(A21))
S34 = np.imag(A11*np.conjugate(A22)+A21*np.conjugate(A12))
S41 = np.imag(np.conjugate(A11)*A21+np.conjugate(A12)*A22)
S42 = np.imag(np.conjugate(A11)*A21-np.conjugate(A12)*A22)
S43 = np.imag(A22*np.conjugate(A11)-A12*np.conjugate(A21))
S44 = np.real(np.conjugate(A11)*A22-A12*np.conjugate(A21))

P11 = 4*np.pi*S11/(kExt**2 * Csca)
P12 = 4*np.pi*S12/(kExt**2 * Csca)
P13 = 4*np.pi*S13/(kExt**2 * Csca)
P14 = 4*np.pi*S14/(kExt**2 * Csca)
P21 = 4*np.pi*S21/(kExt**2 * Csca)
P22 = 4*np.pi*S22/(kExt**2 * Csca)
P23 = 4*np.pi*S23/(kExt**2 * Csca)
P24 = 4*np.pi*S24/(kExt**2 * Csca)
P31 = 4*np.pi*S31/(kExt**2 * Csca)
P32 = 4*np.pi*S32/(kExt**2 * Csca)
P33 = 4*np.pi*S33/(kExt**2 * Csca)
P34 = 4*np.pi*S34/(kExt**2 * Csca)
P41 = 4*np.pi*S41/(kExt**2 * Csca)
P42 = 4*np.pi*S42/(kExt**2 * Csca)
P43 = 4*np.pi*S43/(kExt**2 * Csca)
P44 = 4*np.pi*S44/(kExt**2 * Csca)

endTimeAll = time.time()

print("Elapsed Solve Time was %g seconds" %(endTime-startTime))
print("Elapsed Total Time was %g seconds" %(endTimeAll-startTime))   

# Assemble these output parameters into one array
outputs = [kExt,h_mesh,ref_ind,Csca,Cext,asym,endTime-startTime,endTimeAll-startTime]
outputNames = '{0},{1},{2},{3},{4},{5},{6},{7}'.format('kExt','h_mesh','ref_ind','Csca','Cext','g','compTime','totalTime')
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('Outputs_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),outputs)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('OutputsNames_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),outputNames)

# Save outputs
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P11_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P11)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P12_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P12)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P13_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P13)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P14_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P14)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P21_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P21)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P22_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P22)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P23_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P23)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P24_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P24)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P31_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P31)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P32_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P32)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P33_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P33)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P34_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P34)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P41_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P41)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P42_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P42)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P43_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P43)
np.save('{0}{1}{2}{3}{4}{5}{6}{7}'.format('P44_',shape,'_k',str(int(kExt)),'_rInd',str(rInd),'_h',h_mesh),P44)
