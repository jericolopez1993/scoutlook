class CarrierLocationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.present?
  end

  def create?
    user.present? && (user.has_role?(:admin) || user.has_role?(:carrier_development) || user.ro || user.cs)
  end

  def update?
    return true if user.present? && (record.carrier.relationship_owner == user.id || user.has_role?(:admin) || user.has_role?(:carrier_development))
  end

  def destroy?
    return true if user.present? && (record.carrier.relationship_owner == user.id || user.has_role?(:admin) || user.has_role?(:carrier_development))
  end

  private

    def carrier_location
      record
    end
end
