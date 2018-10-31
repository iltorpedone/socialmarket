require "administrate/field/base"

class EnumField < Administrate::Field::Base
  class Option < Struct.new(:key, :label); end

  def to_s
    I18n.t("enums.#{data}")
  end

  def self.searchable?
    true
  end

  def selectable_options
    collection
  end

  private

  def collection
    @collection ||= mapping.keys.map do |key|
      Option.new(key, I18n.t("enums.#{key}"))
    end
  end

  def mapping
    options.fetch(:mapping, {})
  end
end
