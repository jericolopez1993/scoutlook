class CarrierPolicy < ApplicationPolicy
  def index?
    return true
  end

  def show?
    user.present?
  end

  def create?
    user.present?
  end

  def update?
    return true if  user.present? && (record.relationship_owner == user.id || user.has_role?(:admin) || user.has_role?(:carrier_development))
  end

  def destroy?
    return true if user.present? && (record.relationship_owner == user.id || user.has_role?(:admin) || user.has_role?(:carrier_development))
  end

  def remove_attachment?
    return true if user.present? && (record.relationship_owner == user.id || user.has_role?(:admin) || user.has_role?(:carrier_development))
  end

  private

    def carrier
      record
    end
end
