import canonicalLaneMathlib.AdmissibleClass
import ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean.ChemicalEndpointGate

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean

def ConstrainedChemicalClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_chemical_endgame (A : AdmissibleClass) :
    ConstrainedChemicalClosure A :=
  And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean
end HautevilleHouse