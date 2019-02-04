require "administrate/field/base"

class DateField < Administrate::Field::Base
  def date
    I18n.localize(
      data.in_time_zone(timezone).to_date,
      format: format,
    )
  end

  private

  def timezone
    options.fetch(:timezone, ::Time.zone.name || "UTC")
  end

  def format
    options.fetch(:format, :default)
  end
end
