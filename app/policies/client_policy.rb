class ClientPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.present? && user.has_role?(:admin)
  end

  def create?
    user.present? && user.has_role?(:admin)
  end

  def update?
    return true if user.present? && user.has_role?(:admin)
  end

  def destroy?
    return true if user.present? && user.has_role?(:admin)
  end

  private

    def client
      record
    end
end
