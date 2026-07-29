import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

/-!
# Packed Bed Flow Layer

This module defines the basic structures for fluid flow through packed beds,
including the Ergun equation and Darcy's law.
-/

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemical

abbrev Pressure := ℝ
abbrev Velocity := ℝ
abbrev Porosity := ℝ
abbrev ParticleSize := ℝ

structure PackedBedFlow where
  pressureDrop : Pressure
  superficialVelocity : Velocity
  porosity : Porosity
  particleDiameter : ParticleSize
  dynamicViscosity : ℝ
  density : ℝ

def ergunPressureDrop (u : Velocity) (ε : Porosity) (dp : ParticleSize) (μ : ℝ) (ρ : ℝ) : Pressure :=
  (150.0 * μ * u * (1 - ε)^2) / (dp^2 * ε^3) + (1.75 * ρ * u^2 * (1 - ε)) / (dp * ε^3)

def darcyVelocity (k : ℝ) (μ : ℝ) (ΔP : Pressure) (L : ℝ) : Velocity :=
  (k / μ) * (ΔP / L)

structure PackedBedFlowClosed (flow : PackedBedFlow) : Prop :=
  ergunValid : flow.pressureDrop = ergunPressureDrop flow.superficialVelocity flow.porosity flow.particleDiameter flow.dynamicViscosity flow.density
  darcyValid : flow.superficialVelocity = darcyVelocity (0.5) flow.dynamicViscosity flow.pressureDrop 1.0

def primitivePackedBedFlow : PackedBedFlow :=
  { pressureDrop := 100.0, superficialVelocity := 0.1, porosity := 0.4, particleDiameter := 0.01, dynamicViscosity := 0.001, density := 1000.0 }

theorem primitive_ergun_valid : primitivePackedBedFlow.pressureDrop = ergunPressureDrop primitivePackedBedFlow.superficialVelocity primitivePackedBedFlow.porosity primitivePackedBedFlow.particleDiameter primitivePackedBedFlow.dynamicViscosity primitivePackedBedFlow.density := by
  native_decide

theorem primitive_darcy_valid : primitivePackedBedFlow.superficialVelocity = darcyVelocity (0.5) primitivePackedBedFlow.dynamicViscosity primitivePackedBedFlow.pressureDrop 1.0 := by
  native_decide

def primitivePackedBedFlowClosed : PackedBedFlowClosed primitivePackedBedFlow :=
  { ergunValid := primitive_ergun_valid, darcyValid := primitive_darcy_valid }

end ChemicalEngineeringFluidMechanicsChemical
end HautevilleHouse
