class ProviderPolicy < ApplicationPolicy
  def edit?
    user_is_owner?
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  def create?
    user_is_provider?
  end

  private

  def user_is_owner?
    record.user == user
  end

  def user_is_provider?
    user.role == "provider"
  end
end