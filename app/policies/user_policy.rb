class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.present?
  end

  def create?
    user.present? && user.has_role?(:admin) || user.has_role?(:carrier_development)
  end

  def update?
    user.present? && user.has_role?(:admin) || user.has_role?(:carrier_development)
    # user.present? && record.id == user.id
  end

  def destroy?
    user.present? && user.has_role?(:admin) || user.has_role?(:carrier_development)
    # user.present? && record.id == user.id
  end


  private

    def user_record
      record
    end
end
