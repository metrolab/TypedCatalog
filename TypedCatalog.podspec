Pod::Spec.new do |s|
  s.name     = 'TypedCatalog'
  s.version  = '0.1.0'
  s.summary  = 'Code generator for strong-typed asset catalogs.'
  s.homepage = 'https://github.com/metrolab/Unstringify'
  s.license  = 'MIT'
  s.author   = { 'metrolab' => 'hello@metropolis-lab.io' }
  s.source   = { :http => "https://github.com/metrolab/TypedCatalog/releases/download/#{s.version}/TypedCatalog-#{s.version}.zip" }

  s.preserve_paths = '*'
  s.exclude_files  = '**/file.zip'
end

