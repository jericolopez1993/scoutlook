class CarrierLocationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.present?
  end

  def create?
    user.present?
  end

  def update?
    return true
  end

  def destroy?
    return true
  end

  private

    def carrier_location
      record
    end
end
