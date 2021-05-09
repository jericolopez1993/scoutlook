class DashboardPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.present? && user.has_role?(:admin) || user.has_role?(:carrier_development)
  end

  def create?
    user.present? && user.has_role?(:admin) || user.has_role?(:carrier_development)
  end

  def update?
    return true if user.present? && user.has_role?(:admin) || user.has_role?(:carrier_development)
  end

  def destroy?
    return true if user.present? && user.has_role?(:admin) || user.has_role?(:carrier_development)
  end

  private

    def client
      record
    end
end
