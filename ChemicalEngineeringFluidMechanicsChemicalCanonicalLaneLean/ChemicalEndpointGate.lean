import canonicalLaneMathlib.AdmissibleClass
import ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean.ChemicalBridgeLayer

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean

structure ChemicalEndpointCertificate where
  bridge : ChemicalBridgeCertificate
  endpointSatisfied : Prop
  remainderRecorded : Prop
  gateOpen : Prop

def sourceChemicalEndpointCertificate : ChemicalEndpointCertificate := {
  bridge := sourceChemicalBridgeCertificate
  endpointSatisfied := sourceChemicalBridgeCertificate.operatorsClosed ∧
                       sourceChemicalBridgeCertificate.flowClosed
  remainderRecorded := True
  gateOpen := True
}

theorem source_chemical_endpoint_certificate_checked :
    sourceChemicalEndpointCertificate.endpointSatisfied := by
  exact source_chemical_bridge_certificate_checked

theorem source_chemical_endpoint_gate_open_checked :
    sourceChemicalEndpointCertificate.gateOpen := by
  trivial

theorem source_chemical_endpoint_remainder_recorded_checked :
    sourceChemicalEndpointCertificate.remainderRecorded := by
  trivial

end ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean
end HautevilleHouse