class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.present?
  end

  def create?
    user.present? && user.has_role?(:admin)
  end

  def update?
    user.present? && record.id == user.id
  end

  def destroy?
    user.present? && record.id == user.id
  end


  private

    def user_record
      record
    end
end
