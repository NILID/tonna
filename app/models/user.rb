class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :recoverable, :registerable
  devise :database_authenticatable, :rememberable, :validatable

  ROLES = %w[guest user admin].freeze

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def self.with_role(role)
    where('roles_mask & ? > 0', 2**ROLES.index(role.to_s))
  end

  def role?(role)
    roles.include? role.to_s
  end
end
