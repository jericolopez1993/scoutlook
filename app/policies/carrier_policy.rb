class CarrierPolicy < ApplicationPolicy
  def index?
    return true && (user.has_role?(:admin) || user.has_role?(:steward) || user.ro || user.cs)
  end

  def show?
    user.present?
  end

  def create?
    user.present? && (user.has_role?(:admin) || user.has_role?(:steward) || user.ro || user.cs)
  end

  def update?
    return true
  end

  def destroy?
    return true if user.present? && (user.has_role?(:admin) || user.has_role?(:steward) || user.ro || user.cs)
  end

  def remove_attachment?
    user.present? && (user.has_role?(:admin) || user.has_role?(:steward) || user.ro || user.cs)
  end

  private

    def carrier
      record
    end
end
