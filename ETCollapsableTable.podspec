Pod::Spec.new do |spec|
  spec.name = "ETCollapsableTable"
  spec.version = "0.1.6"
  spec.summary = "Easy to use table view with collapsable sections."
  spec.homepage = "https://github.com/EugeneTrapeznikov/ETCollapsableTable"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Eugene Trapeznikov" => 'evgtrapeznikov@gmail.com' }
  spec.social_media_url = "http://twitter.com/etrapeznikov"
  spec.platform = :ios, "8.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/EugeneTrapeznikov/ETCollapsableTable.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "Source/**/*.{h,swift}"
end
