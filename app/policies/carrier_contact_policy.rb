class CarrierContactPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.present?
  end

  def create?
    user.present? && (user.has_role?(:admin) || user.ro || user.cs)
  end

  def update?
    return true if user.present? && (record.carrier.relationship_owner_user == user.id || user.has_role?(:admin))
  end

  def destroy?
    return true if user.present? && (record.carrier.relationship_owner_user == user.id || user.has_role?(:admin))
  end
  
  private

    def carrier_contact
      record
    end
end
