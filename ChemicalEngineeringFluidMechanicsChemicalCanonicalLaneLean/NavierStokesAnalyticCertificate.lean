import ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean.RegularityEndpointLayer

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean

structure FluidAnalyticCertificate where
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

def sourceFluidAnalyticCertificate : FluidAnalyticCertificate := {
  substrate := mathlibPDESubstrate
  operatorsClosed := NavierStokesEquationClosed primitiveFlow
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

def FluidAnalyticCertificateClosed (C : FluidAnalyticCertificate) : Prop :=
  C.operatorsClosed ∧
  C.weakLayerClosed ∧
  C.energyLayerClosed ∧
  C.compactnessLayerClosed ∧
  C.endpointLayerClosed ∧
  C.canonicalCarriageImported

theorem source_fluid_analytic_certificate_closed :
    FluidAnalyticCertificateClosed sourceFluidAnalyticCertificate := by
  exact And.intro sourceFluidAnalyticCertificate.operatorsClosedProof
    (And.intro sourceFluidAnalyticCertificate.weakLayerClosedProof
      (And.intro sourceFluidAnalyticCertificate.energyLayerClosedProof
        (And.intro sourceFluidAnalyticCertificate.compactnessLayerClosedProof
          (And.intro sourceFluidAnalyticCertificate.endpointLayerClosedProof
            sourceFluidAnalyticCertificate.canonicalCarriageImportedProof))))

end ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean
end HautevilleHouse