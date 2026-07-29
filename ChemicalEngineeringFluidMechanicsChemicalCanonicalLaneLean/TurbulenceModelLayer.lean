import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

/-!
# Turbulence Model Layer

This module defines basic turbulence quantities and the k-epsilon model for turbulent flow.
-/

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemical

abbrev TurbulentKineticEnergy := ℝ
abbrev DissipationRate := ℝ
abbrev ReynoldsStress := ℝ

structure TurbulenceState where
  k : TurbulentKineticEnergy
  epsilon : DissipationRate
  production : ℝ
  viscosityTurbulent : ℝ

def turbulentViscosity (Cmu : ℝ) (k : TurbulentKineticEnergy) (epsilon : DissipationRate) : ℝ :=
  Cmu * k^2 / epsilon

def productionTerm (νt : ℝ) (S : ℝ) : ℝ :=
  νt * S^2

structure TurbulenceModelClosed (state : TurbulenceState) (Cmu : ℝ) (S : ℝ) : Prop :=
  viscosityCorrect : state.viscosityTurbulent = turbulentViscosity Cmu state.k state.epsilon
  productionCorrect : state.production = productionTerm state.viscosityTurbulent S

def primitiveTurbulenceState : TurbulenceState :=
  { k := 1.0, epsilon := 0.1, production := 10.0, viscosityTurbulent := 10.0 }

theorem primitive_viscosity_correct : primitiveTurbulenceState.viscosityTurbulent = turbulentViscosity 0.09 primitiveTurbulenceState.k primitiveTurbulenceState.epsilon := by
  native_decide

theorem primitive_production_correct : primitiveTurbulenceState.production = productionTerm primitiveTurbulenceState.viscosityTurbulent 1.0 := by
  native_decide

def primitiveTurbulenceModelClosed : TurbulenceModelClosed primitiveTurbulenceState 0.09 1.0 :=
  { viscosityCorrect := primitive_viscosity_correct, productionCorrect := primitive_production_correct }

end ChemicalEngineeringFluidMechanicsChemical
end HautevilleHouse
