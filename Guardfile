guard 'rspec', :cli => "--color --format documentation" do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^cli/(.+)\.rb})     { |m| "spec/cli/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { "spec" }
end