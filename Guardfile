guard 'test' do
  watch(%r{^lib/(?:[^/]+/)*([^/]+)\.rb$}) { |m|  "test/unit/test_#{m[1]}.rb" }
  watch(%r{^test/unit/test_.+\.rb$})
  watch('test/helper.rb')  { "test" }
end
