class ReminderPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.present?
  end

  def create?
    user.present? && (user.has_role?(:admin) || user.has_role?(:carrier_development) || user.ro || user.cs)
  end

  def update?
    return true if user.present? && (user.has_role?(:admin) || (user.has_role?(:carrier_development) && reminder.user_id == user.id))
  end

  def destroy?
    return true if user.present? && (user.has_role?(:admin) || (user.has_role?(:carrier_development) && reminder.user_id == user.id))
  end

  private
    def reminder
      record
    end

end
