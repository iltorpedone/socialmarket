require "administrate/field/base"

class AppRoleField < Administrate::Field::Base
  class Option < Struct.new(:key, :label); end

  def to_s
    I18n.t("app_roles.#{data}")
  end

  def self.searchable?
    true
  end

  def selectable_options
    collection
  end

  private

  def collection
    @collection ||= User.app_roles.keys.map do |key|
      Option.new(key, I18n.t("app_roles.#{key}"))
    end
  end
end
