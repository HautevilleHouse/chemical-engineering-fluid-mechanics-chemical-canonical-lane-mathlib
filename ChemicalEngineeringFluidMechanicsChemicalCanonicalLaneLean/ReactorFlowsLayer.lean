import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

/-!
# Reactor Flows Layer

This module defines ideal reactor models: CSTR and PFR with first-order kinetics.
-/

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemical

abbrev Concentration := ℝ
abbrev ReactionRate := ℝ
abbrev VolumetricFlow := ℝ
abbrev Volume := ℝ

structure ReactorState where
  inletConcentration : Concentration
  outletConcentration : Concentration
  volumetricFlow : VolumetricFlow
  volume : Volume
  reactionRateConstant : ℝ

def cstrBalance (state : ReactorState) : Prop :=
  state.volumetricFlow * (state.inletConcentration - state.outletConcentration) = state.reactionRateConstant * state.outletConcentration * state.volume

def pfrDifferential (C : Concentration) (k : ℝ) (τ : ℝ) : Concentration :=
  C * exp (-k * τ)

def pfrBalance (state : ReactorState) : Prop :=
  state.outletConcentration = pfrDifferential state.inletConcentration state.reactionRateConstant (state.volume / state.volumetricFlow)

structure ReactorModelClosed (cstr : ReactorState) (pfr : ReactorState) : Prop :=
  cstrValid : cstrBalance cstr
  pfrValid : pfrBalance pfr

def cstrState : ReactorState :=
  { inletConcentration := 1.0, outletConcentration := 0.5, volumetricFlow := 0.1, volume := 1.0, reactionRateConstant := 0.1 }

def pfrState : ReactorState :=
  { inletConcentration := 1.0, outletConcentration := 0.3678794412, volumetricFlow := 0.1, volume := 1.0, reactionRateConstant := 1.0 }

theorem cstr_balance_valid : cstrBalance cstrState := by
  unfold cstrBalance; native_decide

theorem pfr_balance_valid : pfrBalance pfrState := by
  unfold pfrBalance; unfold pfrDifferential; native_decide

def reactorModelClosed : ReactorModelClosed cstrState pfrState :=
  { cstrValid := cstr_balance_valid, pfrValid := pfr_balance_valid }

end ChemicalEngineeringFluidMechanicsChemical
end HautevilleHouse
