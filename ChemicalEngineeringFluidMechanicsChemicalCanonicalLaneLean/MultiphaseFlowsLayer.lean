import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

/-!
# Multiphase Flows Layer

This module defines drift-flux model for multiphase flow, including slip velocity.
-/

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemical

abbrev PhaseVelocity := ℝ
abbrev PhaseFraction := ℝ
abbrev MixtureVelocity := ℝ
abbrev DriftVelocity := ℝ

structure MultiphaseState where
  gasFraction : PhaseFraction
  liquidFraction : PhaseFraction
  gasVelocity : PhaseVelocity
  liquidVelocity : PhaseVelocity
  mixtureVelocity : MixtureVelocity
  driftVelocity : DriftVelocity

def mixtureVelocity (ug : PhaseVelocity) (ul : PhaseVelocity) (αg : PhaseFraction) (αl : PhaseFraction) : MixtureVelocity :=
  αg * ug + αl * ul

def driftFlux (αg : PhaseFraction) (ug : PhaseVelocity) (um : MixtureVelocity) : DriftVelocity :=
  αg * (ug - um)

structure MultiphaseClosed (state : MultiphaseState) : Prop :=
  mixtureCorrect : state.mixtureVelocity = mixtureVelocity state.gasVelocity state.liquidVelocity state.gasFraction state.liquidFraction
  driftCorrect : state.driftVelocity = driftFlux state.gasFraction state.gasVelocity state.mixtureVelocity

def primitiveMultiphaseState : MultiphaseState :=
  { gasFraction := 0.3, liquidFraction := 0.7, gasVelocity := 2.0, liquidVelocity := 1.0, mixtureVelocity := 1.3, driftVelocity := 0.21 }

theorem primitive_mixture_correct : primitiveMultiphaseState.mixtureVelocity = mixtureVelocity primitiveMultiphaseState.gasVelocity primitiveMultiphaseState.liquidVelocity primitiveMultiphaseState.gasFraction primitiveMultiphaseState.liquidFraction := by
  native_decide

theorem primitive_drift_correct : primitiveMultiphaseState.driftVelocity = driftFlux primitiveMultiphaseState.gasFraction primitiveMultiphaseState.gasVelocity primitiveMultiphaseState.mixtureVelocity := by
  native_decide

def primitiveMultiphaseClosed : MultiphaseClosed primitiveMultiphaseState :=
  { mixtureCorrect := primitive_mixture_correct, driftCorrect := primitive_drift_correct }

end ChemicalEngineeringFluidMechanicsChemical
end HautevilleHouse
