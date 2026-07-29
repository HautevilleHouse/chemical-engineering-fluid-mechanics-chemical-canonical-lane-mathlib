import ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean.FluidAnalyticCertificate

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean

def FluidAdmittedAnalyticClosure : Prop :=
  FluidAnalyticCertificateClosed sourceFluidAnalyticCertificate ∧
  ConstrainedTheoremClosure analyticAdmissibleClass

def UnrestrictedClassicalFluidBoundaryCarried : Prop :=
  formalizationCertificate.theoremBoundaryOpen = true ∧
  mathlibPDESubstrate.unrestrictedNavierStokesStackCarried = true

theorem fluid_admitted_analytic_closure_checked :
    FluidAdmittedAnalyticClosure := by
  exact And.intro source_fluid_analytic_certificate_closed
    (constrained_theorem_closure analyticAdmissibleClass)

theorem unrestricted_classical_fluid_boundary_carried_checked :
    UnrestrictedClassicalFluidBoundaryCarried := by
  exact And.intro rfl rfl

end ChemicalEngineeringFluidMechanicsChemicalCanonicalLaneLean
end HautevilleHouse