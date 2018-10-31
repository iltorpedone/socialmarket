require "administrate/field/base"

class GenderField < Administrate::Field::Base
  class Option < Struct.new(:key, :label); end

  def to_s
    I18n.t("genders.#{data}")
  end

  def self.searchable?
    true
  end

  def selectable_options
    collection
  end

  private

  def collection
    @collection ||= Beneficiary.genders.keys.map do |key|
      Option.new(key, I18n.t("genders.#{key}"))
    end
  end
end
