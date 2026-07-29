import ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean.AdmissibleClass

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean

structure TheoremSpecificObject where
  sourceKey : String
  theoremObject : String
  claimBoundary : String
deriving Repr, DecidableEq

structure AdmittedTheoremObject where
  object : TheoremSpecificObject
  localWitness : String
  bridgeEvidence : String
  sourceKeyChecked : object.sourceKey = "FluidMechanicsChemical"
  theoremObjectChecked : object.theoremObject = "ContinuumNavierStokesEnergyEquation"

structure ClosureState where
  object : AdmittedTheoremObject

def theoremSpecificObject : TheoremSpecificObject := {
  sourceKey := "FluidMechanicsChemical",
  theoremObject := "ContinuumNavierStokesEnergyEquation",
  claimBoundary := "Energy dissipation closure for incompressible Navier-Stokes"
}

def NativeBridgeClosed (O : AdmittedTheoremObject) : Prop :=
  O.object.sourceKey = "FluidMechanicsChemical" ∧ O.object.theoremObject = "ContinuumNavierStokesEnergyEquation"

end ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean
end HautevilleHouse