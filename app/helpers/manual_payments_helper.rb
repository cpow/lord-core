module ManualPaymentsHelper
  def tenants_for_unit(unit)
    tenants = unit.residencies.map(&:user)
    tenants.map { |t| [t.email, t.id.to_s] }
  end
end
