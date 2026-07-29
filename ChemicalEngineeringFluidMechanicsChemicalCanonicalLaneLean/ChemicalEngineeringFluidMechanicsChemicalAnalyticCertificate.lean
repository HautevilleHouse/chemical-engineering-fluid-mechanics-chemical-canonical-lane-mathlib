import ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean.RegularityEndpointLayer

/-!
# Fluid Mechanics Analytic Certificate

This module packages the local analytic flow layer into one proof-carrying
certificate. The certificate is native Lean data with evidence terms for every
field in the admitted lane.
-/

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean

structure NavierStokesAnalyticCertificate where
  substrate : MathlibPDESubstrate
  operatorsClosed : Prop
  weakLayerClosed : Prop
  energyLayerClosed : Prop
  compactnessLayerClosed : Prop
  endpointLayerClosed : Prop
  canonicalCarriageImported : Prop
  operatorsClosedProof : operatorsClosed
  weakLayerClosedProof : weakLayerClosed
  energyLayerClosedProof : energyLayerClosed
  compactnessLayerClosedProof : compactnessLayerClosed
  endpointLayerClosedProof : endpointLayerClosed
  canonicalCarriageImportedProof : canonicalCarriageImported

def sourceNavierStokesAnalyticCertificate : NavierStokesAnalyticCertificate := {
  substrate := mathlibPDESubstrate
  operatorsClosed := NavierStokesEquationClosed primitiveFluidFlow
  weakLayerClosed := LerayHopfEnvelopeClosed sourceLerayHopfEnvelope
  energyLayerClosed := EnergyEnstrophyClosed sourceEnergyEnstrophyCertificate
  compactnessLayerClosed := CompactnessRigidityClosed sourceCompactnessRigidityCertificate
  endpointLayerClosed := RegularityEndpointClosed sourceRegularityEndpointCertificate
  canonicalCarriageImported := commonCoreProjectionLawAvailable ∧ commonCoreCarriageLawAvailable ∧ commonCoreIdempotenceAvailable
  operatorsClosedProof := primitive_flow_equation_closed_checked
  weakLayerClosedProof := source_leray_hopf_envelope_closed
  energyLayerClosedProof := source_energy_enstrophy_closed
  compactnessLayerClosedProof := source_compactness_rigidity_closed
  endpointLayerClosedProof := source_regularity_endpoint_closed
  canonicalCarriageImportedProof := And.intro mathlib_common_core_projection_law_checked
    (And.intro mathlib_common_core_carriage_law_checked mathlib_common_core_idempotence_checked)
}

def NavierStokesAnalyticCertificateClosed (C : NavierStokesAnalyticCertificate) : Prop :=
  C.operatorsClosed ∧
  C.weakLayerClosed ∧
  C.energyLayerClosed ∧
  C.compactnessLayerClosed ∧
  C.endpointLayerClosed ∧
  C.canonicalCarriageImported

theorem source_navier_stokes_analytic_certificate_closed :
    NavierStokesAnalyticCertificateClosed sourceNavierStokesAnalyticCertificate := by
  exact And.intro sourceNavierStokesAnalyticCertificate.operatorsClosedProof
    (And.intro sourceNavierStokesAnalyticCertificate.weakLayerClosedProof
      (And.intro sourceNavierStokesAnalyticCertificate.energyLayerClosedProof
        (And.intro sourceNavierStokesAnalyticCertificate.compactnessLayerClosedProof
          (And.intro sourceNavierStokesAnalyticCertificate.endpointLayerClosedProof
            sourceNavierStokesAnalyticCertificate.canonicalCarriageImportedProof))))

end ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean
end HautevilleHouse