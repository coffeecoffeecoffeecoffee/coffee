module HaveJsonForMatchers
  def have_json_for(resource, options)
    json = json_for(resource, options)
    RSpec::Matchers::BuiltIn::Eq.new(json)
  end

  private

  def json_for(object, options)
    hash_for(object, options).to_json
  end

  def hash_for(object, options)
    return object.map { |o| hash_for(o, options) } if object.is_a?(Enumerable)

    object.serializable_hash(options)
  end
end
