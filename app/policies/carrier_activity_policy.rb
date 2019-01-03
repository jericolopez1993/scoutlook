class CarrierActivityPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.present? && (user.has_role?(:admin) || user.has_role?(:steward) || user.ro || user.cs)
  end

  def create?
    user.present? && (user.has_role?(:admin) || user.has_role?(:steward) || user.ro || user.cs)
  end

  def update?
    return true if user.present? && (user.has_role?(:admin) || user.has_role?(:steward) || user.ro || user.cs)
  end

  def destroy?
    return true if user.present? && (user.has_role?(:admin) || user.has_role?(:steward) || user.ro || user.cs)
  end

  private

    def carrier_activity
      record
    end
end
