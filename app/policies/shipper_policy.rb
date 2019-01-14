class ShipperPolicy < ApplicationPolicy
  def index?
    return true
  end

  def show?
    user.present?
  end

  def create?
    user.present? && (user.has_role?(:admin)  || user.ro || user.cs)
  end

  def update?
    return true
  end

  def destroy?
    return true if user.present? && (user.has_role?(:admin)  || user.ro || user.cs)
  end

  def remove_attachment?
    user.present? && (user.has_role?(:admin)  || user.ro || user.cs)
  end

  private

    def shipper
      record
    end
end
