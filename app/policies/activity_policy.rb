class ActivityPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.present?
  end

  def create?
    user.present? && (user.has_role?(:admin)  || user.ro || user.cs)
  end

  def update?
    return true if user.present? && (user.has_role?(:admin)  || user.ro || user.cs)
  end

  def destroy?
    return true if user.present? && (user.has_role?(:admin)  || user.ro || user.cs)
  end

  def generate_pdf?
    return true if user.present? && (user.has_role?(:admin)  || user.ro || user.cs)
  end

  private

    def activity
      record
    end
end
