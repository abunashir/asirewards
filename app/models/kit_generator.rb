class KitGenerator
  attr_reader :length

  def initialize(length:)
    @length = length
  end

  def code
    generate_new_kit_code
  end

  private

  def generate_new_kit_code
    loop do
      kit_code = generate_new_code
      break kit_code unless Kit.exists?(code: kit_code)
    end
  end

  def generate_new_code
    charset = %w(2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z)
    (0...length).map{ charset.to_a[rand(charset.size)] }.join
  end
end
