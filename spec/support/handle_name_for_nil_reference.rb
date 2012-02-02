require 'rspec/rails'

RSpec::Matchers.define :handle_name_for_nil_reference do |ref|
  match do |object|
    ref = ref.to_s
    ref_object = object.send( 'build_' + ref, name: 'abc' )

    begin
      object.send( ref + '=', ref_object )
      raise 'incorrect value' if object.send(ref + '_name') != 'abc'

      object.send( ref + '=', nil )
      raise 'nil not handled' if object.send(ref + '_name') != nil
      true
    rescue RuntimeError
      false
    end
  end

  failure_message_for_should do |object|
    "expected that #{object.class}.#{ref}_name would return nil when #{ref} is nil"
  end

  failure_message_for_should_not do |object|
    "expected that #{object.class}.#{ref}_name would fail when #{ref} is nil"
  end

  description do
    "return nil for #{ref}_name when #{ref} is nil"
  end
end
