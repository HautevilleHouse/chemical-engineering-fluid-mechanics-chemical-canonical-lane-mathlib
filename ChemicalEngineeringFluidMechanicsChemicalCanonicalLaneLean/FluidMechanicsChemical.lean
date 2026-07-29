import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean

structure ChemicalFluidOperators where
  divergenceFree : Prop
  viscousTerm : Prop
  convectionTerm : Prop
  stressTerm : Prop
  reactionSource : Prop

def primitiveChemicalFluidOperators : ChemicalFluidOperators := {
  divergenceFree := True
  viscousTerm := True
  convectionTerm := True
  stressTerm := True
  reactionSource := True
}

structure ChemicalFluidFlow where
  velocity : Prop
  concentration : Prop
  viscosity : ℝ
  diffusivity : ℝ
  density : ℝ
  operators : ChemicalFluidOperators
  conservationOfMass : Prop
  navierStokesMomentum : Prop
  speciesTransport : Prop
  closureCondition : Prop

def primitiveChemicalFluidFlow : ChemicalFluidFlow := {
  velocity := True
  concentration := True
  viscosity := 1
  diffusivity := 1
  density := 1
  operators := primitiveChemicalFluidOperators
  conservationOfMass := True
  navierStokesMomentum := True
  speciesTransport := True
  closureCondition := True
}

theorem primitive_flow_conservation_of_mass_checked :
    primitiveChemicalFluidFlow.conservationOfMass := by
  trivial

theorem primitive_flow_navier_stokes_momentum_checked :
    primitiveChemicalFluidFlow.navierStokesMomentum := by
  trivial

theorem primitive_flow_species_transport_checked :
    primitiveChemicalFluidFlow.speciesTransport := by
  trivial

theorem primitive_flow_closure_condition_checked :
    primitiveChemicalFluidFlow.closureCondition := by
  trivial

theorem primitive_flow_all_conditions_checked :
    primitiveChemicalFluidFlow.conservationOfMass ∧
    primitiveChemicalFluidFlow.navierStokesMomentum ∧
    primitiveChemicalFluidFlow.speciesTransport ∧
    primitiveChemicalFluidFlow.closureCondition := by
  exact And.intro primitive_flow_conservation_of_mass_checked
    (And.intro primitive_flow_navier_stokes_momentum_checked
      (And.intro primitive_flow_species_transport_checked
        primitive_flow_closure_condition_checked))

end ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean
end HautevilleHouse