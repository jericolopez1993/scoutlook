class CarrierContactPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.present? && (user.has_role?(:admin) || user.has_role?(:steward))
  end

  def create?
    user.present? && (user.has_role?(:admin) || user.has_role?(:steward))
  end

  def update?
    return true if (user.has_role?(:admin) || user.has_role?(:steward))
  end

  def destroy?
    return true if (user.has_role?(:admin) || user.has_role?(:steward))
  end

  private

    def carrier_contact
      record
    end
end
