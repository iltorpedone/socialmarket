# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_admin
  User.find_or_create_by!(email: 'elliot@fsociety.org') do |user|
    user.full_name = 'Elliot Alderson'
    user.password = 'Mr.Robot'
    user.app_role = :administrator
    user.is_active = true
  end
end

def create_shop
  User.find_or_create_by!(email: 'shoppy@evilcorp.com') do |user|
    user.full_name = 'Shoppy'
    user.password = 'Mr.Robot'
    user.app_role = :shop
    user.is_active = true
  end
end

def create_provider
  user = User.find_or_create_by!(email: 'providence@darkarmy.ch') do |user|
    user.full_name = 'Providence'
    user.password = '#FFF.r0s3'
    user.app_role = :provider
    user.is_active = true
  end
  provider = Provider.find_or_create_by!(email: user.email) do |provider|
    provider.name = user.full_name
    provider.user = user
  end
end

create_admin
create_shop
create_provider
