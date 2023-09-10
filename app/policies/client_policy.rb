class ClientPolicy < ApplicationPolicy
  def edit?
    user_is_owner?
  end

  def update?
    user_is_owner?
  end

  def show?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  def create?
    user.client?
  end

  private

  def user_is_owner?
    record.user == user
  end
end
